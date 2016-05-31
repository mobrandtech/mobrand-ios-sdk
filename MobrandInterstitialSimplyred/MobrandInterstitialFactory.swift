//
//  MobrandInterstitialFactory.swift
//  MobrandCore
//
//  Created by oJdira on 16/05/16.
//  Copyright © 2016 oJdira. All rights reserved.
//

import Foundation
import UIKit


public class MobrandInterstitialFactory: NSObject{
    
    public class var sharedInstance : MobrandInterstitialFactory {
        struct Static {
            static let instance : MobrandInterstitialFactory = MobrandInterstitialFactory()
        }
        return Static.instance
    }
    
    
    public  func createInterstitial(parent: UIViewController, placementId: String){
        let controller: InterstitialViewController = InterstitialViewController.instanceWithDefaultNib()
        controller.parent = parent
        parent.presentViewController(controller, animated: true, completion: nil)
    }
    
}