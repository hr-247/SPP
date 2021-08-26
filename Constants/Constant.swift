//
//  Constant.swift
//  HowrahBridge
//
//  Created by Ankit  Jain on 19/12/19.
//  Copyright © 2019 Sanganan. All rights reserved.
//

import UIKit

class Constant: NSObject {
    
    static let appDel = UIApplication.shared.delegate as! AppDelegate
    
    //MARK:UserDefault data
    static let name:String                 = "name"
    static let email:String                = "email"
    static let id:String                   = "id"
    static let userImage : String          = "userImage"
    
    //color used in the App
    static let purpleColor = UIColor(red: 79/255, green: 53/255, blue: 108/255, alpha: 1.0)
    static let orangeColor = UIColor(red: 229/255, green: 87/255, blue: 37/255, alpha: 1.0)
    static let menuBdgClr = UIColor(red: 58/255, green: 48/255, blue: 69/255, alpha: 1.0)
    static let segBgClr = UIColor(red: 64/255, green: 40/255, blue: 90/255, alpha: 1.0)
    
    
    //Language Name Path
    static let langPath = Constant.appDel.selectedLanguage
    
    //Location
    static let latitude: String = "latitude"
    static let longitude: String = "longitude"
    
    //MARK: ServicesConstant
    static let offlineMsg : String  = "NoInternetKey".localizableString(loc: Constant.langPath)
    
    struct APIs {
        
        //Vikas Chaudhary (vikas.chaudhary@sanganan.in)
        //http://3.134.245.103/papendrechtverrast.dev/api/rest_tips?&page=1&uname=pranav&apikey=pranav2020
        
        //https://www.papendrechtverrast.nl/api/rest_agenda?filter=uitgelicht&page=1&uname=pranav&apikey=pranav2020
        //static let baseURL = "https://www.papendrechtverrast.nl/api"
        //        static let baseURL = "http://192.168.0.52/papendrechtverrast.dev/api"
        
        // http://13.233.252.96/papendrechtverrast.dev/api/
        static let baseURL = "https://www.papendrechtverrast.nl/api"
        
   //     static let baseURL = "http://13.233.252.96/papendrechtverrast.dev/api"
        
        static let uName = "pranav"
        //        static let apiKey = "4kEm!6"
        static let apiKey = "pranav2020"
        
    }
    //MARK:- STORYBOARDS
    public struct Storyboards
    {
        static let home = UIStoryboard(name: "Home", bundle: nil)
    }
    public enum Controllers {
        case home
        case menu
        case detail
        case ontdek
        case ontdetail
        case tipsdetail
        case map
        case sideMenu
        case profile
        case alerts
        case uitagenda
        case tips
        case business
        case alertsAb
        case alarm
        case alertA
        case login
        case signup
        case bDetails
        case agRelDetails
        case categoryList
        case quiz
        case ontDekCategory
        case Splash
        
        func get()->UIViewController{
            switch self {
                
            case .home:
                return Storyboards.home.instantiateViewController(withIdentifier: "HomeViewController")
                
            case .menu:
                return Storyboards.home.instantiateViewController(withIdentifier: "MenuViewController")
                
            case .detail:
                return Storyboards.home.instantiateViewController(withIdentifier: "detailTableViewController")
                
            case .ontdek:
                return Storyboards.home.instantiateViewController(withIdentifier: "ontdekTableViewController")
                
            case .ontdetail:
                return Storyboards.home.instantiateViewController(withIdentifier: "ontDetailTableViewController")
            case .tipsdetail:
                return Storyboards.home.instantiateViewController(withIdentifier: "tipsDetailTableViewController")
            //RightMenu
            case .sideMenu :
                return Storyboards.home.instantiateViewController(withIdentifier: "RightMenu")
                
            case .map :
                return Storyboards.home.instantiateViewController(withIdentifier: "MapViewController")
                
            case .profile:
                return Storyboards.home.instantiateViewController(withIdentifier: "ProfileViewController")
                
            case .alerts:
                return Storyboards.home.instantiateViewController(withIdentifier: "AlertsViewController")
                
            case .uitagenda:
                return Storyboards.home.instantiateViewController(withIdentifier: "UitagendaViewController")
            case .tips:
                return Storyboards.home.instantiateViewController(withIdentifier: "TipsViewController")
                
            case .business:
                return Storyboards.home.instantiateViewController(withIdentifier: "BusinessViewController")
                
            case .alertsAb:
                return Storyboards.home.instantiateViewController(withIdentifier: "AlertsAboutViewController")
                
            case .alarm:
                return Storyboards.home.instantiateViewController(withIdentifier: "AlarmViewController")
                
            case .alertA:
                return             Storyboards.home.instantiateViewController(withIdentifier: "AlertActionViewController")
            case .login:
                return Storyboards.home.instantiateViewController(withIdentifier: "LoginViewController")
                
            case .signup:
                return Storyboards.home.instantiateViewController(withIdentifier: "SignUpViewController")
                
            case .bDetails:
                return                Storyboards.home.instantiateViewController(withIdentifier: "BusinessDetailsViewController")
                
            case .agRelDetails:
                return                Storyboards.home.instantiateViewController(withIdentifier: "AgendaRelatedDetailViewController")
                
            case .categoryList:
                return Storyboards.home.instantiateViewController(withIdentifier: "CategoryListViewController")
                
            case .quiz:
                return Storyboards.home.instantiateViewController(withIdentifier: "QuizViewController")
                
            case .ontDekCategory:
                return Storyboards.home.instantiateViewController(withIdentifier: "OntDekCategoryController")
                
            case .Splash:
                return Storyboards.home.instantiateViewController(withIdentifier: "SplashVC")
            }
        }
    }
}


