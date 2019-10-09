//
//  Constant.swift
//  map-with-marker
//
//  Created by VJ's iMac on 09/10/19.
//  Copyright © 2019 William French. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


let locationManager = CLLocationManager()
var latitude : String?
var longitude : String?
var city : String?
var state : String?
var country : String?
var zipCode:String?

func getLatLong()  {
    
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startMonitoringSignificantLocationChanges()
    
    locationManager.requestWhenInUseAuthorization()
    
    
    if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
        guard let currentLocation = locationManager.location else {
            return
        }
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)

    }
}
    


func getLatLongWithCity() {
    locationManager.requestAlwaysAuthorization()
    if locationManager.location?.coordinate != nil {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            placemarks?.forEach { (placemark) in
                if let cityl = placemark.subAdministrativeArea {
                    print("Location : \(cityl)")
                    country = cityl
                    if let areas = placemark.administrativeArea {
                        print("Location : \(areas)")
                        state = areas
                        if let country = placemark.subLocality {
                            city = country
                        }

                        if let zip_Code = placemark.postalCode
                        {
                            zipCode = zip_Code
                           
                        }
                    }
                }
            }
        })
        
    } else {
        print("Location coordiante not found")
    }
}
