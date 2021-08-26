//
//  ontdekModal.swift
//  SPP
//
//  Created by sanganan on 2/14/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct ontdekModal : Decodable{
    var Status : Int?
    var Item : [ontDataModal]?
    
    enum  Codingkey : String {
        case Status = "Status"
        case Item = "Item"
    }
    
}
struct ontDataModal : Decodable
{
    var  ontdek_adress : String?
    var  ontdek_title : String?
    var  ontdek_intro : String?
    var  ontdek_image : String?
    var  ontdek_phone  : String?
    var ontdek_web : String?
    
    enum CodingKey : String {
        case ontdek_adress = "ontdek_adress"
        case  ontdek_title = "ontdek_title"
        case  ontdek_intro = "ontdek_intro"
        case  ontdek_image = "ontdek_image"
        case  ontdek_phone  = "ontdek_phone"
        case ontdek_web = "ontdek_web"
    }
}
