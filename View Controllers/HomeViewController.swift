//

import UIKit
import SideMenu
import  ScrollableSegmentedControl
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    // @IBOutlet weak var menuSeg : ScrollableSegmentedControl!
    @IBOutlet weak var homeTV : UITableView!
    @IBOutlet weak var segHeight: NSLayoutConstraint!
    @IBOutlet weak var noDataLbl: UILabel!
    
   private var agendaDtaArr = [agendaDataViewModal]()
   private  var agendaFilArr = [agendaFilterViewModal]()
   private var filName : String = String()
   private var moreData : Bool = false
   private var pageNo : Int = 1
   private  var destLat : String = String()
   private var destLong : String = String()
   private var mapArr : [String] = [String]()
    let titleNav = "UitgelichtKey".localizableString(loc: Constant.langPath)

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.noDataLbl.text = "NoDataKey".localizableString(loc: Constant.langPath)

        self.segHeight.constant = 0
        self.commonNavigationBar(title: titleNav, controller: Constant.Controllers.home)
        
        self.xibReg()
        Utils.startLoading(self.view)
        getAgenda(pageN : self.pageNo)
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
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.swipeBackGesture()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moreData == true{
            return agendaDtaArr.count + 1
        }else{
            return agendaDtaArr.count
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < agendaDtaArr.count
        {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "ManyTableViewCell", for: indexPath) as! ManyTableViewCell
            
            if agendaDtaArr[indexPath.row].agenda_is_uitgelitch == 0
            {
                cell.gelichtLeading.constant = 0
                cell.hghLghtWdth.constant = 0
                cell.uitBtn.isHidden = true
            }
            else{
                cell.gelichtLeading.constant = 10
                cell.hghLghtWdth.constant = 81
                cell.uitBtn.isHidden = false
            }
            cell.moreB.tag = indexPath.row
            cell.mapB.tag = indexPath.row
            cell.hdngLbl.text =  agendaDtaArr[indexPath.row].agenda_title!
            cell.dscTxtV.text = agendaDtaArr[indexPath.row].agenda_intro!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            //            cell.imgV.sd_setImage(with: URL(string: agendaDtaArr[indexPath.row].agenda_image!), placeholderImage: UIImage(named: "male_avtar"))
            if let imgUrl = agendaDtaArr[indexPath.row].agenda_image
            {
                cell.imgV.sd_setImage(with: URL(string: imgUrl))
            }else{
                cell.imgV.image = UIImage(named: "male_avtar")
            }
            //            cell.balImg.sd_setImage(with: URL(string: agendaDtaArr[indexPath.row].agenda_icon!), placeholderImage: UIImage(named: "balloon"))
            cell.balImg.image = UIImage(named: setImage(url: agendaDtaArr[indexPath.row].agenda_icon!))
            
            cell.moreB.addTarget(self, action: #selector(moreInfo(sender: )), for: .touchUpInside)
            cell.alrmBtn.addTarget(self, action: #selector(alarm), for: .touchUpInside)
            cell.alrmBtn.accessibilityHint = "Alarm"
            cell.alrmBtn.accessibilityLabel = agendaDtaArr[indexPath.row].agenda_title
            
            if agendaDtaArr[indexPath.row].agenda_lat == "" && agendaDtaArr[indexPath.row].agenda_long == ""
            {
                cell.mapB.isHidden = true
                cell.mapWidth.constant = 0
                cell.mapLeading.constant = 0
            }else{
                cell.mapB.isHidden = false
                cell.mapWidth.constant = 25
                cell.mapLeading.constant = 15
            }
            cell.mapB.addTarget(self, action: #selector(map(sender: )), for: .touchUpInside)
            
            let dateFormatter = DateFormatter()
            let strDate = AppUtils.timestampToDate(timeStamp: Double(agendaDtaArr[indexPath.row].agenda_start_date!))
            let endDate = AppUtils.timestampToDate(timeStamp: Double(agendaDtaArr[indexPath.row].agenda_end_date!))
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
            cell.alrmBtn.accessibilityValue = "\(agendaDtaArr[indexPath.row].agenda_start_date!)"
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
            getAgenda(pageN: self.pageNo)
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
        
        for item in 0...self.agendaDtaArr.count-1
        {
            let modal = agendaDtaArr[item].agenda_id
            vc.detailIdArr.append(modal!)
        }
        vc.detailId = agendaDtaArr[sender.tag].agenda_id!
        vc.lat = agendaDtaArr[sender.tag].agenda_lat
        vc.long = agendaDtaArr[sender.tag].agenda_long
        vc.tagNo = sender.tag
        vc.fromClass = self
        var array : [UIViewController]? = self.navigationController?.viewControllers
        for i in 0..<sender.tag
        {
            let vc1 = Constant.Controllers.detail.get() as! detailTableViewController
            
            for item in 0...self.agendaDtaArr.count-1
            {
                let modal = agendaDtaArr[item].agenda_id
                vc1.detailIdArr.append(modal!)
            }
            vc1.detailId = agendaDtaArr[i].agenda_id!
            vc1.lat = agendaDtaArr[i].agenda_lat
            vc1.long = agendaDtaArr[i].agenda_long
            vc1.tagNo = i
            vc1.fromClass = self
            array?.append(vc1)
        }
        self.navigationController?.viewControllers = array!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func mapBtnClicked()
    {
        let vc = Constant.Controllers.map.get() as! MapViewController
        
        var array = [MapDataModal]()
        for item in agendaDtaArr
        {
            array.append(MapDataModal(latitude: item.agenda_lat, longitude: item.agenda_long, title: item.agenda_title, description: item.agenda_intro, cat:item.agenda_icon))
        }
        vc.mapArray = array
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer)
        {
            if ((self.navigationController?.viewControllers.count)! > 1)
            {
                return true
            }
            return false
        }
        return true
    }
    
    
    
    //MARK:- AGENDA GET API
  private  func getAgenda(pageN : Int) {
    
    self.noDataLbl.isHidden = true

        var url : String = "\(Constant.APIs.baseURL)/rest_agenda?filter=uitgelicht&page=\(pageN)&uname=\(Constant.APIs.uName)&apikey=\(Constant.APIs.apiKey)"
        
        url = url.replacingOccurrences(of: " ", with: "%20")
    
        Service.sharedInstance.getRequest(Url:url,modalName:agendaModal.self,completion: { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if pageN == 1
                {
                    self.agendaDtaArr.removeAll()
                }
                if response?.Status == 200
                {
                    
                    var tempArr = [agendaDataModal]()
                    for item in (response?.Item)!
                    {
                        if item.agenda_is_uitgelitch == 1 {
                            let modal = agendaDataViewModal(agenData: item)
                            self.agendaDtaArr.append(modal)
                            tempArr.append(item)
                        }
                        
                    }

                    if self.agendaDtaArr.count == 0 {
                        AppUtils.showToast(message: "NoDataKey".localizableString(loc: Constant.langPath))
                    }
                    
                    
                    if tempArr.count < 10
                    {
                        self.moreData = false
                    }else{
                        self.moreData = true
                    }
                    
                    var toShow = false
                    for item in self.agendaDtaArr
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
                    if self.agendaDtaArr.count > 0 {
                        self.noDataLbl.isHidden = true
                    }else
                    {
                        self.noDataLbl.isHidden = false
                    }
                    
                    
                    
                    self.homeTV.reloadData()
                }else{
                    AppUtils.showToast(message: "SomeWrongKey".localizableString(loc: Constant.langPath))
                }
            }
        })
    }
    //MARK:- AGENDA FILTER GET API
    //    func getAgFilter()
    //    {
    //        Utils.startLoading(view)
    //        let url : String = "\(Constant.APIs.baseURL)/agenda_filter/"
    //        Service.sharedInstance.getRequest(Url: url, modalName: agendaFilterModal.self) { (response, error) in
    //            DispatchQueue.main.async {
    //                Utils.stopLoading()
    //                if response?.Status == 200
    //                {
    //                    for item in (response?.Item)!
    //                    {
    //                        let modal = agendaFilterViewModal(agFilNm: item)
    //                        self.agendaFilArr.append(modal)
    //                    }
    //              //      self.menuSegCon()
    //                }else{
    //                    AppUtils.showToast(message: "SomeWrongKey".localizableString(loc: Constant.langPath))
    //                }
    //            }
    //        }
    //    }
    @objc private  func map(sender : UIButton)
    {
        self.destLat = agendaDtaArr[sender.tag].agenda_lat
        self.destLong = agendaDtaArr[sender.tag].agenda_long
        
        self.showMapsAlert(lat: self.destLat, lon: self.destLong)
        
    }
}
extension HomeViewController
{
    //    func menuSegCon()
    //    {
    //        let textAttributes = [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-Light", size: 15.0), NSAttributedString.Key.foregroundColor: UIColor.white]
    //        menuSeg.setTitleTextAttributes(textAttributes as [NSAttributedString.Key : Any], for: .normal)
    //        menuSeg.segmentStyle = .textOnly
    //        for i in 0...agendaFilArr.count-1
    //        {
    //            menuSeg.insertSegment(withTitle: agendaFilArr[i].title!,at: i)
    //        }
    //        menuSeg.underlineSelected = true
    //        menuSeg.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
    //        menuSeg.selectedSegmentIndex = 0
    //        menuSeg.backgroundColor = Constant.segBgClr
    //        menuSeg.fixedSegmentWidth = true
    //    }
    //    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
    //        self.filName = agendaFilArr[sender.selectedSegmentIndex].title!
    //        self.pageNo = 1;
    //        getAgenda(filN: self.filName, pageN: self.pageNo)
    //    }
   private func xibReg()
    {
        homeTV.register(UINib(nibName: "ManyTableViewCell", bundle: nil), forCellReuseIdentifier: "ManyTableViewCell")
        homeTV.register(UINib(nibName: "BlankTableViewCell", bundle: nil), forCellReuseIdentifier: "BlankTableViewCell")
        homeTV.dataSource = self
        homeTV.delegate = self
    }
    func swipeBackGesture()
    {
        super.viewDidAppear(true);
        // print("view did appear");
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
    }
}




