//
//  ViewController.swift
//  SwiftIntegration
//
//  Created by oJdira on 10/05/16.
//  Copyright © 2016 oJdira. All rights reserved.
//

import UIKit
import MobrandAppWall
import MobrandInterstitialSimplyred

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnClickInterstitial(sender: AnyObject) {
         MobrandInterstitialFactory.sharedInstance.createInterstitial(self, placementId: "test")
    }
    
    @IBAction func onClick(sender: AnyObject) {
        MobrandAppWallFactory.sharedInstance.createAppWall(self, placementId: "test")
    }
    @IBAction func onClickCustomAppWall(sender: AnyObject) {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CustomAppWallViewController")
        
        self.navigationController?.pushViewController(vc!, animated: true);
        
    }

}

