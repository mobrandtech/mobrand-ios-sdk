//
//  UIViewController.swift
//  Mobrand
//
//  Created by Jdira Ovidiu on 25/02/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit

extension UIViewController{
    static func instanceWithDefaultNib() -> Self {
        let className = NSStringFromClass(self as! AnyClass).componentsSeparatedByString(".").last
        return self.init(nibName: className, bundle: BundleUtils.getBundle())
    }
}



class BundleUtils {
    
    
    class func getBundle() ->NSBundle!{
        let podBundle = NSBundle(forClass: self as AnyClass)
        let bundleURL = podBundle.URLForResource("MobrandAppWall", withExtension: "bundle")
        if(bundleURL == nil) {
            return NSBundle(forClass: self as AnyClass)
        }
        
        
        return NSBundle(URL: bundleURL!)!
        
    }
}
