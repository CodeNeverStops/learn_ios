//
//  IMDbAPIController.swift
//  IMDb
//
//  Created by wayne.you on 15/8/20.
//  Copyright (c) 2015年 lokizone. All rights reserved.
//

import UIKit

protocol IMDbAPIControllerDelegate {
    func didFinishIMDbSearch(result: Dictionary<String, String>)
}

class IMDbAPIController: NSObject {
    
    var delegate: IMDbAPIControllerDelegate?
    
    init(delegate: IMDbAPIControllerDelegate) {
        self.delegate = delegate
    }
    
    func searchIMDb(forContent: String) {
        var spacelessString = forContent.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        var urlPath = NSURL(string: "http://www.omdbapi.com/?t=\(spacelessString!)")
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(urlPath!) {
            data, response, error -> Void in
            if error != nil {
                println(error.localizedDescription)
            }
            var jsonError: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as! Dictionary<String, String>
            
            if jsonError != nil {
                println(jsonError?.localizedDescription)
            }
            
            // async run
//            dispatch_async(dispatch_get_main_queue()) {
//                self.titleLabel.text = jsonResult["Title"]
//                self.releasedLabel.text = jsonResult["Released"]
//                self.ratingLabel.text = jsonResult["Rated"]
//                self.plotLabel.text = jsonResult["Plot"]
//            }
            if let apiDelegate = self.delegate {
                dispatch_async(dispatch_get_main_queue()) {
                    apiDelegate.didFinishIMDbSearch(jsonResult)
                }
            }
        }
        task.resume()
    }
   
}
