//
//  agendaDetailsViewModal.swift
//  SPP
//
//  Created by sanganan on 2/22/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation

struct agDetailsViewModal {
    var Status : Int?
    var Item : [agendaDetailsItems]?
    var suggestion_list : [suggestionList]?
    init(agDetails : agendaDetailsModal) {
        self.Status = agDetails.Status
        self.Item = agDetails.Item
        self.suggestion_list  = agDetails.suggestion_list
    }
}
struct agendaDetailsViewModal {
    var agenda_id : Int?
    var agenda_title : String?
    var  agenda_intro : String?
    var agenda_image : String?
    var agenda_price : QuantumValue?
    var agenda_start_date : Int?
    var agenda_end_date : Int?
    var agenda_phone : String?
    var agenda_email : String?
    var agenda_city : String?
    var agenda_street : String?
    var agenda_orginager : String?
    var agenda_website : String?
    var agenda_start_time : Int?
    var agenda_end_time : Int?
    var agenda_lat : String?
    var agenda_long : String?
    var agenda_desc : String?
    
    init(agDetailsItems : agendaDetailsItems) {
        self.agenda_id = agDetailsItems.agenda_id
        self.agenda_title = agDetailsItems.agenda_title?.removeHTMLChar()
        self.agenda_intro = agDetailsItems.agenda_intro
        self.agenda_image = agDetailsItems.agenda_image
        self.agenda_price = agDetailsItems.agenda_price
        self.agenda_start_date = agDetailsItems.agenda_start_date
        self.agenda_end_date = agDetailsItems.agenda_end_date
        self.agenda_phone = agDetailsItems.agenda_phone
        self.agenda_email = agDetailsItems.agenda_email
        self.agenda_city = agDetailsItems.agenda_city
        self.agenda_street = agDetailsItems.agenda_street
        self.agenda_orginager = agDetailsItems.agenda_orginager
        self.agenda_website = agDetailsItems.agenda_website
        self.agenda_start_time = agDetailsItems.agenda_start_time
        self.agenda_end_time = agDetailsItems.agenda_end_time
        self.agenda_lat = agDetailsItems.agenda_lat
        self.agenda_long = agDetailsItems.agenda_long
        self.agenda_desc = agDetailsItems.agenda_desc
    }
}
struct  SuggestionList {
    var agenda_related_id : Int?
    var agenda_related_title : String?
    var agenda_related_image :  String?
    var agenda_related_start_date : Int?
    
    init(list : suggestionList) {
        self.agenda_related_id = list.agenda_related_id
        self.agenda_related_title = list.agenda_related_title?.removeHTMLChar()
        self.agenda_related_image = list.agenda_related_image
        self.agenda_related_start_date = list.agenda_related_start_date
    }
}
