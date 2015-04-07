//
//  ViewController.swift
//  tippy
//
//  Created by Tianwei Liu on 4/7/15.
//  Copyright (c) 2015 Tianwei Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipPercentagesControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "18%"
        tipPercentagesControl.selectedSegmentIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didEditBill(sender: AnyObject) {
        let tipPercentages = [0.18, 0.22, 0.25]
        var billAmount = (billField.text as NSString).doubleValue
        var tipPercentage = tipPercentages[tipPercentagesControl.selectedSegmentIndex]
        tipLabel.text = String(format: "%.2f", tipPercentage * 100.0) + "%"
        totalLabel.text = String(format: "%.2f", (tipPercentage * billAmount + billAmount))
    }

    @IBAction func billEditDidBegin(sender: AnyObject) {
        if billField.text == "0.00" {
            billField.text = ""
        }
    }

    @IBAction func didTapOutsideBillField(sender: AnyObject) {
        view.endEditing(true)
    }
}

