//
//  ImageLoader.swift
//  MobrandCore
//
//  Created by oJdira on 16/05/16.
//  Copyright © 2016 oJdira. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    var cache = NSCache()
    
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            let data: NSData? = self.cache.objectForKey(urlString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: urlString)
                })
                return
            }
            
            let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!) { (data, response, error) -> Void in
                // dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if (error != nil) {
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                if data != nil {
                    let image = UIImage(data: data!)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlString)
                    })
                    self.cache.setObject(data!, forKey: urlString)
                    return
                }
                
            }
            downloadTask.resume()
        })
        
    }
}