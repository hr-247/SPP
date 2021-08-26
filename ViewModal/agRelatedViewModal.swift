//
//  agRelatedViewModal.swift
//  SPP
//
//  Created by sanganan on 2/29/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct agRelatedViewModal {
   var agenda_related_id : Int?
    var agenda_related_title : String?
    var agenda_related_image : String?
    var agenda_related_price : QuantumValue?
    var agenda_related_date : Int?
    var aagenda_related_end_date : Int?
    var agenda_related_phone : String?
    var agenda_related_email : String?
    var agenda_related_city : String?
    var agenda_related_street : String?
    var agenda_related_orginager : String?
    var agenda_related_website : String?
    var agenda_related_start_time : Int?
    var agenda_related_end_time : Int?
    var agenda_related_desc : String?
    var aagenda_related_lat : String?
    var agenda_related_long : String?
    
    init(agDetailsItems : agRelatedItems) {
        self.agenda_related_id = agDetailsItems.agenda_related_id
        self.agenda_related_title = agDetailsItems.agenda_related_title?.removeHTMLChar()
        self.agenda_related_image = agDetailsItems.agenda_related_image
        self.agenda_related_price = agDetailsItems.agenda_related_price!
        self.agenda_related_date = agDetailsItems.agenda_related_date
        self.aagenda_related_end_date = agDetailsItems.aagenda_related_end_date
        self.agenda_related_phone = agDetailsItems.agenda_related_phone
        self.agenda_related_email = agDetailsItems.agenda_related_email
        self.agenda_related_city = agDetailsItems.agenda_related_city
        self.agenda_related_street = agDetailsItems.agenda_related_street
        self.agenda_related_orginager = agDetailsItems.agenda_related_orginager
        self.agenda_related_website = agDetailsItems.agenda_related_website
        self.agenda_related_start_time = agDetailsItems.agenda_related_start_time
        self.agenda_related_end_time = agDetailsItems.agenda_related_end_time
        self.agenda_related_desc = agDetailsItems.agenda_related_desc
        self.aagenda_related_lat = agDetailsItems.aagenda_related_lat
        self.agenda_related_long = agDetailsItems.agenda_related_long
    }
}

