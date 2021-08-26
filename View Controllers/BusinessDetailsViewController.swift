//
//  BusinessDetailsViewController.swift
//  SPP
//
//  Created by sanganan on 2/25/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class BusinessDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var bDetailsTV: UITableView!
    
    var busiDetalsItmsArr = [BdetailsViewModal]()
    var busiDetailId : Int = Int()
    var detailIdArr : [Int] = [Int]()
    var tagNo : Int =  Int()
    var fromClass : UIViewController?
//    var lat : String = String()
//    var long : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = "BusinessDetKey".localizableString(loc: Constant.langPath)
        self.commonNavigationBar(title: title, controller: Constant.Controllers.tips)
        xibRegister()
        getTipDetails()
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
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction private func forward(_ sender: Any) {
        if self.tagNo >= detailIdArr.count-1
        {
            return
        }else{
            let vc = Constant.Controllers.bDetails.get() as! BusinessDetailsViewController
            vc.tagNo = self.tagNo + 1
            vc.busiDetailId = detailIdArr[vc.tagNo]
            // vc.lat = busiDetalsItmsArr[vc.tagNo].lat
            vc.fromClass = self.fromClass
            vc.detailIdArr = self.detailIdArr
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailSec1TableViewCell", for: indexPath) as! detailSec1TableViewCell
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailSec1TableViewCell", for: indexPath) as! detailSec1TableViewCell
            cell.alarmBtn.addTarget(self, action: #selector(alarm), for: .touchUpInside)
            cell.alarmBtn.accessibilityHint = "Business"
            cell.alarmBtn.accessibilityLabel = busiDetalsItmsArr[0].news_title
            cell.alarmBtn.accessibilityValue = "\(busiDetalsItmsArr[0].news_date)"
            cell.timeLineView.sd_setImage(with: URL(string:  busiDetalsItmsArr[0].news_image!),placeholderImage: UIImage(named: "male_avtar"))
            cell.headingLbl.text = busiDetalsItmsArr[0].news_title!
            
            let dateFormatter = DateFormatter()
            let strDate = AppUtils.timestampToDate(timeStamp: Double(busiDetalsItmsArr[0].news_date!))
            dateFormatter.dateFormat = "dd MMM, yy hh:mm a"
            let dateFormat1 : String = "dd MMM"
            let dateS = dateFormatter.date(from:strDate)
            let strtDat = AppUtils.getParticularTimeFormat(format: dateFormat1, date: dateS!)
            cell.dateBtn.setTitle(strtDat, for: .normal)
            
            cell.dateTymLbl.text = AppUtils.timestampToTime(timeStamp: Double(busiDetalsItmsArr[0].news_date!))
            
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailSec2TableViewCell", for: indexPath) as! detailSec2TableViewCell
            cell.txtView.isHidden = false
           // cell.webView.isHidden = true
            cell.webView.removeFromSuperview()
            cell.txtView.text = busiDetalsItmsArr[0].news_det!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            return cell
        }
        else if indexPath.row == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ytPlayerTableViewCell", for: indexPath) as! ytPlayerTableViewCell
            
            if let yt = cell.ytPlayer
            {
                 cell.ytPlyerHght.constant = 0
                yt.removeFromSuperview()
            }
            
          
            cell.alrmBtn.isHidden = true
            // cell.ytPlayer.isHidden = true
            
            cell.bTN.accessibilityHint = busiDetalsItmsArr[0].news_website
            cell.bTN.addTarget(self, action: #selector(openSite(sender:)), for: .touchUpInside)
            return cell
        }
        return cell
    }
    //MARK:- GET TIPS DETAILS
   private func getTipDetails()
    {
        Utils.startLoading(view)
        
        let url : String = "\(Constant.APIs.baseURL)/news_details?id=\(self.busiDetailId)&uname=\(Constant.APIs.uName)&apikey=\(Constant.APIs.apiKey)"
        Service.sharedInstance.getRequest(Url:url,modalName:businessDetailsModal.self,completion: { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                
                if response?.Status == 200
                {
                    for item in (response?.Item)!
                    {
                        let modal = BdetailsViewModal(bDItems: item!)
                        self.busiDetalsItmsArr.append(modal)
                    }
                    self.bDetailsTV.reloadData()
                    self.bDetailsTV.dataSource = self
                    self.bDetailsTV.delegate = self
                }else{
                    AppUtils.showToast(message: "SomeWrongKey".localizableString(loc: Constant.langPath))
                }
            }
        })
    }
}
extension BusinessDetailsViewController
{
  private  func xibRegister()
    {
        bDetailsTV.register(UINib(nibName: "detailSec1TableViewCell", bundle: nil), forCellReuseIdentifier: "detailSec1TableViewCell")
        bDetailsTV.register(UINib(nibName: "detailSec2TableViewCell", bundle: nil), forCellReuseIdentifier: "detailSec2TableViewCell")
        //   bDetailsTV.register(UINib(nibName: "detailSec3TableViewCell", bundle: nil), forCellReuseIdentifier: "detailSec3TableViewCell")
        bDetailsTV.register(UINib(nibName: "ytPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "ytPlayerTableViewCell")
    }
}






