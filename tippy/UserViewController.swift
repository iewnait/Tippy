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
        var value = sender.text as String
        if sender == self.minimumTextField {
//            println("Saving minimumTextField")
            if Double(value.toInt()!) < 5 {
                // minimal tip allowed
                value = "5"
            }
            self.storageHelper.saveUserSetting(Constants.TipMinimumKey,value: value)
        }
        else if sender == self.defaultTextField {
//            println("Saving defaultTextField")
            self.storageHelper.saveUserSetting(Constants.TipDefaultKey,value: value)
        }
        else if sender == self.maximumTextField {
//            println("Saving maximumTextField")
            self.storageHelper.saveUserSetting(Constants.TipMaximumKey,value: value)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
