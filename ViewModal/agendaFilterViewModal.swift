//
//  agendaFilterViewModal.swift
//  SPP
//
//  Created by sanganan on 2/18/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct agendaFilterViewModal{
        var title : String?
        
    init(agFilNm : agFilNmModal) {
        self.title = agFilNm.title
    }
    
    init(title : String) {
        self.title = title
    }
    
}
