//
//  UiObjModelContainer.swift
//  Mobrand
//
//  Created by Jdira Ovidiu on 26/02/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import Foundation
import MobrandCore

class UiObjModelContainer {
    let nbOfAdsOnSection = 6;
    let all_items_key = 0
    var models:[Int: AppWallPageModel] = [Int: AppWallPageModel]()
    
    func buildOM(ads: Ads, appWallGroups: AppWallGroups){
        var gamesList = [AppWallAd]()
        var appsList = [AppWallAd]()
        let allAdsSections = AppWallPageModel()
        let gamesSections = AppWallPageModel()
        let appsSections = AppWallPageModel()
        
        let nbOfAds = ads.list.count
        for i in 0 ..< nbOfAds  {
            let appWallAd = fillAds(ads.list[i])
            
            if(appWallAd.category == AdsType.GAMES.rawValue){
                let gameSectionNb = getSectionNB(gamesList.count)
                if(gameSectionNb < appWallGroups.groups[AdsType.GAMES.rawValue]!.count) {
                    
                    gamesSections.addNewItem(gameSectionNb, title: "\(appWallGroups.groups[AdsType.GAMES.rawValue]![gameSectionNb])", ad: appWallAd)
                    gamesList.append(appWallAd)
                }
                
            }
            if(appWallAd.category == AdsType.APPS.rawValue){
                let appSectionNb = getSectionNB(appsList.count)
                if(appSectionNb < appWallGroups.groups[AdsType.APPS.rawValue]!.count) {
                    appsSections.addNewItem(appSectionNb, title: "\(appWallGroups.groups[AdsType.APPS.rawValue]![appSectionNb])", ad: appWallAd)
                    appsList.append(appWallAd)
                }
            }
            
            let allItemsSectionNb = getSectionNB(i)
            if(allItemsSectionNb < appWallGroups.groups[AdsType.ALL.rawValue]!.count) {
                allAdsSections.addNewItem(allItemsSectionNb, title: "\(appWallGroups.groups[AdsType.ALL.rawValue]![allItemsSectionNb])", ad: appWallAd)
            }
            
        }
        models.updateValue(allAdsSections, forKey: AdsType.ALL.rawValue)
        models.updateValue(gamesSections, forKey: AdsType.GAMES.rawValue)
        models.updateValue(appsSections, forKey: AdsType.APPS.rawValue)
    }
    private func getSectionNB(index: Int)->Int{
        return index / nbOfAdsOnSection
    }
    
    func getPageModel(index: Int)->AppWallPageModel!{
        return models[index]
    }
    
    
    func fillAds(nativeAd: Ad)->AppWallAd{
        let ad = AppWallAd()
        ad.adid = nativeAd.adid
        ad.icon = nativeAd.icon
        ad.name = nativeAd.name
        ad.category = nativeAd.category
        ad.packageName = nativeAd.packageName
        return ad
    }
    
}

class AppWallPageModel {
    var sections:[Int: SectionModel] = [Int: SectionModel]()
    
    func addNewItem(position:Int, title: String, ad:AppWallAd){
       
        
        if let sectionModel =  self.sections[position] {
           sectionModel.list.append(ad)
           sections.updateValue(sectionModel, forKey: position)
        } else {
            let sectionModel = SectionModel()
            var ads = [AppWallAd]()
            ads.append(ad)
            sectionModel.title = title
            sectionModel.list = ads
            sections.updateValue(sectionModel, forKey: position)
        }
    }
}

class SectionModel {
    var title = ""
    var list:[AppWallAd] = [AppWallAd]()
    var cellHeight: CGFloat = 0
}