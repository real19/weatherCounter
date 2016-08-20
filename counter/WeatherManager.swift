//
//  WeatherManager.swift
//  counter
//
//  Created by Suleman Imdad on 8/19/16.
//  Copyright © 2016 Suleman Imdad. All rights reserved.
//

import Foundation
import CoreLocation



class WeatherManager {
    
   static let API_KEY = "94119cdb330469c2ca464f632adb0f4a"
    
    var latitude:Float = 0
    
    var longitude:Float = 0
    
    var location:CLLocation? {
       
        didSet{
            
            latitude = Float((location?.coordinate.latitude)!)
            longitude = Float((location?.coordinate.longitude)!)
        }
    }
    
    var baseURL = "http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=94119cdb330469c2ca464f632adb0f4a"
    
    static let sharedInstance = WeatherManager()
    
    
    static func getWeatherInfo(lat:Int, lon:Int){
        
        
    
    }
    
}
    

