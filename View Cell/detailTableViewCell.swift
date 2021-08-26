//
//  detailTableViewCell.swift
//  SPP
//
//  Created by sanganan on 1/13/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class detailSec1TableViewCell: UITableViewCell {
    
   // @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var timeLineView: UIImageView!
    
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var dateBtn: UIButton!
    
    @IBOutlet weak var alarmBtn: UIButton!
    
    @IBOutlet weak var dateTymLbl: UILabel!
    
    
    @IBOutlet weak var tymLneHC: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tymLneHC.constant = 0.35 * UIScreen.main.bounds.width
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
