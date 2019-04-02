//
//  ArticleFeedLocation.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-30.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import Foundation
import CoreLocation

extension ArticleFeedViewController:CLLocationManagerDelegate {
    
    //Retrieve location data
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0  {
            locationManager.stopUpdatingLocation()
            geocoder.reverseGeocodeLocation(location) { (resultArray, error) in
                guard let array = resultArray, let country = array[0].country else {
                    print(error)
                    self.currentCountry = "Canada"
                    AlertUtil.showAlert(in: self, msg: ERROR.NO_LOCATION, title: ALERT.NO_LOCATION_TITLE)
                    return
                }
                
                self.currentCountry = country
                self.fetchArticlesWith(country: country)
         
            }
        }
    }
    
    //Failed location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        AlertUtil.showAlert(in: self, msg: ERROR.NO_LOCATION, title: ALERT.NO_LOCATION_TITLE)
        currentCountry = DEFAULTS.COUNTRY
    }
}
