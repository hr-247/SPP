//
//  ontDetailDtaViewModal.swift
//  SPP
//
//  Created by sanganan on 2/27/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct OntDetDataViewModal : Decodable {
    
    var ontdek_adress : String?
    var ontdek_title : String?
    var ontdek_phone : String?
    var ontdek_email : String?
    var ontdek_image :  String?
    var ontdek_web : String?
    var ontdek_lat : String?
    var ontdek_long : String?
    var ontdek_link : String?
    var tips_extra_image : [String]?
    
    init(ontdetData : OntDetDataModal) {
        self.ontdek_adress = ontdetData.ontdek_adress
        self.ontdek_title = ontdetData.ontdek_title?.removeHTMLChar()
        self.ontdek_phone = ontdetData.ontdek_phone
        self.ontdek_email = ontdetData.ontdek_email
        self.ontdek_image =  ontdetData.ontdek_image
        self.ontdek_web = ontdetData.ontdek_web
        self.ontdek_lat = ontdetData.ontdek_lat
        self.ontdek_long = ontdetData.ontdek_long
        self.ontdek_link = ontdetData.ontdek_link
        self.tips_extra_image = ontdetData.tips_extra_image
        
    }
   
}
