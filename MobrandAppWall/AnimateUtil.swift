//
//  AnimateUtil.swift
//  Mobrand
//
//  Created by Jdira Ovidiu on 10/03/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit


class AnimateUtil{
    
    class func animteFadeIn(view: UIView, duration: NSTimeInterval, delay: NSTimeInterval ){
        view.alpha = 0
        UIView.animateWithDuration(duration, delay: delay,
            options: [],
            animations: {
                view.alpha = 1.0
            }, completion: nil)
    }
    
}