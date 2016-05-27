//
//  InterstitialViewController.swift
//  MobrandCore
//
//  Created by oJdira on 16/05/16.
//  Copyright © 2016 oJdira. All rights reserved.
//

import UIKit
import MobrandCore

class InterstitialViewController: UIViewController, MobrandInterstitialDelegate, MobrandClickDelegate {
    var parent: UIViewController!
    @IBOutlet weak var txtScreenTitle: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtCategory: UILabel!
    @IBOutlet weak var txtDescriptionLabel: UILabel!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var imgStoreLogo: UIImageView!
    @IBOutlet weak var txtDescription: UITextView!
    var imageBg: UIImageView!
    
    let mobrandCore =  MobrandCore.getInstance()
    var interstitialAd: InterstitialAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestItems()
        btnDownload.setTitle("INSTALL NOW", forState:  UIControlState.Normal)
        txtDescriptionLabel.text = "Description"
        txtScreenTitle.text = "Best App of the month!"
        self.imgStoreLogo.image = UIImage(named: "whitecross")
        
        btnDownload.layer.masksToBounds = false
        btnDownload.layer.cornerRadius = btnDownload.frame.height / 2
        btnDownload.layer.shadowColor = UIColor.lightGrayColor().CGColor
        btnDownload.layer.shadowOpacity = 1.0
        btnDownload.layer.shadowRadius = 1
        btnDownload.layer.shadowOffset = CGSizeMake(0, 1.5)
        
        imageBg = UIImageView(frame: CGRect(x: 0, y: 0, width: infoContainer.frame.width, height: infoContainer.frame.height))
        imageBg.contentMode = .ScaleAspectFill
        imageBg.clipsToBounds = true
        imageBg.alpha = 0.1
        self.infoContainer.addSubview(imageBg)
        imgStoreLogo.image = UIImage(named:  "store_logo.png", inBundle: BundleUtils.getBundle(), compatibleWithTraitCollection: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InterstitialViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func rotated()
    {
        imageBg.frame.size.height = infoContainer.frame.height
        imageBg.frame.size.width = infoContainer.frame.width
        btnDownload.layer.cornerRadius = btnDownload.frame.height / 2
 
    }
    
    func requestItems(){
        if(interstitialAd == nil ){
//            txtErrorMessage.hidden = true
            container.hidden = true
            mobrandCore.getInterstitialAdsAsync("Interstitial", delegate: self)
            LoadingOverlay.shared.showOverlay(self.view)
        }
    }
    
    func onInterstitialSuccess(ad: Ad){
        interstitialAd = InterstitialAd()
        interstitialAd.adid = ad.adid
        interstitialAd.icon = ad.icon
        interstitialAd.name = ad.name
        interstitialAd.category = ad.category
        interstitialAd.packageName = ad.packageName
        interstitialAd.categoryName = ad.categoryName
        interstitialAd.desc = ad.desc
        fillViews()
        imageBg.frame.size.height = infoContainer.frame.height
        imageBg.frame.size.width = infoContainer.frame.width
        LoadingOverlay.shared.hideOverlayView()
        addImpression()
        container.hidden = false
    }
    func onInterstitialFailure(){
        
    }
    
    
    func fillViews(){
        
        ImageLoader.sharedLoader.imageForUrl(interstitialAd.icon, completionHandler:{(image: UIImage?, url: String) in
            self.imgLogo.image = image
            self.imageBg.image = image
        })
        
        txtName.text = interstitialAd.name!
        txtDescription.text = interstitialAd.desc!
        txtCategory.text = interstitialAd.categoryName!
        let range = NSMakeRange(0, 0)
        txtDescription.scrollRangeToVisible(range)
    }

    @IBAction func onClose(sender: AnyObject) {
        self.parent!.dismissViewControllerAnimated(true, completion: nil)
        self.removeFromParentViewController()
    }
    @IBAction func onDownload(sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(self.view)
        mobrandCore.click(interstitialAd.adid, placementid: "Interstitial", delegate: self)
    }
    
    func onMobrandClickReady(){
        LoadingOverlay.shared.hideOverlayView()
    }
    func onMobrandClickError(error: String){
        LoadingOverlay.shared.hideOverlayView()
    }
    
    func addImpression(){
        if(!interstitialAd.impressed) {
            mobrandCore.addImpression(interstitialAd.adid, placementid: "Interstitial")
            interstitialAd.impressed = true
        }
    }
}
