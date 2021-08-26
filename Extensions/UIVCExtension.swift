//
//  UIVCExtension.swift
//  SPP
//
//  Created by sanganan on 1/9/20.
//  Copyright © 2020 Sanganan. All rights reserved.
import UIKit
import SideMenu
import EventKit
import GoogleSignIn
import FacebookLogin
import FBSDKCoreKit

extension UIViewController {
    func commonNavigationBar(title:String , controller:Constant.Controllers)
    {
        self.title = title
        navigationController?.navigationBar.barTintColor = Constant.purpleColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        switch (controller){
        case .uitagenda:
            //            let button = UIButton(type: .custom)
            //            button.setImage(UIImage (named: "seacrh"), for: .normal)
            //            button.addTarget(self, action: #selector(search), for: .touchUpInside)
            //            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            //            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            //            let barButtonItem = UIBarButtonItem(customView: button)
            
            let button3 = UIButton(type: .custom)
            button3.setImage(UIImage(named: "menu"), for: .normal)
            button3.addTarget(self, action: #selector(menu), for: .touchUpInside)
            button3.heightAnchor.constraint(equalToConstant: 23).isActive = true
            button3.widthAnchor.constraint(equalToConstant: 27).isActive = true
            let barButtonItem3 = UIBarButtonItem(customView: button3)
            self.navigationItem.leftBarButtonItem  = barButtonItem3
            break
        case .alarm,.alertA,.login,.signup,.agRelDetails,.sideMenu, .Splash:
            break
            
        case .menu:
            self.navigationController?.isNavigationBarHidden = true
            
        case .map:
            //            let button = UIButton(type: .custom)
            //            button.setImage(UIImage (named: "seacrh"), for: .normal)
            //            button.addTarget(self, action: #selector(search), for: .touchUpInside)
            //            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            //            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            //            let barButtonItem = UIBarButtonItem(customView: button)
            //
            let button2 = UIButton(type: .custom)
            button2.setImage(UIImage(named: "fun"), for: .normal)
            button2.addTarget(self, action: #selector(fun), for: .touchUpInside)
            button2.heightAnchor.constraint(equalToConstant: 23).isActive = true
            button2.widthAnchor.constraint(equalToConstant: 27).isActive = true
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            self.navigationItem.rightBarButtonItems  = [barButtonItem2]
            let button3 = UIButton(type: .custom)
            button3.setImage(UIImage(named: "back"), for: .normal)
            button3.addTarget(self, action: #selector(backButton), for: .touchUpInside)
            button3.heightAnchor.constraint(equalToConstant: 23).isActive = true
            button3.widthAnchor.constraint(equalToConstant: 27).isActive = true
            let barButtonItem3 = UIBarButtonItem(customView: button3)
            self.navigationItem.leftBarButtonItem  = barButtonItem3
            break
            
        case .profile,.alerts,.alertsAb,.tipsdetail,.tips,.bDetails,.ontdek ,.categoryList,.ontdetail:
            let button = UIButton(type: .custom)
            button.setImage(UIImage (named: "back"), for: .normal)
            button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 23).isActive = true
            button.widthAnchor.constraint(equalToConstant: 27).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            self.navigationItem.leftBarButtonItem = barButtonItem
            self.navigationItem.leftBarButtonItem?.tintColor = .white
            break
            
        case .home, .business, .quiz, .ontDekCategory:
            let button3 = UIButton(type: .custom)
            button3.setImage(UIImage(named: "back"), for: .normal)
            button3.addTarget(self, action: #selector(backButton), for: .touchUpInside)
            button3.heightAnchor.constraint(equalToConstant: 23).isActive = true
            button3.widthAnchor.constraint(equalToConstant: 27).isActive = true
            let barButtonItem3 = UIBarButtonItem(customView: button3)
            self.navigationItem.leftBarButtonItem  = barButtonItem3
            break
  
            
        case .detail:
            //            let button = UIButton(type: .custom)
            //            button.setImage(UIImage (named: "seacrh"), for: .normal)
            //            button.addTarget(self, action: #selector(search), for: .touchUpInside)
            //            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            //            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            //            let barButtonItem = UIBarButtonItem(customView: button)
            let button2 = UIButton(type: .custom)
            button2.setImage(UIImage(named: "map"), for: .normal)
            button2.addTarget(self, action: #selector(map), for: .touchUpInside)
            button2.heightAnchor.constraint(equalToConstant: 23).isActive = true
            button2.widthAnchor.constraint(equalToConstant: 27).isActive = true
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            self.navigationItem.rightBarButtonItems  = [barButtonItem2]
            let button3 = UIButton(type: .custom)
            button3.setImage(UIImage(named: "back"), for: .normal)
            button3.addTarget(self, action: #selector(backButton), for: .touchUpInside)
            button3.heightAnchor.constraint(equalToConstant: 23).isActive = true
            button3.widthAnchor.constraint(equalToConstant: 27).isActive = true
            let barButtonItem3 = UIBarButtonItem(customView: button3)
            self.navigationItem.leftBarButtonItem  = barButtonItem3
            break
        }
    }
    
    @objc   func map()
    {
        let vc = Constant.Controllers.map.get() as! MapViewController
        // vc.destLat = Double(agendaDtaArr[sender.tag].agenda_lat) as! Double
        // vc.destLong = Double(agendaDtaArr[sender.tag].agenda_long) as! Double
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func fun()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func backButton()
    {
        if ((self as? detailTableViewController) != nil)
        {
            self.navigationController?.popToViewController((self as? detailTableViewController)!.fromClass!, animated: true)
            //            self.navigationController?.popToRootViewController(animated: true)
        }else if ((self as? tipsDetailTableViewController) != nil)
        {
            for item in self.navigationController!.viewControllers
            {
                if item is TipsViewController
                {
                    self.navigationController?.popToViewController(item, animated: true)
                    break
                }
            }
            
            
        }else if ((self as? BusinessDetailsViewController) != nil)
        {
            for item in self.navigationController!.viewControllers
            {
                if item is BusinessViewController
                {
                    self.navigationController?.popToViewController(item, animated: true)
                    break
                }
            }
            
            
        }
            
        else{
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    //    @objc  func search()
    //    {
    //
    //    }
    //    @objc func Omenu()
    //    {
    //
    //    }
    @objc func menu()
    {
        let menu = Constant.Controllers.sideMenu.get() as! SideMenuNavigationController
        menu.presentationStyle = .menuSlideIn
        menu.enableTapToDismissGesture = true
        menu.enableSwipeToDismissGesture = true
        menu.menuWidth = 0.7*UIScreen.main.bounds.size.width
        self.present(menu, animated: true, completion: nil)
    }
    
    @objc func alarm(sender : UIButton)
    {
//        let id = AppUtils.getStringForKey(key: Constant.id)
//        if id != nil
//        {
            
            let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
            
            switch (status) {
            case EKAuthorizationStatus.notDetermined:
                // This happens on first-run
                createAlarm(identity : sender.accessibilityHint!,eventName : sender.accessibilityLabel!,date: sender.accessibilityValue!)
                
            case EKAuthorizationStatus.authorized:
                // Things are in line with being able to show the calendars in the table view
                createAlarm(identity : sender.accessibilityHint!,eventName : sender.accessibilityLabel!,date: sender.accessibilityValue!)
                //  print("Access granted")
                
            case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
                // We need to help them give us permission
                print("Access to store not granted")
            @unknown default:
                print("unknown case")
            }
            
            
            if Constant.appDel.eventStore == nil {
                AppUtils.setRemainder()
            }else{
                
            }
//        }
//        else{
//            reminderAlert()
//        }
    }
    func createAlarm(identity : String,eventName : String,date : String)
    {
        let vc = Constant.Controllers.alarm.get() as! AlarmViewController
        vc.identifier = identity
        vc.eventName = eventName
        vc.maxDate = date
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(vc, animated: true)
    }
    func reminderAlert()
    {
        let alertController = UIAlertController(title: "SignInKey".localizableString(loc: Constant.langPath), message: "signInAlertKey".localizableString(loc: Constant.langPath), preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OKKey".localizableString(loc: Constant.langPath), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.signIn()
        }
        let cancelAction = UIAlertAction(title: "CancelKey".localizableString(loc: Constant.langPath), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancelled")
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func signIn()
    {
        let vc = Constant.Controllers.login.get() as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func alertDialog()
    {
        let alertController = UIAlertController(title: "SignOutKey".localizableString(loc: Constant.langPath), message: "signOutConfirmKey".localizableString(loc: Constant.langPath), preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OKKey".localizableString(loc: Constant.langPath), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.logOutA()
        }
        
        let cancelAction = UIAlertAction(title: "CancelKey".localizableString(loc: Constant.langPath), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancelled")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func logOutA()
    {
        DispatchQueue.main.async{
            self.dismiss(animated: true, completion: nil)

            AppUtils.AppDelegate().userId = ""
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            GIDSignIn.sharedInstance().signOut()
            let loginManager = LoginManager()
            loginManager.logOut()
            self.removeReminder()
           // self.home()
            AppUtils.showToast(message: "SignedOutSucKey".localizableString(loc: Constant.langPath))
        }
    }
    
    func removeReminder()
    {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        Constant.appDel.eventStore = EKEventStore()
        let calen = EKCalendar(for: .reminder, eventStore: Constant.appDel.eventStore)
        
        let predicate = Constant.appDel.eventStore.predicateForReminders(in: [calen])
        Constant.appDel.eventStore.fetchReminders(matching: predicate) { (reminderArray) in
            
            
            if let remind = reminderArray
            {
                for item in remind
                {
                    if item.title == "Papendrecht App"  {
                        
                        do
                        {
                            try? Constant.appDel.eventStore.remove(item, commit: false)
                        }catch let err as NSError
                        {
                            print("error",err.description)
                        }
                    }
                }
                
            }
        }
    }
    
    func loginManagerDidComplete(_ result: LoginResult) {
        let alertController: UIAlertController
        switch result {
        case .cancelled:
            alertController = UIAlertController(
                title: "Login Cancelled",
                message: "User cancelled login.",
                preferredStyle: .alert
            )
            
        case .failed(let error):
            alertController = UIAlertController(
                title: "Login Fail",
                message: "Login failed with error \(error)",
                preferredStyle: .alert
            )
            
        case .success(let grantedPermissions, _, _):
            alertController = UIAlertController(
                title: "Login Success",
                message: "Login succeeded with granted permissions: \(grantedPermissions)",
                preferredStyle: .alert
            )
            self.fbUserDate()
           // self.home()
            self.navigationController?.popViewController(animated: true)
            AppUtils.showToast(message: "SignedInSucKey".localizableString(loc: Constant.langPath))
        }
        //  self.present(alertController, animated: true, completion: nil)
    }
    
    func loginWithReadPermissions() {
        let loginManager = LoginManager()
        loginManager.logIn(
            permissions: [ .email],
            viewController: self
        ) { result in
            self.loginManagerDidComplete(result)
        }
    }
    
    func fbUserDate()
    {
        let r = GraphRequest(graphPath: "me", parameters: ["fields": "id,name,email,picture.type(large)"])
        r.start(completionHandler: { (test, result, error) in
            if(error == nil)
            {
                guard let data = result as? [String:Any] else { return }
                
                let userId = data["id"]
                AppUtils.setStringForKey(key: Constant.id, val: userId! as! String )
                let  name = data["name"]
                AppUtils.setStringForKey(key: Constant.name, val: name! as! String)
                let email = data["email"]
                AppUtils.setStringForKey(key: Constant.email, val: email! as! String)
                let image = data["picture"] as? [String : Any]
                let data1 = image?["data"] as? [String : Any]
                let url : String? = data1?["url"] as? String
                AppUtils.setStringForKey(key: Constant.userImage, val: String(describing: url!))
            }
        })
    }
    
    func home()
    {
        let vc =  Constant.Controllers.home.get() as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func showMapsAlert(lat : String, lon : String)
    {
        let alertController = UIAlertController(title: "", message: "optionKey".localizableString(loc: Constant.langPath), preferredStyle: .alert)
        
        // Create the actions
        let googleMap = UIAlertAction(title: "googleMapKey".localizableString(loc: Constant.langPath), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openGoogleMap(lat: lat, lon: lon)

        }
        
        
        let appleMap = UIAlertAction(title: "appleMapKey".localizableString(loc: Constant.langPath), style: UIAlertAction.Style.default) {
                   UIAlertAction in
            self.openAppleMap(lat: lat, lon: lon)

               }
        
        
        let cancelAction = UIAlertAction(title: "CancelKey".localizableString(loc: Constant.langPath), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancelled")
        }
        
        alertController.addAction(googleMap)
        alertController.addAction(appleMap)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openGoogleMap(lat : String, lon : String)
    {
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                   UIApplication.shared.openURL(NSURL(string:
                       "comgooglemaps://?saddr=&daddr=\(String(describing: lat)),\(String(describing: lon))")! as URL)
                   
               } else {
                   UIApplication.shared.openURL(NSURL(string:
                       "https://www.google.co.in/maps/dir/?saddr=&daddr=\(String(describing: lat)),\(String(describing: lon))")! as URL)
               }
    }
    
    func openAppleMap(lat : String, lon : String)
    {
        
        UIApplication.shared.openURL(NSURL(string:
        "http://maps.apple.com/?daddr=\(String(describing: lat)),\(String(describing: lon))")! as URL)
    }
}
