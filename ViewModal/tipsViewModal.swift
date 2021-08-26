//
//  tipsViewModal.swift
//  SPP
//
//  Created by sanganan on 2/14/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
struct  tipsViewModal{
    var Status : Int?
    var Item : [dataItemModal]?
    init(tips : tipsModal) {
        self.Status = tips.Status
        self.Item = tips.Item
    }
    }

    struct dataItemViewModal {
        var tips_id : Int?
        var tips_title : String?
        var tips_intro : String?
        var tips_image : String?
        var tips_icon : String?
           var tips_lat : String?
           var tips_long : String?
        init(tipsDa : dataItemModal) {
            self.tips_id = tipsDa.tips_id
           if let title = tipsDa.tips_title
            {
                self.tips_title = title.removeHTMLChar()
           }else{
            self.tips_title = "No Title"
            }
            self.tips_intro = tipsDa.tips_intro
            self.tips_image = tipsDa.tips_image
            self.tips_icon = tipsDa.tips_icon
            self.tips_lat = tipsDa.tips_lat
            self.tips_long = tipsDa.tips_long
        }
    }


