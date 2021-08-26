//
//  IBInspecatbleExt.swift
//  SPP
//
//  Created by sanganan on 1/15/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
extension UIView{
    @IBInspectable var roundCorner : CGFloat{
        get {
            return self.frame.width/2
        }
        set{
            layer.cornerRadius = newValue
    }
}
    @IBInspectable var borderWidth : CGFloat{
           get {
            return self.frame.width
           }
           set{
               layer.borderWidth = newValue
       }
}
     @IBInspectable var borderColor : UIColor{
               get {
                return self.borderColor
               }
               set{
                layer.borderColor = newValue.cgColor
           }
    }
}

