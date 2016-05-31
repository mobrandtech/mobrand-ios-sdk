//
//  UIViewController.swift
//  MobrandCore
//
//  Created by oJdira on 16/05/16.
//  Copyright © 2016 oJdira. All rights reserved.
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
        let bundleURL = podBundle.URLForResource("MobrandInterstitialSimplyred", withExtension: "bundle")
        if(bundleURL == nil) {
            return NSBundle(forClass: self as AnyClass)
        }
        
        
        return NSBundle(URL: bundleURL!)!
        
    }
}
