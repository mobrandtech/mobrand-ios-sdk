//
//  PhoneUtils.swift
//  Ola.mobi
//
//  Created by StarEdition on 20/03/15.
//  Copyright (c) 2015 OlaMobile. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

class PhoneUtils {
    
    static let font_bold = "BrandonGrotesque-Bold"
    static let font_black = "BrandonGrotesque-Black"
    static let font_medium = "BrandonGrotesqueMedium"
    static let font_regular = "BrandonGrotesqueRegular"
    
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags.ConnectionAutomatic
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
    
   class func isInIOS8() -> Bool {
        return (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8
    }
    
    class func getLanguage() ->String{
        if let lang = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) {
            return lang as! String
        }
        return  ""
    }
    
    class func isLandscape()->Bool{
        return UIScreen.mainScreen().bounds.width > UIScreen.mainScreen().bounds.height
    }
    
    class func isPortraight()->Bool{
        return !isLandscape()
    }
   class func printFonts() {
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName)
            print("Font Names = [\(names)]")
        }
    }
}

