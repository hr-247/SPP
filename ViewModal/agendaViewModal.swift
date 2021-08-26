//
//  agendaViewModal.swift
//  SPP
//
//  Created by sanganan on 2/14/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct agendaViewModal
{
    var Status : Int?
    var Item : [agendaDataModal]?
    init(agenda : agendaModal) {
        self.Status = agenda.Status
        self.Item = agenda.Item
    }
}

struct agendaDataViewModal {
     var agenda_id : Int?
    var agenda_title : String?
    var agenda_intro : String?
    var agenda_image : String?
    var agenda_start_date : Int?
    var agenda_end_date : Int?
     var agenda_icon : String?
    var agenda_lat : String
    var agenda_long : String
    var agenda_is_uitgelitch : Int?
    init(agenData : agendaDataModal) {
        self.agenda_id = agenData.agenda_id!
        if let title = agenData.agenda_title
        {
            self.agenda_title = title.removeHTMLChar()
            
        }else{
            self.agenda_title = "No Title"
        }
        self.agenda_intro = agenData.agenda_intro
        self.agenda_image = agenData.agenda_image
        self.agenda_start_date = agenData.agenda_start_date
        self.agenda_end_date = agenData.agenda_end_date
        self.agenda_icon = agenData.agenda_icon
        if let lat = agenData.agenda_lat
        {
        self.agenda_lat = lat
        }else{
        self.agenda_lat = "0.0"
        }
        if let long = agenData.agenda_long
        {
        self.agenda_long = long
        }else{
        self.agenda_long = "0.0"
        }
        self.agenda_is_uitgelitch = agenData.agenda_is_uitgelitch
         
    }
}
