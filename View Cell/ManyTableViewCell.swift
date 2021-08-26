//
//  ManyTableViewCell.swift
//  SPP
//
//  Created by sanganan on 2/5/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class ManyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gelichtLeading: NSLayoutConstraint!
    @IBOutlet weak var mapLeading: NSLayoutConstraint!
    @IBOutlet weak var mapWidth: NSLayoutConstraint!
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var balImg: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var hdngLbl: UILabel!
    @IBOutlet weak var dscTxtV: UILabel!
    @IBOutlet weak var moreB: UIButton!
    @IBOutlet weak var uitBtn: UIButton!
    @IBOutlet weak var mapB: UIButton!
    @IBOutlet weak var alrmBtn: UIButton!
    @IBOutlet weak var hghLghtWdth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.moreB.setTitle("MoreInKey".localizableString(loc: Constant.langPath), for: .normal)
        self.uitBtn.setTitle("UitgelichtKey".localizableString(loc: Constant.langPath), for: .normal)
        self.imgV.image = UIImage(named: "male_avtar")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
