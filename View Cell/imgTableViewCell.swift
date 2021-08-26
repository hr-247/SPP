//
//  imgTableViewCell.swift
//  SPP
//
//  Created by sanganan on 1/13/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class imgTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imgView2: UIImageView!
    
    @IBOutlet weak var imgVHC: NSLayoutConstraint!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgVHC.constant = 0.35 * UIScreen.main.bounds.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
