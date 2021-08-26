//
//  ontdekTableViewCell.swift
//  SPP
//
//  Created by sanganan on 1/13/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class ontdekTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nmeLbl: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var numLbl: UILabel!
    @IBOutlet weak var siteLbl: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var giftImgView: UIImageView!
    @IBOutlet weak var ontMapWid: NSLayoutConstraint!
    @IBOutlet weak var ontMapLdg: NSLayoutConstraint!
    @IBOutlet weak var gifImgWid: NSLayoutConstraint!
    @IBOutlet weak var gifImgLdg: NSLayoutConstraint!
    @IBOutlet weak var ontBut: UIButton!
    
    
    @IBOutlet weak var gifBut: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
