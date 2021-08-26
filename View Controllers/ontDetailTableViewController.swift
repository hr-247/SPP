//
//  ontDetailTableViewController.swift
//  SPP
//
//  Created by sanganan on 1/13/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
import SafariServices

class ontDetailTableViewController: UIViewController {
    
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var webLbl: UIButton!
  
    @IBOutlet weak var gifBut: UIButton!
    @IBOutlet weak var ontDetMap: UIButton!
    
    var destLat : String = String()
    var destLong : String = String()
    
    
   private var ontDetDataArr = [OntDetDataViewModal]()
    var tagNo : Int = Int()
    var detailId : Int = Int()
    var detailIdArr : [Int] = [Int]()
    var templateArr : [String] = [String]()
    var fromClass : UIViewController?
    var template : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = "OntdekKey".localizableString(loc: Constant.langPath)
        self.commonNavigationBar(title: title, controller: Constant.Controllers.ontdetail)
        self.getOntdekDetails(temp: self.template, idNo : self.detailId)
        let rightSwipe = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .left
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(rightSwipe)
    }
    @objc private func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .left) {
            let btn = UIButton()
            self.forward(btn)
        }
    }
    
    
    @IBAction private func back(_ sender: Any) {
        if self.tagNo <= 0
        {
            return
        }else{
            let vc = Constant.Controllers.detail.get() as! detailTableViewController
            self.navigationController?.popViewController(animated: true)
            vc.tagNo = self.tagNo - 1
        }
    }
    
    
    @IBAction private func forward(_ sender: Any) {
        if self.tagNo >= detailIdArr.count-1
        {
            return
        }else{
            let vc = Constant.Controllers.ontdetail.get() as! ontDetailTableViewController
            vc.tagNo = self.tagNo + 1
            vc.detailId = detailIdArr[vc.tagNo]
            vc.fromClass = self.fromClass
            vc.detailIdArr = self.detailIdArr
            vc.templateArr = self.templateArr
            vc.template = self.templateArr[vc.tagNo]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    //MARK:- Ontdek Details API
   private func getOntdekDetails(temp : String,idNo : Int)
    {
        Utils.startLoading(view)
        
        let url : String = "\(Constant.APIs.baseURL)/ontdek_details?template=\(temp)&id=\(idNo)&uname=\(Constant.APIs.uName)&apikey=\(Constant.APIs.apiKey)"
        Service.sharedInstance.getRequest(Url:url,modalName:ontDetailModal.self,completion: { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if response?.Status == 200
                {
                    if response?.Item.isEmpty == true
                    {
                        AppUtils.showToast(message: "NoDataKey".localizableString(loc: Constant.langPath))
                    }else{
                        for item in (response?.Item)!
                        {
                            let modal = OntDetDataViewModal(ontdetData: item)
                            self.ontDetDataArr.append(modal)
                        }
                        self.imgV.sd_setImage(with: URL(string: self.ontDetDataArr[0].ontdek_image!), placeholderImage: UIImage(named: "male_avtar"))
                        self.titleLbl.text = self.ontDetDataArr[0].ontdek_title?.removeHTMLChar()
                        self.addLbl.text = self.ontDetDataArr[0].ontdek_adress
                        self.emailLbl.text = self.ontDetDataArr[0].ontdek_email
                        self.phoneLbl.text = self.ontDetDataArr[0].ontdek_phone
                        let web = self.ontDetDataArr[0].ontdek_web
                        self.webLbl.accessibilityHint = web
                        self.webLbl.setTitle(web, for: .normal)
                        self.webLbl.addTarget(self, action: #selector(self.openSite(sender:)), for: .touchUpInside)
                        if self.ontDetDataArr[0].ontdek_lat == "" && self.ontDetDataArr[0].ontdek_long == ""
                        {
                            self.ontDetMap.isHidden = true
                        }else{
                            self.ontDetMap.isHidden = false
                        }
//                        self.latLbl.text = self.ontDetDataArr[0].ontdek_lat
//                        self.longLbl.text = self.ontDetDataArr[0].ontdek_long
                        if self.ontDetDataArr[0].ontdek_link == ""
                        {
                            self.gifBut.isHidden = true
                        }else{
                            self.gifBut.isHidden = false
                            self.gifBut.accessibilityHint = self.ontDetDataArr[0].ontdek_link
                            self.gifBut.addTarget(self, action: #selector(self.openSite(sender:)), for: .touchUpInside)
                        }
                        self.ontDetMap.addTarget(self, action: #selector(self.ontMap), for: .touchUpInside)
                        
                    }
                }else{
                    AppUtils.showToast(message: "SomeWrongKey".localizableString(loc: Constant.langPath))
                }
            }
        })
    }
    @objc private func ontMap()
    {
        self.destLat = ontDetDataArr[0].ontdek_lat!
        self.destLong = ontDetDataArr[0].ontdek_long!
        
        self.showMapsAlert(lat: self.destLat, lon: self.destLong)

        
    }
    @objc override func openSite(sender : UIButton)
    {
        if let link = sender.accessibilityHint
        {
            if link.count <= 0
            {
                return
            }
            let safari = SFSafariViewController(url: URL(string: link)!)
            self.present(safari, animated: true, completion: nil)
        }
    }
}
