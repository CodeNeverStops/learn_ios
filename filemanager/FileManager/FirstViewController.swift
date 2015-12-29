//
//  FirstViewController.swift
//  FileManager
//
//  Created by Wayne on 15/8/25.
//  Copyright (c) 2015年 Wayne. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func getDocumentsPath(sender: UIButton) {
        let fileManager = NSFileManager()
        let urls = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentationDirectory,
                inDomains: NSSearchPathDomainMask.UserDomainMask) as! [NSURL]
        
        if urls.count > 0 {
            let documentsFolder = urls[0]
            println("\(documentsFolder)")
        } else {
            println("没有找到Documents目录")
        }
    }
    
    @IBAction func getTmpPath(sender: UIButton) {
        if let tempDirectory = NSTemporaryDirectory() {
            println("\(tempDirectory)")
        } else {
            println("没有找到Tmp目录")
        }
    }
    
    @IBAction func getCachesPath(sender: UIButton) {
        let fileManager = NSFileManager()
        let urls = fileManager.URLsForDirectory(.CachesDirectory,
            inDomains: .UserDomainMask) as! [NSURL]
        
        if urls.count > 0 {
            let cachesFolder = urls[0]
            println("\(cachesFolder)")
        } else {
            println("没有找到Caches目录")
        }
    }
    @IBAction func enumerating(sender: UIButton) {
        var error:NSError?
        let fileManager = NSFileManager()
        let bundleDir = NSBundle.mainBundle().bundlePath
        let bundleContents = fileManager.contentsOfDirectoryAtPath(bundleDir, error: &error)
        if let contents = bundleContents {
            if contents.count == 0 {
                println("应用程序包是空的！")
            } else {
                println("应用程序包中的内容=\(bundleContents)")
            }
        } else if let theError = error {
            println("不能读取应用程序包的内容。Error = \(theError)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

