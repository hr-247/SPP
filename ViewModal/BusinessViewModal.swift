//
//  BusinessViewModal.swift
//  SPP
//
//  Created by sanganan on 2/25/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct BusinessViewModal {
        var news_id : Int?
        var news_date : Int?
        var news_title : String?
        var news_intro : String?
        var news_image : String?
    var news_lat : String?
    var news_long : String?
    init(busiData : BusinessDataModal) {
        self.news_id = busiData.news_id
        self.news_date = busiData.news_date
        self.news_title = busiData.news_title?.removeHTMLChar()
        self.news_intro = busiData.news_intro
        self.news_image = busiData.news_image
        self.news_lat = busiData.news_lat
        self.news_long =  busiData.news_long
    }
    }


