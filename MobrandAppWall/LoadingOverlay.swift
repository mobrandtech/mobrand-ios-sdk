//
//  LoadingOverlay.swift
//  Ola.mobi
//
//  Created by Ovidiu on 08/06/15.
//  Copyright (c) 2015 OlaMobile. All rights reserved.
//

import UIKit
import Foundation


 class LoadingOverlay: NSObject{
    var isVisible = false;
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
   
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    private override init(){
        super.init()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(LoadingOverlay.rotate(_:)),
            name: UIDeviceOrientationDidChangeNotification,
            object: nil)
        
    }
    
     func showOverlay(view: UIView!) {
        if(!isVisible){
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            overlayView = UIView(frame: UIScreen.mainScreen().bounds)
            overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                activityIndicator.center = overlayView.center
                activityIndicator.startAnimating()
                overlayView.addSubview(activityIndicator)
            view.addSubview(overlayView)
            isVisible = true
        }
    }
    
     func hideOverlayView() {
        if(isVisible){
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            activityIndicator.stopAnimating()
            overlayView.removeFromSuperview()
            isVisible = false
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func rotate(notification: NSNotification ){
        
        if let info = notification.userInfo as? Dictionary<String,NSNumber> {
            if let ori = info["UIDeviceOrientationRotateAnimatedUserInfoKey"] {
                let newOr : UIDeviceOrientation = UIDeviceOrientation(rawValue: ori.integerValue)!
                self.overlayView.frame = UIScreen.mainScreen().bounds
                rotateSubviewsForOrientation(newOr)
            }
        }
    }
    
   private func rotateSubviewsForOrientation(orientation: UIDeviceOrientation) {
        switch orientation {
        case UIDeviceOrientation.LandscapeLeft:
            subLabelTransform(CGFloat(M_PI_2 ))
        case UIDeviceOrientation.LandscapeRight:
            subLabelTransform(CGFloat(3 * M_PI_2))
        default:
            subLabelTransform(CGFloat(0))
        }
    }
    
    private func subLabelTransform(f: CGFloat) {
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.overlayView.center = CGPointMake(self.overlayView.frame.width / 2, self.overlayView.frame.height / 2)
            self.activityIndicator.center = self.overlayView.center
            self.overlayView.transform  = CGAffineTransformMakeRotation(f)
            }) { (Bool) -> Void in
        }
    }
    
    
    
}