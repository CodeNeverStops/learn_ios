//
//  SecondViewController.swift
//  FileManager
//
//  Created by Wayne on 15/8/25.
//  Copyright (c) 2015年 Wayne. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBAction func saveToDisk(sender: UIButton) {
        let text = textField.text
        let destinationPath = NSTemporaryDirectory() + "myFile.txt"
        
        var error:NSError?
        
        let writen = text.writeToFile(destinationPath, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
        
        if writen {
            println("成功存储文件到\(destinationPath)")
        } else {
            if let theError = error {
                println("发生了错误：\(theError)")
            }
        }
    }
    @IBOutlet weak var content: UILabel!
    @IBAction func displayContent(sender: UIButton) {
        var error:NSError?
        let path = NSTemporaryDirectory() + "myFile.txt"
        let readString = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) as! String
        self.content.text = "myFile.txt文件中的字符串为：\(readString)"
    }
    @IBAction func saveArryToDisk(sender: UIButton) {
        let path = NSTemporaryDirectory() + "myArrayFile.txt"
        let arrayOfNames: NSArray = ["Steve", "John", "Edward"]
        
        if arrayOfNames.writeToFile(path, atomically: true) {
            let readArray:NSArray? = NSArray(contentsOfFile: path)
            if let array = readArray {
                println("成功读取数组 \(array)")
            } else {
                println("读取数组失败")
            }
        }
    }
    @IBAction func createDirectory(sender: UIButton) {
        let tempPath = NSTemporaryDirectory()
        let imagesPath = tempPath.stringByAppendingPathComponent("images")
        var error: NSError?
        let fileManager = NSFileManager()
        if fileManager.createDirectoryAtPath(imagesPath, withIntermediateDirectories: true, attributes: nil, error: nil) {
            println("目录创建成功")
        } else {
            println("目录创建失败")
        }
    }
    @IBAction func deleteDirectory(sender: UIButton) {
        let folder = NSTemporaryDirectory()
        var error:NSError?
        let fileManager = NSFileManager()
        let contents = fileManager.contentsOfDirectoryAtPath(folder, error: &error) as! [String]
        
        if let theError = error {
            println("An error occurred = \(theError)")
        } else {
            for fileName in contents {
                let filePath = folder.stringByAppendingPathComponent(fileName)
                if fileManager.removeItemAtPath(filePath, error: nil) {
                    println("成功删除： \(filePath)")
                } else {
                    println("删除失败： \(filePath)")
                }
            }
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

