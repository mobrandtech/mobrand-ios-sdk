//
//  AppWallContentViewController.swift
//  Mobrand
//
//  Created by Jdira Ovidiu on 26/02/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit



class AppWallContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var pageIndex: Int = 0
    var pageModel: AppWallPageModel!
    @IBOutlet weak var tableView: UITableView!
    let sectionNameIdentifier = "MobrandAppWallSectionNameViewCell"
    let sectionGridItemsIdentifier = "MobrandAppWallSectionGridItemsViewCell"
    let appWallBrandViewCellIdentifier = "AppWallBrandViewCell"
    var cellSectionSize: [Int: Int] = [Int: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerNib()
        tableView.backgroundColor = UIColor(rgba: AppWallColors.APP_WALL_BG)
//        tableView.backgroundColor = UIColor.redColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppWallContentViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        computeCellAdsHeight()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func rotated(){
        ViewCellUtils.sharedInstance.computeCellSize()
        computeCellAdsHeight()
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func registerNib(){
        tableView.rowHeight = UITableViewAutomaticDimension
        let frameworkBundle = BundleUtils.getBundle()
        tableView.registerNib(UINib(nibName: sectionNameIdentifier, bundle: frameworkBundle), forCellReuseIdentifier: sectionNameIdentifier)
        tableView.registerNib(UINib(nibName: sectionGridItemsIdentifier, bundle: frameworkBundle), forCellReuseIdentifier: sectionGridItemsIdentifier)
        tableView.registerNib(UINib(nibName: appWallBrandViewCellIdentifier, bundle: frameworkBundle), forCellReuseIdentifier: appWallBrandViewCellIdentifier)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageModel.sections.count * 2 + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        if(row < pageModel.sections.count * 2) {
            
            let sectionModel: SectionModel = pageModel.sections[row / 2]!
            if(row % 2 == 0){
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier(sectionNameIdentifier, forIndexPath: indexPath) as! MobrandAppWallSectionNameViewCell;
                sectionTitleCell.modelChange(sectionModel.title)
                return sectionTitleCell;
            } else {
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier(sectionGridItemsIdentifier, forIndexPath: indexPath) as! MobrandAppWallSectionGridItemsViewCell;
                sectionTitleCell.modelChange(sectionModel.list, progressBarColor: getProgresBarColor())
                return sectionTitleCell;
            }
            
        } else {
            let brandCell = tableView.dequeueReusableCellWithIdentifier(appWallBrandViewCellIdentifier, forIndexPath: indexPath) as! AppWallBrandViewCell;
            return brandCell;
        
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        if(row < pageModel.sections.count * 2) {
            if(row % 2 == 0){
                return 80
            } else {
                let sectionModel: SectionModel = pageModel.sections[row / 2]!
                return sectionModel.cellHeight
            }
        }else {
            return 120
        }
    }
    
    func computeCellAdsHeight(){
        let sectionsAds = pageModel.sections.values
        for sectionModel in sectionsAds{
            sectionModel.cellHeight = ViewCellUtils.sharedInstance.computeAdsCellTableViewHeight(sectionModel.list.count)
        }
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func getProgresBarColor()->UIColor{
        if(pageIndex == AdsType.ALL.rawValue) {
            return UIColor(rgba: AppWallColors.ALL_HEADER_BR)
        } else if(pageIndex == AdsType.GAMES.rawValue) {
            return UIColor(rgba: AppWallColors.GAMES_HEADER_BG)
        } else {
            return UIColor(rgba: AppWallColors.IOS_HEADER_BG)
        }
    }

}

private class RowHeightsObj{
    var landscapeHeight: CGFloat!
    var portraitHeight: CGFloat!
}
