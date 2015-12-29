//
//  ThirdViewController.swift
//  FileManager
//
//  Created by Wayne on 15/8/25.
//  Copyright (c) 2015年 Wayne. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var content: UITextView!
    @IBAction func enumeratingApp(sender: AnyObject) {
        self.content.text = ""
        let appBundleContents = contentsOfAppBundle()
        for url in appBundleContents {
            printUrlPropertiesToTextView(url)
        }
    }
    
    func contentsOfAppBundle() -> [NSURL] {
        let propertiesToGet = [
            NSURLIsDirectoryKey,
            NSURLIsReadableKey,
            NSURLCreationDateKey,
            NSURLContentAccessDateKey,
            NSURLContentModificationDateKey
        ]
        
        var error:NSError?
        let fileManager = NSFileManager()
        let bundleUrl = NSBundle.mainBundle().bundleURL
        let result = fileManager.contentsOfDirectoryAtURL(bundleUrl, includingPropertiesForKeys: propertiesToGet, options: nil, error: &error) as! [NSURL]
        
        if let theError = error {
            println("An error occurred")
        }
        return result
    }
    
    func stringValueOfBoolProperty(property: String, url: NSURL) -> String {
        var value:AnyObject?
        var error:NSError?
        if url.getResourceValue(&value, forKey: property, error: &error) && value != nil {
            let number = value as! NSNumber
            return number.boolValue ? "YES" : "NO"
        }
        return "NO"
    }
    
    func isUrlDirectory(url: NSURL) -> String {
        return stringValueOfBoolProperty(NSURLIsDirectoryKey, url: url)
    }
    
    func isUrlReadable(url: NSURL) -> NSString {
        return stringValueOfBoolProperty(NSURLIsReadableKey, url: url)
    }
    
    func dateOfType(type: String, url: NSURL) -> NSDate? {
        var value:AnyObject?
        var error:NSError?
        if url.getResourceValue(&value, forKey: type, error: &error) && value != nil {
            return value as? NSDate
        }
        return nil
    }
    
    func printUrlPropertiesToTextView(url: NSURL) {
        self.content.text = self.content.text + "URL name = \(url.lastPathComponent)\n"
        self.content.text = self.content.text + "Is a Directory? \(isUrlDirectory(url))\n"
        self.content.text = self.content.text + "Is Readable? \(isUrlReadable(url))\n"
        
        if let creationDate = dateOfType(NSURLCreationDateKey, url: url) {
            self.content.text = self.content.text + "Creation Date = \(creationDate)\n"
        }
        
        if let accessDate = dateOfType(NSURLContentAccessDateKey, url: url) {
            self.content.text = self.content.text + "Access Date = \(accessDate)\n"
        }
        
        if let modificatoinDate = dateOfType(NSURLContentModificationDateKey, url: url) {
            self.content.text = self.content.text + "Modification Date = \(modificatoinDate)\n"
        }
        
        self.content.text = self.content.text + "------------------------------------\n\n\n"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
