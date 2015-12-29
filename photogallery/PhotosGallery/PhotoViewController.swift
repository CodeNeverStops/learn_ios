//
//  PhotoViewController.swift
//  PhotosGallery
//
//  Created by wayne.you on 15/8/23.
//  Copyright (c) 2015年 lokizone. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {
    
    // 照片集对象
    var assetCollection: PHAssetCollection!
    // 照片集中所有照片的集合
    var photoAsset: PHFetchResult!
    // 照片在照片集中的位置
    var index: Int = 0

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func cancelClick(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func actionClick(sender: UIBarButtonItem) {
    }
    @IBAction func trashClick(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "删除照片", message: "你确定要删除该照片吗？", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "是", style: .Default, handler: {
            (alertAction) in
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let request = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
                request.removeAssets([self.photoAsset[self.index]])
            }, completionHandler: {
                (success, error) in
                NSLog("删除照片 -> %@", (success ? "成功" : "失败"))
                alert.dismissViewControllerAnimated(true, completion: nil)
                self.photoAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
                if self.photoAsset.count == 0 {
                    // 删除照片以后，照片集为空
                    self.imageView.image = nil
                    println("没有可以显示的照片了！")
                }
                if self.index >= self.photoAsset.count {
                    self.index = self.photoAsset.count - 1
                }
                self.displayPhoto()
            })
        }))
        
        alert.addAction(UIAlertAction(title: "否", style: .Cancel, handler: {
            (alertAction) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true
        self.displayPhoto()
    }
    
    func displayPhoto() {
        let imageManager = PHImageManager.defaultManager()
        var ID = imageManager.requestImageForAsset(self.photoAsset[self.index] as! PHAsset,
            targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFill,
            options: nil, resultHandler: { (result: UIImage!, info: Dictionary!) in
                self.imageView.image = result
        })
    }
}
