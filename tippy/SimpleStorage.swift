//
//  SimpleStorage.swift
//  tippy
//
//  Created by Tianwei Liu on 4/12/15.
//  Copyright (c) 2015 Tianwei Liu. All rights reserved.
//

import Foundation

class SimpleStorage {
    var userDefault: NSUserDefaults
    
    init() {
        self.userDefault = NSUserDefaults.standardUserDefaults()
    }
    
    func saveUserSetting(key: String, value: String) {
        self.userDefault.setObject(value, forKey: key)
        self.userDefault.synchronize()
        println("\(key) value of \(value) saved!")
    }
    
    func getUserSetting(key: String, defaultValue: String) -> String {
        if let value: AnyObject = self.userDefault.objectForKey(key) {
            return value as String
        }
        else {
            return defaultValue
        }
        
    }
}