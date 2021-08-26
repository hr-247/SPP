//
//  OntdekDataViewModal.swift
//  SPP
//
//  Created by sanganan on 2/26/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct OntdekDataViewModal {
        var ontdek_id : Int?
        var ontdek_adress :  String?
        var ontdek_title : String?
        var ontdek_phone : String?
        var ontdek_image : String?
        var ontdek_web :  String?
     var ontdek_link : String?
        var ontdek_lat : String?
        var ontdek_long : String?
     var ontdek_temp : String?
    
    init(ontDa : ontItemsModal) {
        self.ontdek_id = ontDa.ontdek_id
        self.ontdek_adress = ontDa.ontdek_adress
        self.ontdek_title = ontDa.ontdek_title?.removeHTMLChar()
        self.ontdek_phone = ontDa.ontdek_phone
        self.ontdek_image = ontDa.ontdek_image
        self.ontdek_web = ontDa.ontdek_web
        self.ontdek_link = ontDa.ontdek_link
        self.ontdek_lat = ontDa.ontdek_lat
        self.ontdek_long = ontDa.ontdek_long
        self.ontdek_temp = ontDa.ontdek_temp
    }
    }
