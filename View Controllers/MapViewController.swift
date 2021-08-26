//
//  MapViewController.swift
//  SPP
//
//  Created by sanganan on 1/29/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
   private var mapView = GMSMapView()
    //   var currentLat : Double = Double(AppUtils.getStringForKey(key: Constant.latitude)!)!
    //   var currentLong : Double = Double(AppUtils.getStringForKey(key: Constant.longitude)!)!
//    var destLat : Double = Double()
//    var destLong : Double = Double()
    var mapArray = [MapDataModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = "MapKey".localizableString(loc: Constant.langPath)
        self.commonNavigationBar(title: title, controller: Constant.Controllers.map)
        self.setPinsOnMap()
        // Creates a marker in the center of the map.
        //  fetchRoute()
    }
   private func setPinsOnMap()
    {
        let camera = GMSCameraPosition.camera(withLatitude: 11.12, longitude: 11.21, zoom: 3.0)
        mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        //        view = mapView
        self.view.addSubview(mapView)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        var bounds = GMSCoordinateBounds()
        for item in self.mapArray
        {
            if item.lat.count > 0 && item.lon.count > 0{
                let marker = GMSMarker()
                let lat  = Double(item.lat)
                let lon = Double(item.lon)
                let position = checkIfMutlipleCoordinates(latitude: Float(lat!), longitude: Float(lon!))

                marker.position = position

//                marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
                marker.title = item.title.removeHTMLChar()
                marker.snippet = item.desc.removeHTMLChar()
                let imgView = UIImageView(image: UIImage(named: "location"))
                imgView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
                
                if item.category == ""
                {
                    imgView.image = UIImage(named:  "event_map")
                    
                }else{
                    
                    imgView.image = UIImage(named: self.setImage(url: item.category))
                }
                marker.iconView = imgView
                marker.map = mapView
                bounds = bounds.includingCoordinate(marker.position)
            }
        }
//        mapView.setMinZoom(1, maxZoom: 15)//prevent to over zoom on fit and animate if bounds be too small
//
//        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
//        mapView.animate(with: update)
//
//        mapView.setMinZoom(1, maxZoom: 20)
        
        mapView.animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 50.0 , left: 50.0 ,bottom: 50.0 ,right: 50.0)))

        
    }

    
    
    func checkIfMutlipleCoordinates(latitude : Float , longitude : Float) -> CLLocationCoordinate2D{

           var lat = latitude
           var lng = longitude

           // arrFilterData is array of model which is giving lat long

           let arrTemp = self.mapArray.filter {

               return (((latitude == Float($0.lat)) && (longitude == Float($0.lon))))
           }

           // arrTemp giving array of objects with similar lat long

           if arrTemp.count > 1{
               // Core Logic giving minor variation to similar lat long

               let variation = (randomFloat(min: 0.0, max: 2.0) - 0.5) / 1500
               lat = lat + variation
               lng = lng + variation
           }
           let finalPos = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
           return  finalPos
       }

    func randomFloat(min: Float, max:Float) -> Float {
           return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
       }
    
}
