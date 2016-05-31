//
//  MobrandAppWallSectionGridItemsViewCell.swift
//  Mobrand
//
//  Created by Jdira Ovidiu on 09/03/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit
class ViewCellUtils {
    var colectionViewSize = CGSize()
    let MAX_CELL_WIDTH:CGFloat = 250
    
    
    class var sharedInstance : ViewCellUtils {
        struct Static {
            static let instance : ViewCellUtils = ViewCellUtils()
        }
        return Static.instance
    }
    
    private init(){
        computeCellSize()
    }
    
    
    func computeCellSize()-> CGSize{
        var width = (UIScreen.mainScreen().bounds.size.width - 16) / 3.1
        if(width > MAX_CELL_WIDTH){
            width = MAX_CELL_WIDTH
        }
        let height = CGFloat(166)
        colectionViewSize = CGSizeMake(width, height)
        return colectionViewSize
    }
    
    func computeAdsCellTableViewHeight(items: Int)->CGFloat{
        let nbOfCollumns = (UIScreen.mainScreen().bounds.size.width - 16) / colectionViewSize.width
        let rows = Int( ceil(Double(items) / Double(nbOfCollumns)))
        return CGFloat( rows * 170)
    }
}


public class MobrandAppWallSectionGridItemsViewCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var gridView: UICollectionView!
    let cellIdentifier = "GridItemViewCell"
    var ads: [AppWallAd] =  [AppWallAd]()
    var progressBarColor: UIColor!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        gridView.delegate = self
        gridView.dataSource = self
        backgroundColor = UIColor(rgba: AppWallColors.APP_WALL_BG)
        let frameworkBundle = BundleUtils.getBundle()
        self.gridView.registerNib(UINib(nibName: cellIdentifier, bundle: frameworkBundle), forCellWithReuseIdentifier: cellIdentifier)
       NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppWallContentViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func rotated(){
        gridView.collectionViewLayout.invalidateLayout()
    }


    func modelChange(ads: [AppWallAd], progressBarColor: UIColor){
        self.progressBarColor  = progressBarColor
        self.ads = ads
        gridView.reloadData()
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         let cell : GridItemViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! GridItemViewCell
         let item: AppWallAd = self.ads[indexPath.row]
         cell.modelChange(item, progresBarColor: self.progressBarColor)
         return cell
    }
    
    
    public func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell : GridItemViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! GridItemViewCell
        cell.reset()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return ViewCellUtils.sharedInstance.colectionViewSize
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    func  isNewModel(ads: [AppWallAd])->Bool {
        if self.ads.count == 0 {
            return true
        } else  if self.ads.count != ads.count {
            return true
        } else {
            let count = ads.count
            for i in 0..<count{
                if ads[i].adid != self.ads[i].adid  {
                    return true
                }
            }
            
            return false
        }
        
    }
    
}


