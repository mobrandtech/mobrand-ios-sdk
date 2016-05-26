//
//  AppWallViewController.swift
//  Mobrand
//
//  Created by Jdira Ovidiu on 24/02/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit
import MobrandCore

class AppWallViewController: UIViewController, AppWallAdsDelegate,  UIPageViewControllerDataSource, UIPageViewControllerDelegate, AppWallGroupsDelegate {
    
    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var txtErrorMessage: UILabel!
    @IBOutlet weak var allContainer: UIView!
    @IBOutlet weak var allLine: UIView!
    @IBOutlet weak var gamesContainer: UIView!
    @IBOutlet weak var gamesLine: UIView!
    @IBOutlet weak var iosContainer: UIView!
    @IBOutlet weak var iosLine: UIView!
    
    var nativeAds: Ads!
    var appWallGroups: AppWallGroups!
    var parent: UIViewController!
    var currentIndex : Int = 0
    var willTransitionToPosition: Int = 0
    var pageViewController : UIPageViewController!
    let modelContainer: UiObjModelContainer = UiObjModelContainer()
    let mobrandCore = MobrandCore.getInstance()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectAll()
        if(PhoneUtils.isConnectedToNetwork()) {
            requestItems()
        } else {
            txtErrorMessage.hidden = false
            txtErrorMessage.text = "An error has occurred. Please verify your internet connection."
        }
    }

    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func requestItems(){
        if(nativeAds == nil || nativeAds.list.count == 0){
            txtErrorMessage.hidden = true
            mobrandCore.requestAppWallGroups(self)
            mobrandCore.getAppWallAdsAsync("App Wall", delegate: self)
            LoadingOverlay.shared.showOverlay(self.view)
        }
    }
    
    
    func onAppWallAdsFailure() {
        
    }
    
    func onAppWallAdsSuccess(ads: Ads){
       self.nativeAds = ads
       self.buildUIObjectModel()
    }
    
    func onReceivedAppWallGroups(appWallGroups: AppWallGroups){
        self.appWallGroups = appWallGroups
        buildUIObjectModel()
    }
    
    
    func buildUIObjectModel(){
        if(nativeAds != nil && appWallGroups != nil){
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                self.modelContainer.buildOM(self.nativeAds, appWallGroups: self.appWallGroups)
                dispatch_async(dispatch_get_main_queue()) {
                   self.initPagerView()
                   self.initHeader()
                   LoadingOverlay.shared.hideOverlayView()
                }
            }
       }
    }
    
    func  onErrorReceived() {
        
    }
    
    func initHeader(){
        if(modelContainer.getPageModel(AdsType.ALL.rawValue).sections.count > 0){
            AnimateUtil.animteFadeIn(allContainer, duration: 0.2, delay: 0)
        }
        if(modelContainer.getPageModel(AdsType.GAMES.rawValue).sections.count > 0){
            AnimateUtil.animteFadeIn(gamesContainer, duration: 0.2, delay: 0.05)
        }
        
        if(modelContainer.getPageModel(AdsType.APPS.rawValue).sections.count > 0){
            AnimateUtil.animteFadeIn(iosContainer, duration: 0.2, delay: 0.1)
        }
    }
    
    func initPagerView(){
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
            self.pageViewController.dataSource = self
            self.pageViewController.delegate = self
            self.pageViewController.view.frame = CGRectMake(0, self.headerContainer.frame.height, self.view.frame.width, self.view.frame.height - self.headerContainer.frame.height)
            let pageContentViewController = self.viewControllerAtIndex(0)
            dispatch_async(dispatch_get_main_queue()) {
                self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
                self.addChildViewController(self.pageViewController)
                self.view.addSubview(self.pageViewController.view)
                self.pageViewController.didMoveToParentViewController(self)
            }
        }
        
        
        
    }

    @IBAction func onBackPressed(sender: AnyObject) {
        self.parent!.dismissViewControllerAnimated(true, completion: nil)
        self.removeFromParentViewController()
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]){
            willTransitionToPosition = (pendingViewControllers.first as! AppWallContentViewController).pageIndex
            
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(completed) {
            currentIndex = willTransitionToPosition
            changeSelection()
        }
    }
    

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! AppWallContentViewController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! AppWallContentViewController).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if (index == modelContainer.models.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> AppWallContentViewController?
    {
        
        let pageModel: AppWallPageModel! = modelContainer.getPageModel(index)
        if index >= modelContainer.models.count
        {
            return nil
        }
        // Create a new view controller and pass suitable data.
        let pageContentViewController = AppWallContentViewController.instanceWithDefaultNib()
        pageContentViewController.pageIndex = index
        currentIndex = index
        pageContentViewController.pageModel = pageModel
        return pageContentViewController
    }
    
    func changeSelection(){
       switch (currentIndex) {
        case AdsType.ALL.rawValue:
            selectAll()
            break
        case AdsType.GAMES.rawValue:
            selectGames()
            break
        case AdsType.APPS.rawValue:
            selectIOS()
            break
        default:
            break
        }
    }
    
    
    @IBAction func onSelectAll(sender: AnyObject) {
        selectAll()
        selectPage(AdsType.ALL.rawValue)
    }
    func selectAll(){
        setHeaderColor(AppWallColors.ALL_HEADER_BR)
        allLine.hidden = false
        iosLine.hidden = true
        gamesLine.hidden = true
    }
    
    @IBAction func onSelectGames(sender: AnyObject) {
        selectGames()
        selectPage(AdsType.GAMES.rawValue)
     }
    
    func selectPage(index: Int){
        var direction = UIPageViewControllerNavigationDirection.Forward
        if(index < currentIndex){
            direction = UIPageViewControllerNavigationDirection.Reverse
        }
        let viewController = self.viewControllerAtIndex(index)!
        pageViewController.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }
    
    func selectGames(){
        setHeaderColor(AppWallColors.GAMES_HEADER_BG)
        allLine.hidden = true
        iosLine.hidden = true
        gamesLine.hidden = false
    }
    
    @IBAction func onSelectIOS(sender: AnyObject) {
        selectIOS()
        selectPage(AdsType.APPS.rawValue)
    }
    
    func selectIOS(){
       setHeaderColor(AppWallColors.IOS_HEADER_BG)
       allLine.hidden = true
       iosLine.hidden = false
       gamesLine.hidden = true
    }
    func setHeaderColor(color: String){
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.headerContainer.backgroundColor = UIColor(rgba: color)
        })
    }
}


