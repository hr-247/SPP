//
//  OntdekCatViewModal.swift
//  SPP
//
//  Created by sanganan on 2/26/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
struct OntdekCatViewModal : Decodable {
    var ontdek_categry : String?
    var subcats : [String]?
    init(ontCat : OntdekCatModal) {
        self.ontdek_categry = ontCat.ontdek_categry
        self.subcats = ontCat.subcats
    }
}
