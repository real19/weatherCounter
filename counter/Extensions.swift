//
//  Extensions.swift
//  counter
//
//  Created by Suleman Imdad on 8/20/16.
//  Copyright © 2016 Suleman Imdad. All rights reserved.
//

import Foundation
import CoreLocation


public extension CLLocation {
    
    
    func getLocationName(completion:((locationName:String)-> Void)){
        
        CLGeocoder().reverseGeocodeLocation(self) {(placemarks, error) -> Void in
            
            if let thePlacemarks = placemarks as [CLPlacemark]?{
                
                let placemark: CLPlacemark  =  thePlacemarks[0]
                
                completion(locationName: placemark.getLocationNameString() as String)
                
            }
            
        }
        
        
    }
    
}

public extension CLPlacemark{
    
    
    func getLocationNameString()->NSString {
        
        
        let locality = (self.locality != nil) ? "\(self.locality!), " : ""
        
        // let postalCode = (self.postalCode != nil) ? "\(self.postalCode!) ," : ""
        
        let administrativeArea = (self.administrativeArea != nil) ? "\(self.administrativeArea!), " : ""
        
        let country = (self.country != nil) ? "\(self.country!)" : ""
        
        let  locationString = locality  + administrativeArea + country
        
        
        return locationString
    }
}
