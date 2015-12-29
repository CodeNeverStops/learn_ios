//
//  PhotoThumbnail.swift
//  PhotosGallery
//
//  Created by wayne.you on 15/8/23.
//  Copyright (c) 2015年 lokizone. All rights reserved.
//

import UIKit

class PhotoThumbnail: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func setThumbnailImage(thumbnailImage: UIImage) {
        self.imageView.image = thumbnailImage
    }
}
