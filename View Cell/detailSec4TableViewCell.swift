//
//  detailSec4TableViewCell.swift
//  SPP
//
//  Created by sanganan on 1/13/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class detailSec4TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var prijLbl: UILabel!
    @IBOutlet weak var locatieLbl: UILabel!
    @IBOutlet weak var lBL: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var bTN: UIButton!
    @IBOutlet weak var contactLabl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var organisLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let btn = "GotoWebsiteKey".localizableString(loc: Constant.langPath)
        self.bTN.setTitle(btn, for: .normal)
        self.locatieLbl.text = "LocationKey".localizableString(loc: Constant.langPath)
        self.lBL.text = "OrganizerKey".localizableString(loc: Constant.langPath)
        self.contactLabl.text = "ContactKey".localizableString(loc: Constant.langPath)
        self.priceLbl.text = "PriceKey".localizableString(loc: Constant.langPath)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
