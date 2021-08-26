//
//  MenuViewController.swift
//  SPP
//
//  Created by sanganan on 1/10/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
import SideMenu
import SDWebImage
import SafariServices
class MenuViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
 // private  let id = AppUtils.getStringForKey(key: Constant.id)
    
    enum MenuType : Int {
        case uitagenda = 0
        case home
        case ontdek
        case tips
        case business
        case alerts
        case gifts
        case quiz
        case logout
    }
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonNavigationBar(title: "", controller: Constant.Controllers.menu)
//        if id != nil
//        {
//            self.nameLbl.text = "Welkom " + (AppUtils.getStringForKey(key: Constant.name) ?? "")
//            if let image = AppUtils.getStringForKey(key: Constant.userImage)
//            {
//              //  self.profilePic.sd_setImage(with: URL(string: image))
//                self.profilePic.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "male_avtar"), options: .continueInBackground) { (image, error, cache, url) in
//                    
//                }
//            }
            
//        }else{
////            self.profilePic.image = UIImage(named: "male_avtar")
//            self.nameLbl.text = ""
//
//        }
        // self.tapGesture(forVc: self, forView: menuView)
       // self.menuView.backgroundColor = Constant.orangeColor
        menuTableView.backgroundColor = .white
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClassConst.menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.badgeLbl.isHidden = true
//        if id != nil
//        {
            cell.menuLbl.text = ClassConst.menuArrO[indexPath.row]
            cell.menuImg.image = UIImage(named: ClassConst.menuImgO[indexPath.row])
            
//        }else{
//            cell.menuLbl.text = ClassConst.menuArr[indexPath.row]
//            cell.menuImg.image = UIImage(named: ClassConst.menuImg[indexPath.row])
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuTap = MenuType(rawValue: indexPath.row)
        switch (menuTap)
        {
        case .home:
            let vc = Constant.Controllers.home.get() as! HomeViewController
                       self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case .gifts:
            DispatchQueue.main.async {

            let safari = SFSafariViewController(url: URL(string: "https://www.papendrechtverrast.nl/papendrecht-app/gifts/")!)
                safari.preferredControlTintColor = .white
                safari.preferredBarTintColor = Constant.purpleColor
            self.present(safari, animated: true, completion: nil)
                
            }
            
            break;
        case .uitagenda:
            DispatchQueue.main.async {
                           self.dismiss(animated: true, completion: nil)
                       }
            
           
            break
            
        
        case .ontdek:
            let vc = Constant.Controllers.ontDekCategory.get() as! OntDekCategoryController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case .tips:
            let vc = Constant.Controllers.tips.get() as! TipsViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case .business:
            let vc = Constant.Controllers.business.get() as! BusinessViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case .alerts:
//            let vc = Constant.Controllers.alerts.get() as! AlertsViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            let vc = Constant.Controllers.alertsAb.get() as! AlertsAboutViewController
                self.navigationController?.pushViewController(vc, animated: true)
            break
            case .quiz:
                 let vc = Constant.Controllers.quiz.get() as! QuizViewController
                 self.navigationController?.pushViewController(vc, animated: true)
                 break
            
        case .logout:
            DispatchQueue.main.async {
                
//                if self.id != nil
//                {
//                    self.alertDialog()
//                }else{
//                    let vc = Constant.Controllers.login.get() as! LoginViewController
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
            }
            break
        case .none:
            break
        }
        
        
    }
}

