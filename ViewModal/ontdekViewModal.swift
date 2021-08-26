//
//  ontdekViewModal.swift
//  SPP
//
//  Created by sanganan on 2/14/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct ontdekViewModal{
    var Status : Int?
    var Item : [ontDataModal]?
    
    init(ontdek : ontdekModal) {
        self.Status = ontdek.Status
        self.Item = ontdek.Item
    }
    
    
}
struct ontDataViewModal
{
    var  ontdek_adress : String?
    var  ontdek_title : String?
    var  ontdek_intro : String?
    var  ontdek_image : String?
    var  ontdek_phone  : String?
    var  ontdek_web : String?
    
    init(ontDa : ontDataModal) {
        self.ontdek_adress = ontDa.ontdek_adress
        self.ontdek_intro = ontDa.ontdek_intro
        self.ontdek_title = ontDa.ontdek_title
        self.ontdek_image = ontDa.ontdek_image
        self.ontdek_phone = ontDa.ontdek_phone
        self.ontdek_web = ontDa.ontdek_web
    }
    
}
