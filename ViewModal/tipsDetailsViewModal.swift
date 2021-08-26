//
//  tipsDetailsViewModal.swift
//  SPP
//
//  Created by sanganan on 2/22/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct tipsDetailsViewModal {
            var tips_id : Int?
            var tips_title : String?
            var tips_intro : String?
            var tips_backimage : String?
            var tips_icon : String?
            var tips_extra_image : [String]?
            var tips_desc : String?
        //    var tips_youtube : [String]
    
    init(tipItems : tipsDetailsItems) {
        self.tips_id = tipItems.tips_id
        self.tips_title = tipItems.tips_title?.removeHTMLChar()
        self.tips_intro = tipItems.tips_intro
        self.tips_backimage = tipItems.tips_backimage
        self.tips_icon = tipItems.tips_icon
        self.tips_extra_image = tipItems.tips_extra_image
        self.tips_desc = tipItems.tips_desc
      //  self.tips_youtube = tipItems.tips_youtube
    }
            
    }

