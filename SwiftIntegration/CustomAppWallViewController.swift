//
//  CustomAppWallViewController.swift
//  Mobrand
//
//  Created by oJdira on 10/05/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit
import MobrandAppWall
import MobrandCore

class CustomAppWallViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AppWallAdsDelegate{
    let identifier = "CustomAppWallViewCell"
    @IBOutlet weak var tableView: UITableView!
    var nativeAds: Ads = Ads()
    let mobrandCore =  MobrandCore.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        requestItems()
    }
    
    func requestItems(){
        if(nativeAds.list.count == 0){
            mobrandCore.getAppWallAdsAsync("App Wall", delegate: self)
        }
    }
    
    func onAppWallAdsFailure() {
        
    }
    
    func onAppWallAdsSuccess(ads: Ads) {
        self.nativeAds = ads
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nativeAds.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! CustomAppWallViewCell!;
        let ad = nativeAds.list[row]
        cell.modelChange(ad)
        return cell;
        
    }
    

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
  

}
