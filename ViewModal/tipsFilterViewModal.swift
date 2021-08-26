//
//  tipsFilterViewModal.swift
//  SPP
//
//  Created by sanganan on 2/17/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct tipsFilterViewModal {
        var Tips_category_list : String?
    
    init(tipsFilNme : tipsFilName) {
        self.Tips_category_list = tipsFilNme.Tips_category_list
    }
        init(title : String) {
            self.Tips_category_list = title
        }
       
}
