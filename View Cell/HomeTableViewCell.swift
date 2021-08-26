//
//  HomeTableViewCell.swift
//  SPP
//
//  Created by sanganan on 1/9/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
  @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var highlightBtn: UIButton!
    @IBOutlet weak var locButton: UIButton!
    @IBOutlet weak var alarmBtn: UIButton!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
 
