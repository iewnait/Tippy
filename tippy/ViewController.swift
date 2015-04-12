//
//  ViewController.swift
//  tippy
//
//  Created by Tianwei Liu on 4/7/15.
//  Copyright (c) 2015 Tianwei Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var tipNavigationItem: UINavigationItem!

    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var scrollProgressBar: UIProgressView!
    
    @IBOutlet weak var splitIconLabel1: UILabel!
    @IBOutlet weak var splitIconLabel2: UILabel!
    @IBOutlet weak var splitIconLabel3: UILabel!
    
    @IBOutlet weak var splitAmountLabel1: UILabel!
    @IBOutlet weak var splitAmountLabel2: UILabel!
    @IBOutlet weak var splitAmountLabel3: UILabel!

    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var plusSignLabel: UILabel!
    @IBOutlet weak var equalSignLabel: UILabel!
    @IBOutlet weak var dismissKeyboardView: UIView!
    
    var colorPanel:UIView = UIView(frame: UIScreen.mainScreen().bounds)
    
    let billFieldInitialFrameOriginY:CGFloat = 190.0
    let colorPanelInitialFrameHeight:CGFloat = UIScreen.mainScreen().bounds.height
    
    let billFieldEditingFrameOriginY:CGFloat = 60.0
    let colorPanelEditingFrameHeight:CGFloat = UIScreen.mainScreen().bounds.height * 0.333
    
    var tipLabelInitialFrameOriginY:CGFloat = 0.0
    var tipLabelEditingFrameOriginY:CGFloat = 0.0

    var totalLabelInitialFrameOriginY:CGFloat = 0.0
    var totalLabelEditingFrameOriginY:CGFloat = 0.0
    
    var plusSignLabelInitialFrameOriginY:CGFloat = 0.0
    var plusSignLabelEditingFrameOriginY:CGFloat = 0.0

    var equalSignLabelInitialFrameOriginY:CGFloat = 0.0
    var equalSignLabelEditingFrameOriginY:CGFloat = 0.0

    var tipAmountLabelInitialFrameOriginY:CGFloat = 0.0
    var tipAmountLabelEditingFrameOriginY:CGFloat = 0.0

    var scrollProgressBarInitialFrameOriginY:CGFloat = 0.0
    var scrollProgressBarEditingFrameOriginY:CGFloat = 0.0
    
    var totalAmountValue:Double = 0.0
    var tipPercentValue:Double = 0.0
    var tipPercentMaxValue:Double = 0
    var tipPercentMinValue:Double = 0
    var splitAmountUserCount1:Int = 3
    var splitAmountUserCount2:Int = 4
    var splitAmountUserCount3:Int = 5
    var tipPercentLastChange = 0.0
    var splitUserCountLastChange = 0.0
    
    let storageHelper: SimpleStorage = SimpleStorage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup initial values
        let shiftValue = billFieldInitialFrameOriginY - billFieldEditingFrameOriginY
        tipLabelInitialFrameOriginY = self.tipLabel.frame.origin.y + shiftValue
        tipLabelEditingFrameOriginY = self.tipLabel.frame.origin.y

        totalLabelInitialFrameOriginY = self.totalLabel.frame.origin.y + shiftValue
        totalLabelEditingFrameOriginY = self.totalLabel.frame.origin.y

        plusSignLabelInitialFrameOriginY = self.plusSignLabel.frame.origin.y + shiftValue
        plusSignLabelEditingFrameOriginY = self.plusSignLabel.frame.origin.y

        equalSignLabelInitialFrameOriginY = self.equalSignLabel.frame.origin.y + shiftValue
        equalSignLabelEditingFrameOriginY = self.equalSignLabel.frame.origin.y

        tipAmountLabelInitialFrameOriginY = self.tipAmountLabel.frame.origin.y + shiftValue
        tipAmountLabelEditingFrameOriginY = self.tipAmountLabel.frame.origin.y
        
        scrollProgressBarInitialFrameOriginY = self.scrollProgressBar.frame.origin.y + shiftValue
        scrollProgressBarEditingFrameOriginY = self.scrollProgressBar.frame.origin.y

        // Split Icons
        splitIconLabel1.text = getPersonIconString(self.splitAmountUserCount1)
        splitIconLabel1.userInteractionEnabled = true
        splitIconLabel2.text = getPersonIconString(self.splitAmountUserCount2)
        splitIconLabel2.userInteractionEnabled = true
        splitIconLabel3.text = getPersonIconString(self.splitAmountUserCount3)
        splitIconLabel3.userInteractionEnabled = true        
        
        // Add dismiss keyboard gestures
        let dismissTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapToDismissKeyboard:"))
        dismissTapRecognizer.numberOfTapsRequired = 1
        dismissTapRecognizer.delegate = self
        self.dismissKeyboardView.addGestureRecognizer(dismissTapRecognizer)
        self.dismissKeyboardView.userInteractionEnabled = true
        
        // Add tap user count gestures
        let singleTapRecognizer1 = UITapGestureRecognizer(target: self, action: Selector("handleSingleTapGesture:"))
        singleTapRecognizer1.numberOfTapsRequired = 1
        singleTapRecognizer1.delegate = self
        self.splitIconLabel1.addGestureRecognizer(singleTapRecognizer1)

        let doubleTapRecognizer1 = UITapGestureRecognizer(target: self, action: Selector("handleDoubleTapGesture:"))
        doubleTapRecognizer1.numberOfTapsRequired = 2
        doubleTapRecognizer1.delegate = self
        self.splitIconLabel1.addGestureRecognizer(doubleTapRecognizer1)
        singleTapRecognizer1.requireGestureRecognizerToFail(doubleTapRecognizer1)

        let singleTapRecognizer2 = UITapGestureRecognizer(target: self, action: Selector("handleSingleTapGesture:"))
        singleTapRecognizer2.numberOfTapsRequired = 1
        singleTapRecognizer2.delegate = self
        self.splitIconLabel2.addGestureRecognizer(singleTapRecognizer2)
        
        let doubleTapRecognizer2 = UITapGestureRecognizer(target: self, action: Selector("handleDoubleTapGesture:"))
        doubleTapRecognizer2.numberOfTapsRequired = 2
        doubleTapRecognizer2.delegate = self
        self.splitIconLabel2.addGestureRecognizer(doubleTapRecognizer2)
        singleTapRecognizer2.requireGestureRecognizerToFail(doubleTapRecognizer2)

        let singleTapRecognizer3 = UITapGestureRecognizer(target: self, action: Selector("handleSingleTapGesture:"))
        singleTapRecognizer3.numberOfTapsRequired = 1
        singleTapRecognizer3.delegate = self
        self.splitIconLabel3.addGestureRecognizer(singleTapRecognizer3)
        
        let doubleTapRecognizer3 = UITapGestureRecognizer(target: self, action: Selector("handleDoubleTapGesture:"))
        doubleTapRecognizer3.numberOfTapsRequired = 2
        doubleTapRecognizer3.delegate = self
        self.splitIconLabel3.addGestureRecognizer(doubleTapRecognizer3)
        singleTapRecognizer3.requireGestureRecognizerToFail(doubleTapRecognizer3)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.placeholder = "$"

        // Subview
        var topRect = UIScreen.mainScreen().bounds
        
        self.colorPanel = UIView(frame: topRect)
        self.colorPanel.userInteractionEnabled = false
        
        // Get previous value
        var lastBillValue = self.storageHelper.getUserSetting(Constants.lastBillKey, defaultValue:"NA") as NSString
        if lastBillValue != "NA" {
            var lastTimeStamp = self.storageHelper.getUserSetting(Constants.lastBillTimeKey, defaultValue:"NA")
            let date = NSDate()
            let timestamp = String(format: "%f", date.timeIntervalSince1970)
            var timedelta = (timestamp as NSString).doubleValue - (lastTimeStamp as NSString).doubleValue
            // Retain value if < 5 mins
            if (timedelta <= 60 * 5 && lastBillValue != "" ) {
                self.billField.text = lastBillValue
                self.drawEditingStage()
                self.updateCalculation()
                self.updatePanelColor()
            }
            else {
                // DrawInitialStage
                drawInitialStage()
            }
        }
        else {
            // DrawInitialStage
            drawInitialStage()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didEditBill(sender: AnyObject) {
        var billFieldAsString = billField.text as NSString
        // Does not allow empty string
        if billFieldAsString == "" {
            UIView.animateWithDuration(0.4, animations: {
                self.drawInitialStage()
            })
        }
        else {
            // Cap value at 9999
            if billFieldAsString.doubleValue > 9999 {
                billFieldAsString = "9999"
            }
            // Remove $ sign and animate upwards
            billField.text = billFieldAsString
            if billFieldAsString.length == 1 {
                UIView.animateWithDuration(0.4, animations: {
                    self.drawEditingStage()
                })
            }
        }

        // Saving Value
        self.storageHelper.saveUserSetting(Constants.lastBillKey, value: billFieldAsString)
        let date = NSDate()
        let timestamp = date.timeIntervalSince1970
        self.storageHelper.saveUserSetting(Constants.lastBillTimeKey, value: String(format: "%f", timestamp))

        self.updateCalculation()
        self.updatePanelColor()
    }

    func handleTapToDismissKeyboard(sender: AnyObject) {
        // Hide keyboard
        view.endEditing(true)
    }

    @IBAction func handleTotalAmountLabelPanGesture(recognizer: UIPanGestureRecognizer) {
        // Hide keyboard
        view.endEditing(true)
        
        var translation:CGPoint = recognizer.translationInView(self.view)
        if (recognizer.state == UIGestureRecognizerState.Began) {
            // Reset last change
            self.tipPercentLastChange = 0.0
        } else if (recognizer.state == UIGestureRecognizerState.Changed) {
            // Calculate delta changes
            var delta = (Double(translation.x) - self.tipPercentLastChange) / 500.0
            self.tipPercentLastChange = Double(translation.x)
            self.tipPercentValue = self.tipPercentValue + delta

            if self.tipPercentValue > self.tipPercentMaxValue {
                self.tipPercentValue = self.tipPercentMaxValue
            }
            else if self.tipPercentValue < self.tipPercentMinValue {
                self.tipPercentValue = self.tipPercentMinValue
            }

            self.updateCalculation()
            self.updatePanelColor()
        } else {
            return;
        }
        
    }
    func capSplitUserCount() {
        if self.splitAmountUserCount1 > 6 {
           self.splitAmountUserCount1 = 6
        }
        if self.splitAmountUserCount2 > 6 {
            self.splitAmountUserCount2 = 6
        }
        if self.splitAmountUserCount3 > 6 {
            self.splitAmountUserCount3 = 6
        }
        if self.splitAmountUserCount1 < 2 {
            self.splitAmountUserCount1 = 2
        }
        if self.splitAmountUserCount2 < 2 {
            self.splitAmountUserCount2 = 2
        }
        if self.splitAmountUserCount3 < 2 {
            self.splitAmountUserCount3 = 2
        }
    }
    
    func updateSplitIcon() {
        self.splitIconLabel1.text = getPersonIconString(self.splitAmountUserCount1)
        self.splitIconLabel2.text = getPersonIconString(self.splitAmountUserCount2)
        self.splitIconLabel3.text = getPersonIconString(self.splitAmountUserCount3)
    }
    
    func handleSingleTapGesture(sender: UITapGestureRecognizer) {
        if sender.view == self.splitIconLabel1 {
            self.splitAmountUserCount1  = self.splitAmountUserCount1 + 1
        }
        else if sender.view == self.splitIconLabel2 {
            self.splitAmountUserCount2  = self.splitAmountUserCount2 + 1
        }
        else if sender.view == self.splitIconLabel3 {
            self.splitAmountUserCount3  = self.splitAmountUserCount3 + 1
        }
        else {
            return
        }
        self.capSplitUserCount()
        self.updateSplitIcon()
        self.updateCalculation()
    }

    func handleDoubleTapGesture(sender: UITapGestureRecognizer) {
        if sender.view == self.splitIconLabel1 {
            self.splitAmountUserCount1  = self.splitAmountUserCount1 - 1
        }
        else if sender.view == self.splitIconLabel2 {
            self.splitAmountUserCount2  = self.splitAmountUserCount2 - 1
        }
        else if sender.view == self.splitIconLabel3 {
            self.splitAmountUserCount3  = self.splitAmountUserCount3 - 1
        }
        else {
            return
        }
        self.capSplitUserCount()
        self.updateSplitIcon()
        self.updateCalculation()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Add color panel
        UIApplication.sharedApplication().keyWindow?.addSubview(self.colorPanel)
        UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(self.colorPanel)

//        println("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Set Min and Max tip
        self.tipPercentValue = Double(storageHelper.getUserSetting(Constants.TipDefaultKey, defaultValue: Constants.TipDefaultValue).toInt()!) / 100.0
        self.tipPercentMaxValue = Double(storageHelper.getUserSetting(Constants.TipMaximumKey, defaultValue: Constants.TipDefaultMaximumValue).toInt()!) / 100.0
        self.tipPercentMinValue = Double(storageHelper.getUserSetting(Constants.TipMinimumKey, defaultValue: Constants.TipDefaultMinimumValue).toInt()!) / 100.0
        
        self.updateCalculation()
        self.updatePanelColor()

        // Automatically launch keyboard
        billField.becomeFirstResponder()

//        println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.colorPanel.removeFromSuperview()        
//        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
//        println("view did disappear")
    }

    func updateCalculation() {
        var billFieldAsString = billField.text as NSString
        var billAmount = billFieldAsString.doubleValue
        if self.tipPercentValue == 0.0 {
            self.tipPercentValue = Double(storageHelper.getUserSetting(Constants.TipDefaultKey, defaultValue: "15").toInt()!) / 100.0
        }
        tipLabel.text = String(format: "%.2f", self.tipPercentValue * 100.0) + "%"
        self.totalAmountValue = self.tipPercentValue * billAmount + billAmount
        totalLabel.text = String(format: "$%.2f", self.totalAmountValue)
        tipAmountLabel.text = String(format: "$%.2f", self.tipPercentValue * billAmount)
        
        splitAmountLabel1.text = String(format: "$%.2f", self.getPersonSplitValue(self.splitAmountUserCount1))
        splitAmountLabel2.text = String(format: "$%.2f", self.getPersonSplitValue(self.splitAmountUserCount2))
        splitAmountLabel3.text = String(format: "$%.2f", self.getPersonSplitValue(self.splitAmountUserCount3))
    }

    func drawInitialStage() {
        println("drawInitialStage..")
        
        // Positioning billField
        var frame = self.billField.frame
        frame.origin.y = self.billFieldInitialFrameOriginY
        self.billField.frame = frame

        // Positioning color panel
        var colorPanelRect = UIScreen.mainScreen().bounds
        
        self.colorPanel.frame = colorPanelRect
        self.colorPanel.backgroundColor = UIColor(red: 0,
            green: 1,
            blue: 1,
            alpha: 0.5
        )

        var shiftUpDistance = self.billFieldInitialFrameOriginY - self.billFieldEditingFrameOriginY

        // Hide and position tipLabel
        frame = self.tipLabel.frame
        frame.origin.y = self.tipLabelInitialFrameOriginY
        self.tipLabel.frame = frame
        self.tipLabel.hidden = true
        
        // Hide and position totalAmount
        frame = self.totalLabel.frame
        frame.origin.y = self.totalLabelInitialFrameOriginY
        self.totalLabel.frame = frame
        self.totalLabel.hidden = true
        
        // Hide and position +, = and tipAmount
        frame = self.plusSignLabel.frame
        frame.origin.y = self.plusSignLabelInitialFrameOriginY
        self.plusSignLabel.frame = frame
        self.plusSignLabel.hidden = true
        
        frame = self.equalSignLabel.frame
        frame.origin.y = self.equalSignLabelInitialFrameOriginY
        self.equalSignLabel.frame = frame
        self.equalSignLabel.hidden = true

        frame = self.tipAmountLabel.frame
        frame.origin.y = self.tipAmountLabelInitialFrameOriginY
        self.tipAmountLabel.frame = frame
        self.tipAmountLabel.hidden = true
        
        // Hide UserSplitIcon and Label
        self.splitAmountLabel1.hidden = true
        self.splitIconLabel1.hidden = true
        self.splitAmountLabel2.hidden = true
        self.splitIconLabel2.hidden = true
        self.splitAmountLabel3.hidden = true
        self.splitIconLabel3.hidden = true

        // Hide scroll Progress bar
        frame = self.scrollProgressBar.frame
        frame.origin.y = self.scrollProgressBarInitialFrameOriginY
        self.scrollProgressBar.frame = frame
        self.scrollProgressBar.hidden = true
    }
    
    func drawEditingStage() {
        println("drawEditingStage..")
        // Positioning billField
        var frame = self.billField.frame
        frame.origin.y = self.billFieldEditingFrameOriginY
        self.billField.frame = frame
        
        // Positioning color panel
        var colorPanelRect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, self.colorPanelEditingFrameHeight)
        
        self.colorPanel.frame = colorPanelRect
        self.colorPanel.backgroundColor = UIColor(red: 0,
            green: 1,
            blue: 1,
            alpha: 0.5
        )

        // Show and position tipLabel
        frame = self.tipLabel.frame
        frame.origin.y = self.tipLabelEditingFrameOriginY
        self.tipLabel.frame = frame
        self.tipLabel.hidden = false
        
        // Show and position totalAmount
        frame = self.totalLabel.frame
        frame.origin.y = self.totalLabelEditingFrameOriginY
        self.totalLabel.frame = frame
        self.totalLabel.hidden = false
        
        // Show and position +, = and tipAmount
        plusSignLabel.hidden = false
        equalSignLabel.hidden = false
        tipAmountLabel.hidden = false

        frame = self.plusSignLabel.frame
        frame.origin.y = self.plusSignLabelEditingFrameOriginY
        self.plusSignLabel.frame = frame
        self.plusSignLabel.hidden = false
        
        frame = self.equalSignLabel.frame
        frame.origin.y = self.equalSignLabelEditingFrameOriginY
        self.equalSignLabel.frame = frame
        self.equalSignLabel.hidden = false
        
        frame = self.tipAmountLabel.frame
        frame.origin.y = self.tipAmountLabelEditingFrameOriginY
        self.tipAmountLabel.frame = frame
        self.tipAmountLabel.hidden = false
        
        // Show UserSplitIcon and Label
        self.splitAmountLabel1.hidden = false
        self.splitIconLabel1.hidden = false
        self.splitAmountLabel2.hidden = false
        self.splitIconLabel2.hidden = false
        self.splitAmountLabel3.hidden = false
        self.splitIconLabel3.hidden = false

        // Hide scroll Progress bar
        frame = self.scrollProgressBar.frame
        frame.origin.y = self.scrollProgressBarEditingFrameOriginY
        self.scrollProgressBar.frame = frame
        self.scrollProgressBar.hidden = false

    }
    
    func updatePanelColor() {
        var tipPercentMidpoint:CGFloat = (CGFloat((self.tipPercentMaxValue - self.tipPercentMinValue) / 2.0)) * 100.0
        var underMax:CGFloat = tipPercentMidpoint - CGFloat(self.tipPercentMinValue * 100.0)
        var overMax:CGFloat = CGFloat(self.tipPercentMaxValue * 100.0) - tipPercentMidpoint
        var tipPercentValue:CGFloat = CGFloat(self.tipPercentValue * 100.0)
        if (tipPercentValue > tipPercentMidpoint) {
            // Move toward Green
            var over:CGFloat = tipPercentValue - tipPercentMidpoint
            var blueValue = (1.0 - 1.0 / overMax * over)
            var color = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.5)

            self.colorPanel.backgroundColor = UIColor(red: 0.0,
                green: 1.0,
                blue: blueValue,
                alpha: 0.5
            )
            self.scrollProgressBar.setProgress(Float(0.5 + 0.5 / overMax * over), animated: true)
        }
        else {
            // Move toward Red
            var under:CGFloat = tipPercentMidpoint - tipPercentValue
            var redValue = 1.0 / underMax * under
            var greenBlueValue = 1.0 - (1.0 / underMax * under)
            self.colorPanel.backgroundColor = UIColor(red: redValue,
                green: greenBlueValue,
                blue: greenBlueValue,
                alpha: 0.5
            )
            self.scrollProgressBar.setProgress(Float(0.5 - 0.5 / underMax * under), animated: true)
        }

    }
    
    func getPersonIconString(noOfUser: Int) ->NSString {
        let onePersonIcon = "\u{f007}"
        let threePersonIcon = "\u{f0c0}"
        let lastPersonIcon = "\u{f234}"
        var iconString = ""
        // Save one for plusPersonIcon
        var userCount = noOfUser
        // Not allow to have less than 2 split
        if userCount < 2 {
            userCount = 2
        }

        for i in 1...(userCount) {
            if i == (userCount) {
                iconString = iconString + lastPersonIcon
            }
            else {
                iconString = iconString + onePersonIcon + " "
            }
        }

        return iconString
    }
    
    func getPersonSplitValue(noOfUser: Int) ->Double {
        return self.totalAmountValue / Double(noOfUser)
    }
}

