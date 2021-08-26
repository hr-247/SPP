//
//  UitagendaViewController.swift
//  SPP
//
//  Created by sanganan on 2/5/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//
import UIKit
import ScrollableSegmentedControl


class UitagendaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var uitSeg : ScrollableSegmentedControl!
    @IBOutlet weak var uitTV: UITableView!
    
    private var uitAgendaDtaArr = [agendaDataViewModal]()
    private var uitAgendaFilArr = [agendaFilterViewModal]()
    private var filName : String = String()
    private var moreData : Bool = false
    private var pageNo : Int = 1
    private var destLat : String = String()
    private var destLong : String = String()
    
    @IBOutlet weak var noDataLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addAnimateView()
        
        self.noDataLbl.text = "NoDataKey".localizableString(loc: Constant.langPath)
        let title = "UITagendaKey".localizableString(loc: Constant.langPath)
        self.commonNavigationBar(title: title, controller: Constant.Controllers.uitagenda)
        xibReg()
        
        getUitAgFilter()
    }
    
    func addAnimateView()
    {
        let imgView = UIImageView(frame: self.view.bounds)
        imgView.image = UIImage(named: "splash")
        self.navigationController?.view.addSubview(imgView)

        UIView.animate(withDuration: 3, delay: 1, options: .transitionFlipFromLeft, animations: {
            
              imgView.alpha = 0
        }) { _ in
            
            imgView.removeFromSuperview()
          
        }
        
        
    }
    
    
    func makeRightBarButton()
    {
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "map"), for: .normal)
        button2.addTarget(self, action: #selector(mapBtnClicked), for: .touchUpInside)
        button2.heightAnchor.constraint(equalToConstant: 23).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 27).isActive = true
        let barButtonItem2 = UIBarButtonItem(customView: button2)
        self.navigationItem.rightBarButtonItems  = [barButtonItem2]
    }
    @objc func mapBtnClicked()
    {
        let vc = Constant.Controllers.map.get() as! MapViewController
        
        var array = [MapDataModal]()
        for item in uitAgendaDtaArr
        {
            array.append(MapDataModal(latitude: item.agenda_lat, longitude: item.agenda_long, title: item.agenda_title, description: item.agenda_intro, cat: item.agenda_icon))
        }
        vc.mapArray = array
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moreData == true{
            return uitAgendaDtaArr.count + 1
        }else{
            return uitAgendaDtaArr.count
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < uitAgendaDtaArr.count
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManyTableViewCell", for: indexPath) as! ManyTableViewCell
            if uitAgendaDtaArr[indexPath.row].agenda_lat == "" && uitAgendaDtaArr[indexPath.row].agenda_long == ""
            {
                cell.mapLeading.constant = 0
                cell.mapWidth.constant = 0
                cell.mapB.isHidden = true
            }else{
                cell.mapB.isHidden = false
                cell.mapWidth.constant = 25
                cell.mapLeading.constant = 15;
            }
            cell.moreB.tag = indexPath.row
            cell.hghLghtWdth.constant = 0
            cell.uitBtn.isHidden = true
            cell.hdngLbl.text =  uitAgendaDtaArr[indexPath.row].agenda_title!
            cell.dscTxtV.text = uitAgendaDtaArr[indexPath.row].agenda_intro!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            
            //            cell.imgV.sd_setImage(with: URL(string: uitAgendaDtaArr[indexPath.row].agenda_image!), placeholderImage: UIImage(named: "male_avtar"))
            if let imgUrl = uitAgendaDtaArr[indexPath.row].agenda_image
            {
                cell.imgV.sd_setImage(with: URL(string: imgUrl))
            }else{
                cell.imgV.image = UIImage(named: "male_avtar")
            }
            //  cell.imgV.sd_setImage(with: URL(string: uitAgendaDtaArr[indexPath.row].agenda_image!), placeholderImage: UIImage(named: "male_avtar"))
            cell.balImg.image = UIImage(named: setImage(url: uitAgendaDtaArr[indexPath.row].agenda_icon!))
            cell.moreB.addTarget(self, action: #selector(moreInfo(sender: )), for: .touchUpInside)
            cell.mapB.addTarget(self, action: #selector(mapL), for: .touchUpInside)
            cell.alrmBtn.accessibilityHint = "Alarm"
            cell.alrmBtn.accessibilityLabel = uitAgendaDtaArr[indexPath.row].agenda_title
            cell.alrmBtn.addTarget(self, action: #selector(alarm), for: .touchUpInside)
            let dateFormatter = DateFormatter()
            let strDate = AppUtils.timestampToDate(timeStamp: Double(uitAgendaDtaArr[indexPath.row].agenda_start_date!))
            let endDate = AppUtils.timestampToDate(timeStamp: Double(uitAgendaDtaArr[indexPath.row].agenda_end_date!))
            //25 Feb, 20 13:30 PM
            dateFormatter.dateFormat = "dd MMM, yy hh:mm a"
            let dateFormat1 : String = "dd MMM"
            let dateS = dateFormatter.date(from:strDate)
            let dateE = dateFormatter.date(from:endDate)
            
            let strtDat = AppUtils.getParticularTimeFormat(format: dateFormat1, date: dateS!)
            let endDat = AppUtils.getParticularTimeFormat(format: dateFormat1, date: dateE!)
            if strtDat == endDat
            {
                cell.dateLbl.text = strtDat
            }else{
                cell.dateLbl.text = strtDat + " - " + endDat
            }
            cell.alrmBtn.accessibilityValue = "\(uitAgendaDtaArr[indexPath.row].agenda_start_date!)"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlankTableViewCell", for: indexPath) as! BlankTableViewCell
            for viw in cell.subviews
            {
                if viw is UIActivityIndicatorView
                {
                    let indicatr = viw as! UIActivityIndicatorView
                    indicatr.removeFromSuperview()
                    break
                }
            }
            
            cell.addSubview(AppUtils.activityIndicator())
            cell.backgroundColor = UIColor.clear;
            cell.tag = 99999
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.tag == 99999 {
            self.pageNo += 1
            getUitAgData(filN: self.filName, pageN: self.pageNo)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: .custom)
        btn.tag = indexPath.row
        self.moreInfo(sender: btn)
    }
    
    @objc private func moreInfo(sender : UIButton)
    {
        let vc = Constant.Controllers.detail.get() as! detailTableViewController
        
        for item in 0...self.uitAgendaDtaArr.count-1
        {
            let modal = uitAgendaDtaArr[item].agenda_id
            vc.detailIdArr.append(modal!)
        }
        vc.detailId = uitAgendaDtaArr[sender.tag].agenda_id!
        vc.lat = uitAgendaDtaArr[sender.tag].agenda_lat
        vc.long = uitAgendaDtaArr[sender.tag].agenda_long
        vc.tagNo = sender.tag
        vc.fromClass = self
        var array : [UIViewController]? = self.navigationController?.viewControllers
        for i in 0..<sender.tag
        {
            let vc1 = Constant.Controllers.detail.get() as! detailTableViewController
            
            for item in 0...self.uitAgendaDtaArr.count-1
            {
                let modal = uitAgendaDtaArr[item].agenda_id
                vc1.detailIdArr.append(modal!)
            }
            vc1.detailId = uitAgendaDtaArr[i].agenda_id!
            vc1.lat = uitAgendaDtaArr[i].agenda_lat
            vc1.long = uitAgendaDtaArr[i].agenda_long
            vc1.tagNo = i
            vc1.fromClass = self
            array?.append(vc1)
        }
        self.navigationController?.viewControllers = array!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func mapL(sender : UIButton)
    {
        self.destLat = uitAgendaDtaArr[sender.tag].agenda_lat
        self.destLong = uitAgendaDtaArr[sender.tag].agenda_long
        
        self.showMapsAlert(lat: self.destLat, lon: self.destLong)
        
        
    }
    
    //MARK:- AGENDA GET API
    private func getUitAgData(filN : String,pageN : Int) {
        
        self.noDataLbl.isHidden = true
        
        
        var url : String = "\(Constant.APIs.baseURL)/rest_agenda?filter=\(filN)&page=\(pageN)&uname=\(Constant.APIs.uName)&apikey=\(Constant.APIs.apiKey)"
        
        
        url = url.replacingOccurrences(of: " ", with: "%20")
        Service.sharedInstance.getRequest(Url:url,modalName:agendaModal.self,completion: { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if pageN == 1
                {
                    self.uitAgendaDtaArr.removeAll()
                    
                }
                if response?.Status == 200
                {
                    for item in (response?.Item)!
                    {
                        let modal = agendaDataViewModal(agenData: item)
                        self.uitAgendaDtaArr.append(modal)
                    }
                    if (response?.Item!.count)! < 10
                    {
                        self.moreData = false
                    }else{
                        self.moreData = true
                    }
                    
                    var toShow = false
                    
                    for item in self.uitAgendaDtaArr
                    {
                        if item.agenda_lat.count > 0 && item.agenda_long.count > 0  {
                            toShow = true
                            break;
                        }
                    }
                    
                    if toShow == true
                    {
                        self.makeRightBarButton()
                        
                    }else{
                        self.navigationItem.rightBarButtonItem = nil
                    }
                    
                    
                    if self.uitAgendaDtaArr.count == 0 {
                        self.noDataLbl.isHidden = false
                    }else{
                        self.noDataLbl.isHidden = true
                    }
                    
                    
                }else{
                    self.moreData = false
                    AppUtils.showToast(message: "SomeWrongKey".localizableString(loc: Constant.langPath))
                }
                self.uitTV.reloadData()
                
            }
        })
    }
    //MARK:- AGENDA FILTER GET API
    private  func getUitAgFilter()
    {
        Utils.startLoading(view)
        //  let url : String = "\(Constant.APIs.baseURL)/agenda_filter/?uname=\(Constant.APIs.uName)&apikey=\(Constant.APIs.apiKey)"
        
        let url : String = "\(Constant.APIs.baseURL)/agenda_filter?uname=\(Constant.APIs.uName)&apikey=\(Constant.APIs.apiKey)"
        
        Service.sharedInstance.getRequest(Url: url, modalName: agendaFilterModal.self) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if response?.Status == 200
                {
                    for item in (response?.Item)!
                    {
                        let modal = agendaFilterViewModal(agFilNm: item)
                        self.uitAgendaFilArr.append(modal)
                    }
                    //Uitgelicht
                    self.uitAgendaFilArr.insert(agendaFilterViewModal(title: "Alles"), at: 0)
                    
                    self.menuSegCon()
                }else{
                    AppUtils.showToast(message: "SomeWrongKey".localizableString(loc: Constant.langPath))
                }
            }
        }
        
    }
}
extension UitagendaViewController{
    private  func menuSegCon()
    {
        let textAttributes = [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-Light", size: 15.0), NSAttributedString.Key.foregroundColor: UIColor.white]
        uitSeg.setTitleTextAttributes(textAttributes as [NSAttributedString.Key : Any], for: .normal)
        uitSeg.segmentStyle = .textOnly
        for i in 0...uitAgendaFilArr.count-1
        {
            uitSeg.insertSegment(withTitle: uitAgendaFilArr[i].title!,at: i)
        }
        uitSeg.underlineSelected = true
        uitSeg.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        uitSeg.selectedSegmentIndex = 0
        uitSeg.backgroundColor = Constant.segBgClr
        uitSeg.fixedSegmentWidth = false
    }
    @objc private func segmentSelected(sender:ScrollableSegmentedControl) {
        self.filName = uitAgendaFilArr[sender.selectedSegmentIndex].title!
        self.pageNo = 1;
        if sender.selectedSegmentIndex == 0 {
            self.filName = "uitgelicht"
        }
        getUitAgData(filN: self.filName, pageN: self.pageNo)
    }
    private  func xibReg()
    {
        uitTV.register(UINib(nibName: "ManyTableViewCell", bundle: nil), forCellReuseIdentifier: "ManyTableViewCell")
        uitTV.register(UINib(nibName: "BlankTableViewCell", bundle: nil), forCellReuseIdentifier: "BlankTableViewCell")
        uitTV.delegate = self
        uitTV.dataSource  = self
    }
}
extension String
{
    internal  func removeHTMLChar() -> String
    {
        let str = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        guard let finalStr = String(htmlEncodedString: str) else { return ""}
        
        return finalStr
    }


    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}
