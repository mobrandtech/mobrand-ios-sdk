//
//  MobrandFactory.swift
//  Mobrand
//
//  Created by Jdira Ovidiu on 25/02/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit
import Foundation

public class MobrandAppWallFactory: NSObject{
    
    public class var sharedInstance : MobrandAppWallFactory {
        struct Static {
            static let instance : MobrandAppWallFactory = MobrandAppWallFactory()
        }
        return Static.instance
    }
    
    
    public  func createAppWall(parent: UIViewController, placementId: String){
            let controller: AppWallViewController = AppWallViewController.instanceWithDefaultNib()
            controller.parent = parent
            parent.presentViewController(controller, animated: true, completion: nil)
    }
    
}
