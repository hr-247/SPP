//
//  MenuTableViewCell.swift
//  SPP
//
//  Created by sanganan on 1/10/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var badgeLbl: UILabel!
    
    @IBOutlet weak var menuLbl: UILabel!
    
    @IBOutlet weak var menuImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.badgeLbl.layer.cornerRadius = badgeLbl.frame.width/2
        self.badgeLbl.layer.masksToBounds = true
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
