//
//  ViewController.swift
//  PhotosGallery
//
//  Created by wayne.you on 15/8/23.
//  Copyright (c) 2015年 lokizone. All rights reserved.
//

import UIKit
import Photos

let albumName = "Photos Gallery"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var albumFound: Bool = false
    var assetCollection: PHAssetCollection!
    var photoAsset: PHFetchResult!


    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func cameraClick(sender: UIBarButtonItem) {
        println("camera click")
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            // 载入通过摄像头拍摄的用户界面
            var picker = UIImagePickerController()
            picker.sourceType = .Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
            println("source available")
        } else {
            var alert = UIAlertController(title: "错误", message: "没有可用的摄像头", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .Default, handler: {
                (alertAction) in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
        }
    }
    @IBAction func photoAlbumClick(sender: UIBarButtonItem) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(
            PHAssetCollectionType.Album, subtype: .Any, options: fetchOptions)
        
        if collection.firstObject != nil {
            self.albumFound = true
            self.assetCollection = collection.firstObject as! PHAssetCollection
        } else {
            println("照片集:\(albumName) 不存在，现在创建")
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(albumName)
                }, completionHandler: { (success: Bool, error: NSError!) in
                    if error != nil {
                        println("照片集创建失败")
                    } else {
                        println("照片集成功创建")
                    }
                    self.albumFound = success
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnSwipe = false
        self.photoAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if self.photoAsset != nil {
            count = self.photoAsset.count
        }
        return count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "PhotoCell"
        let cell: PhotoThumbnail = collectionView.dequeueReusableCellWithReuseIdentifier(
            reuseIdentifier, forIndexPath: indexPath) as! PhotoThumbnail
        
        let asset: PHAsset = self.photoAsset[indexPath.item] as! PHAsset
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize,
            contentMode: .AspectFill, options: nil) {
                (result: UIImage!, info: Dictionary!) -> Void in
                cell.setThumbnailImage(result)
        }
        
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 4
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewLargePhoto" {
            let controller = segue.destinationViewController as! PhotoViewController
            let indexPath: NSIndexPath = self.collectionView.indexPathForCell(sender as! UICollectionViewCell)!
            
            controller.index = indexPath.item
            controller.photoAsset = self.photoAsset
            controller.assetCollection = self.assetCollection
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
            let assetPlaceholder = createAssetRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest(
                forAssetCollection: self.assetCollection, assets: self.photoAsset)
            albumChangeRequest.addAssets([assetPlaceholder])
        }, completionHandler: {
            (success, error) in
            NSLog("添加照片到照片集 -> %@", (success ? "成功" : "失败"))
            picker.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}

