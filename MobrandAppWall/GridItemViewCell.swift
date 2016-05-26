//
//  GridItemViewCell.swift
//  Mobrand
//
//  Created by Jdira Ovidiu on 09/03/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit
import MobrandCore

public class GridItemViewCell: UICollectionViewCell, MobrandClickDelegate {
    var ad: AppWallAd!
    let myCache = ImageCache(name: "MobrandAppWall")
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    var webView: UIWebView!
    var progressBarTimer:NSTimer!
    let mobrandCore =  MobrandCore.getInstance()
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GridItemViewCell.onClick(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
        progressBar.hidden = true
        applyTheme()
       
    }
    
    func modelChange(ad: AppWallAd, progresBarColor: UIColor){
        progressBar.hidden = true
        self.ad = ad
        ImageLoader.sharedLoader.imageForUrl(ad.icon, completionHandler:{(image: UIImage?, url: String) in
            self.imgLogo.image = image
        })
//        imgLogo.kf_setImageWithURL(NSURL(string: ad.icon)!,
//                                   placeholderImage: nil,
//                                   optionsInfo: [.TargetCache(myCache)])
        
        
        txtTitle.text = ad.name
        progressBar.progressTintColor = progresBarColor
        if(!ad.impressed) {
            mobrandCore.addImpression(ad.adid, placementid: "App Wall")
            ad.impressed = true
        }
        
    }
    
    func onClick(sender: UITapGestureRecognizer)
    {
        self.progressBarTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(GridItemViewCell.updateProgressBar), userInfo: nil, repeats: true)
        progressBar.hidden = false
        mobrandCore.click(ad.adid, placementid: "App Wall", delegate: self)
    }
    
    func updateProgressBar(){
        self.progressBar.progress += 0.01
        if(self.progressBar.progress == 1)
        {
            self.progressBar.progress = 0
        }
        
    }
    
    func applyTheme(){
        txtTitle.textColor = UIColor(rgba: AppWallColors.APP_WALL_ITEM_NAME)
        layer.cornerRadius = 5.0
    }
    
    public func  onMobrandClickReady() {
        progressBar.hidden = true
    }
    public func onMobrandClickError(error: String) {
        progressBar.hidden = true
    }
    
}
