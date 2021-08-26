//
//  Service.swift
//  SPP
//
//  Created by sanganan on 2/13/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class Service: NSObject {
    static let sharedInstance = Service()
    
    //MARK:- Get API
    func getRequest<T:Decodable>(Url:String, modalName:T.Type,completion:@escaping ((T?,Error?) -> Void))
    {
        if AppUtils.AppDelegate().isNetworkAvailable == false
        {
            Utils.stopLoading()
            AppUtils.showToast(message: Constant.offlineMsg)
            return
        }
        print("get request",Url)
        
        let Url = Url.replacingOccurrences(of: " ", with: "%20")

        guard let url = URL(string: (Url)) else {return}
        
        URLSession.shared.dataTask(with: url){(data,response,error) in
            if let err = error{
                //completion(errorModal.self,err )
                print("error-:\(err.localizedDescription)")
            }
            guard let data = data else{return}
            
            //   print(data)
            do{
                print(try JSONSerialization.jsonObject(with: data, options: .mutableContainers))
                let json = try JSONDecoder().decode(modalName.self, from: data)
                print(json)
                completion(json,nil)
            }catch let jsonerr{
                print("error-:\(jsonerr.localizedDescription)")
                completion(nil,jsonerr)
            }
        }.resume()
    }
    
    //MARK:- POST API
    
    func postRequest<T:Decodable>(Url:String,modalName:T.Type,parameter:[String:Any],completion:@escaping ((T?,Error?) -> Void))
    {
        
        if AppUtils.AppDelegate().isNetworkAvailable == false
        {
            Utils.stopLoading()
            AppUtils.showToast(message: Constant.offlineMsg)
            return
        }
           let Url = Url.replacingOccurrences(of: " ", with: "%20")


        guard let url = URL(string: (Url)) else {return}
        //   print(Url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else{return}
        print(try? JSONSerialization.data(withJSONObject: parameter, options: []))
        
        request.httpBody = httpBody
        print(parameter)
        let _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else{return}
            do{
                // actual data
                print(try JSONSerialization.jsonObject(with: data, options: .mutableContainers),"data")
                
                let json = try JSONDecoder().decode(modalName.self, from: data)
                //print decode data
                completion(json,nil)
            }catch let jsonerr{
                print("error-:\(jsonerr.localizedDescription)")
                completion(nil,jsonerr)
            }
        }.resume()
    }
}




