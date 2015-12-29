//
//  Item.swift
//  shopping
//
//  Created by wayne.you on 15/8/12.
//  Copyright (c) 2015年 lokizone. All rights reserved.
//

import Foundation

class Item {
    var itemName: String = ""
    var brandName: String = ""
    var isBuy: Bool = false
    
    init(itemName: String, brandName: String, isBuy: Bool) {
        self.itemName = itemName
        self.brandName = brandName
        self.isBuy = isBuy
    }
    
    convenience init(itemName: String) {
        self.init(itemName: itemName, brandName: "", isBuy: false)
    }
    
    convenience init(itemName: String, brandName: String) {
        self.init(itemName: itemName, brandName: brandName, isBuy: false)
    }
    
    func description() -> String {
        return "itemName: \(itemName) brandName: \(brandName) isBuy: \(isBuy)"
    }
}
