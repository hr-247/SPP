//
//  BdetailsViewModal.swift
//  SPP
//
//  Created by sanganan on 2/25/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct BdetailsViewModal {
        var news_id : Int?
        var news_det : String?
        var news_date : Int?
        var news_title : String?
        var news_website : String?
        var news_image : String?
        
    init(bDItems : bDataModal) {
        
        self.news_det = bDItems.news_det?.removeHTMLChar()
        self.news_date = bDItems.news_date
        self.news_title = bDItems.news_title?.removeHTMLChar()
        self.news_website = bDItems.news_website
        self.news_image = bDItems.news_image
        }
        
    }


