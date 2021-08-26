//
//  detailTableViewController.swift
//  SPP
//
//  Created by sanganan on 1/13/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class detailTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,detailSec3TableViewCellDelegate,UIWebViewDelegate {
    
    internal  func moreInfoDel(cellTag: Int) {
        let vc = Constant.Controllers.agRelDetails.get() as! AgendaRelatedDetailViewController
        vc.detailId = suggListArr[cellTag].agenda_related_id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet var detailTV: UITableView!
    
    private var agDetalsItmsArr = [agendaDetailsViewModal]()
    private var suggListArr = [SuggestionList]()
    var detailId : Int = Int()
    var detailIdArr : [Int] = [Int]()
    var tagNo : Int = Int()
    var fromClass : UIViewController?
    var lat : String = String()
    var long : String = String()
    private var date : String = String()
    private var webHght :  CGFloat = 0.0
    private var webStr : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navUI()
        xibRegister()
        getAgendaDetails(idNo: self.detailId)
        let rightSwipe = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .left
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(rightSwipe)
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
       // Utils.startLoading(self.view)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        Utils.stopLoading()
    }
    
    internal  func webViewDidFinishLoad(_ webView: UIWebView) {
        
        Utils.stopLoading()
        webView.scrollView.isScrollEnabled = false
       // webView.stringByEvaluatingJavaScript(from: "document.body.style.fontFamily =\"-apple-system\"")

        
        let hgt = webView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight")
        let n = NumberFormatter().number(from: hgt!)
        self.webHght = CGFloat(truncating: n!) + 10
        self.detailTV.reloadData()
        
        return
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
            let vc = Constant.Controllers.detail.get() as! detailTableViewController
            vc.tagNo = self.tagNo + 1
            vc.detailId = detailIdArr[vc.tagNo]
            vc.fromClass = self.fromClass
            vc.detailIdArr = self.detailIdArr
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc private  func mapD()
    {
        if agDetalsItmsArr.count == 0
        {
            return
        }
        
        let modal = agDetalsItmsArr[0]
        
        self.lat = modal.agenda_lat!
        self.long = modal.agenda_long!
        
        
        self.showMapsAlert(lat: self.lat, lon: self.long)

        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailSec1TableViewCell", for: indexPath) as! detailSec1TableViewCell
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailSec1TableViewCell", for: indexPath) as! detailSec1TableViewCell
            
            
            if let imgUrl =  agDetalsItmsArr[0].agenda_image
                       {
                            cell.timeLineView.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "male_avtar"))
                       }else{
                           cell.timeLineView.image = UIImage(named: "male_avtar")
                       }
            
            
           
            cell.headingLbl.text = agDetalsItmsArr[0].agenda_title!
            cell.alarmBtn.addTarget(self, action: #selector(alarm), for: .touchUpInside)
            cell.alarmBtn.accessibilityHint = "Alarm"
            cell.alarmBtn.accessibilityLabel = agDetalsItmsArr[0].agenda_title
            
            let dateFormatter = DateFormatter()
            let strDate = AppUtils.timestampToDate(timeStamp: Double(agDetalsItmsArr[0].agenda_start_date!))
            let endDate = AppUtils.timestampToDate(timeStamp: Double(agDetalsItmsArr[0].agenda_end_date!))
            //25 Feb, 20 13:30 PM
            dateFormatter.dateFormat = "dd MMM, yy hh:mm a"
            let dateFormat1 : String = "dd MMM"
            let dateS = dateFormatter.date(from:strDate)
            let dateE = dateFormatter.date(from:endDate)
            
            let strtDat = AppUtils.getParticularTimeFormat(format: dateFormat1, date: dateS!)
            let endDat = AppUtils.getParticularTimeFormat(format: dateFormat1, date: dateE!)
            if strtDat == endDat{
                self.date = strtDat
            }else{
                self.date = strtDat + " - "  + endDat
            }
            cell.alarmBtn.accessibilityValue = "\(agDetalsItmsArr[0].agenda_start_date)"
            
            cell.dateBtn.setTitle(self.date, for: .normal)
//            cell.dateTymLbl.text = strDate
            
            dateFormatter.dateFormat = "hh:mm a"

            
            cell.dateTymLbl.text = AppUtils.timestampToTime(timeStamp: Double(agDetalsItmsArr[0].agenda_start_date!)) + " - " + AppUtils.timestampToTime(timeStamp: Double(agDetalsItmsArr[0].agenda_end_date!))

            
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailSec2TableViewCell", for: indexPath) as! detailSec2TableViewCell
            
            if self.webHght == 0.0
            {
                cell.webView.delegate = self
                let font = UIFont(name: "SFUIDisplay-Light", size: 15)!
                           
                           let htmlString = "<span style=\"font-family:" + font.fontName + "; font-size: 15\"" + webStr + "</span>"
                           
                           
                           
                           cell.webView.loadHTMLString(htmlString, baseURL: URL(string: Constant.APIs.baseURL)!)
            }else
            {
                cell.webView.delegate = nil
            }
            
           
            cell.webImgHght.constant = webHght
            
            return cell
        }
        else if indexPath.row == 3
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailSec3TableViewCell", for: indexPath) as! detailSec3TableViewCell
            cell.sugListArr = suggListArr
            cell.delegate = self
            cell.reloadCollection()
            return cell
        }
        else if indexPath.row == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailSec4TableViewCell", for: indexPath) as! detailSec4TableViewCell
            cell.cityLbl.text = agDetalsItmsArr[0].agenda_city
            cell.locLbl.text = agDetalsItmsArr[0].agenda_street
            cell.organisLbl.text = agDetalsItmsArr[0].agenda_orginager!
            cell.phoneLbl.text = agDetalsItmsArr[0].agenda_phone!
            cell.emailLbl.text = agDetalsItmsArr[0].agenda_email!
            
            switch agDetalsItmsArr[0].agenda_price! {
            case .string(let text):
                cell.priceLbl.text = "€ " + text
            case .float(let num):
                cell.priceLbl.text = "€ " + String(describing: num)
            case .int(let num1):
                cell.priceLbl.text = "€ " + String(describing: num1)
            }
            
            let url = agDetalsItmsArr[0].agenda_website
            if url == ""
            {
                
            }else{
                cell.bTN.accessibilityHint = url
                cell.bTN.addTarget(self, action: #selector(openSite(sender:)) , for: .touchUpInside)
            }
            
            return cell
        }
        return cell
    }
    //MARK:- Agenda Details API
    private func getAgendaDetails(idNo : Int)
    {
        Utils.startLoading(view)
        
        let url : String = "\(Constant.APIs.baseURL)/agenda_details?id=\(idNo)&uname=\(Constant.APIs.uName)&apikey=\(Constant.APIs.apiKey)"
        Service.sharedInstance.getRequest(Url:url,modalName:agendaDetailsModal.self,completion: { (response, error) in
            DispatchQueue.main.async {
                if response?.Status == 200
                {
                    if response?.Item?.isEmpty == true
                    {
                        Utils.stopLoadingInView(self.view)

                        AppUtils.showToast(message: "NoDataKey".localizableString(loc: Constant.langPath))
                    }else{
                        for item in (response?.Item)!
                        {
                            let modal = agendaDetailsViewModal(agDetailsItems : item)
                            self.agDetalsItmsArr.append(modal)
                        }
                        
                        let scrWidth = UIScreen.main.bounds.width
                        self.webStr = self.agDetalsItmsArr[0].agenda_desc!.removingRegexMatches(pattern: "([width=\"]{7}[0-9]{1,4})", replaceWith: "width=\(scrWidth-50)")
                        
                        
                        let width = self.agDetalsItmsArr[0].agenda_desc!.slice(from: "style=\"width: ", to: "px")
                        let height = self.webStr.slice(from: " height: ", to: "px")
                        
                        if let wd = width, let hg = height
                        {
                            let newHgt = (Float(scrWidth-50) * hg.floatValue) / wd.floatValue
                            self.webStr = self.agDetalsItmsArr[0].agenda_desc!.removingRegexMatches(pattern: "([style=\"width: ]{14}[0-9]{1,4})", replaceWith: "style=\"width:\(scrWidth-50)")
                            
                            self.webStr = self.webStr.removingRegexMatches(pattern: "([height: ]{8}[0-9]{1,4})", replaceWith: "height=\(newHgt)")
                            //print("width from html", width, height,newHgt,html)
                            
                        }
                        
                        for item in (response?.suggestion_list)!
                        {
                            let modal = SuggestionList(list: item)
                            self.suggListArr.append(modal)
                        }
                        self.detailTV.dataSource = self
                        self.detailTV.delegate = self
                        self.detailTV.reloadData()

                    }
                }else{
                    Utils.stopLoadingInView(self.view)

                    AppUtils.showToast(message: "SomeWrongKey".localizableString(loc: Constant.langPath))
                }
            }
        })
    }
}

extension detailTableViewController
{
    private func xibRegister()
    {
        detailTV.register(UINib(nibName: "detailSec1TableViewCell", bundle: nil), forCellReuseIdentifier: "detailSec1TableViewCell")
        detailTV.register(UINib(nibName: "detailSec2TableViewCell", bundle: nil), forCellReuseIdentifier: "detailSec2TableViewCell")
        detailTV.register(UINib(nibName: "detailSec3TableViewCell", bundle: nil), forCellReuseIdentifier: "detailSec3TableViewCell")
        detailTV.register(UINib(nibName: "detailSec4TableViewCell", bundle: nil), forCellReuseIdentifier: "detailSec4TableViewCell")
    }
    private  func navUI()
    {
        self.title = "Details"
        navigationController?.navigationBar.barTintColor = Constant.purpleColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if self.lat == "" && self.long == ""
        {
            
        }else{
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "map"), for: .normal)
        button2.addTarget(self, action: #selector(mapD), for: .touchUpInside)
        button2.heightAnchor.constraint(equalToConstant: 23).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 27).isActive = true
        let barButtonItem2 = UIBarButtonItem(customView: button2)
            self.navigationItem.rightBarButtonItems  = [barButtonItem2]}
        let button3 = UIButton(type: .custom)
        button3.setImage(UIImage(named: "back"), for: .normal)
        button3.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        button3.heightAnchor.constraint(equalToConstant: 23).isActive = true
        button3.widthAnchor.constraint(equalToConstant: 27).isActive = true
        let barButtonItem3 = UIBarButtonItem(customView: button3)
        self.navigationItem.leftBarButtonItem  = barButtonItem3
    }
}

extension String {
    
    internal  func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
    internal var floatValue: Float {
        return (self as NSString).floatValue
    }
    
}

