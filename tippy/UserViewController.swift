//
//  UserViewController.swift
//  tippy
//
//  Created by Tianwei Liu on 4/12/15.
//  Copyright (c) 2015 Tianwei Liu. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var minimumTextField: UITextField!
    @IBOutlet weak var defaultTextField: UITextField!
    @IBOutlet weak var maximumTextField: UITextField!
    
    let storageHelper: SimpleStorage = SimpleStorage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        minimumTextField.text = storageHelper.getUserSetting(Constants.TipMinimumKey, defaultValue: Constants.TipDefaultMinimumValue)
        maximumTextField.text = storageHelper.getUserSetting(Constants.TipMaximumKey, defaultValue: Constants.TipDefaultMaximumValue)
        defaultTextField.text = storageHelper.getUserSetting(Constants.TipDefaultKey, defaultValue: Constants.TipDefaultValue)
    }

    @IBAction func didChangeSettings(sender: UITextField) {
        if sender == self.minimumTextField {
            println("Saving minimumTextField")
            self.storageHelper.saveUserSetting(Constants.TipMinimumKey,value: sender.text as String)
        }
        else if sender == self.defaultTextField {
            println("Saving defaultTextField")
            self.storageHelper.saveUserSetting(Constants.TipDefaultKey,value: sender.text as String)
        }
        else if sender == self.maximumTextField {
            println("Saving maximumTextField")            
            self.storageHelper.saveUserSetting(Constants.TipMaximumKey,value: sender.text as String)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
