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
        let bundle = NSBundle(forClass: self as! AnyClass)
        return self.init(nibName: className, bundle: bundle)
    }
    
    
}
