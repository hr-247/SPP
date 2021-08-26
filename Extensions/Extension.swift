//
//  Extension.swift
//  HowrahBridge
//
//  Created by Ankit  Jain on 20/12/19.
//  Copyright © 2019 Sanganan. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
@IBDesignable extension UIButton {
    @IBInspectable var imageColor: UIColor {
        get {
            return tintColor
        }
        set {
            tintColor = newValue
        }
    }
}
extension UIView {
    @IBInspectable var roundCorner : CGFloat{
        get {
            return self.frame.width/2
        }
        set{
            layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    @IBInspectable var borderWidth : CGFloat {
        set {
            layer.borderWidth = newValue
            self.clipsToBounds = true
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable  var borderColor : UIColor   {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor  = newValue.cgColor
        }
    }
}
extension UITextField{
    @IBInspectable var roundCornerTF : CGFloat{
        get {
            return self.frame.height/2
        }
        set{
            layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
}
//MARK:- UILabel
class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
extension Double {
    private var formatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }
    func secondsToString() -> String {
        return formatter.string(from: self) ?? ""
    }
}
extension UIButton {
    override open var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize
        
        let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right
        let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
        
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
}
extension UIViewController
{
    @objc func openSite(sender : UIButton)
    {
        if let link = sender.accessibilityHint
        {
            let safari = SFSafariViewController(url: URL(string: link)!)
            self.present(safari, animated: true, completion: nil)
        }
        
    }
    //MARK:- Tap Gesture
    public func tapGesture(forVc place: UIViewController, forView view:UIView ) {
        
        let tap = UITapGestureRecognizer(target: place, action: #selector(tapGestureActn))
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
    }
    @objc func tapGestureActn() {
        let vc = Constant.Controllers.profile.get() as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setImage(url : String) -> String
    {
        var resId : String = String()
        if (url.contains("icon-cultuur-bg.svg"))
        {
            resId = "cultureN"
        }
        else if (url.contains("icon-horeca-bg.svg"))
        {
            resId = "horecaN"
        }
        else if (url.contains("icon-sport-bg.svg"))
        {
            resId = "sportsN"
        }
        else if (url.contains("icon-uitagenda-bg.svg"))
        {
            resId = "uitagN"
        }
        else if (url.contains("icon-vrijetijd-bg.svg"))
        {
            resId = "vrijeN"
        }
        else if (url.contains("icon-winkels-bg.svg"))
        {
            resId = "winkelsN"
        }
        return resId
    }
    func setImageO(url : String) -> String
    {
        var resId : String = String()
        if (url.contains("icon-cultuur-bg.svg"))
        {
            resId = "Cultur"
        }
        else if (url.contains("icon-horeca-bg.svg"))
        {
            resId = "Horeca"
        }
        else if (url.contains("icon-sport-bg.svg"))
        {
            resId = "Sport"
        }
        else if (url.contains("icon-uitagenda-bg.svg"))
        {
            resId = "Uitag"
        }
        else if (url.contains("icon-vrijetijd-bg.svg"))
        {
            resId = "Vrije"
        }
        else if (url.contains("icon-winkels-bg.svg"))
        {
            resId = "Winkels"
        }
        return resId
    }
}


