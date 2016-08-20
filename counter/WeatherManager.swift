//
//  WeatherManager.swift
//  counter
//
//  Created by Suleman Imdad on 8/19/16.
//  Copyright © 2016 Suleman Imdad. All rights reserved.
//

import Foundation
import CoreLocation



protocol WeatherManagerDelegate {
    func temperatureChanged(temperature:Double)
}


class WeatherManager {
    
    let API_KEY = "94119cdb330469c2ca464f632adb0f4a"
    
    var counterUnit: CounterUnit?
    
    var latitude:Float = 0
    
    var longitude:Float = 0
    
    var location:CLLocation? {
       
        didSet{
            
            latitude = Float((location?.coordinate.latitude)!)
            longitude = Float((location?.coordinate.longitude)!)
            
            getWeatherInfo(latitude, lon: longitude)
        }
    }
    
    var currentTemperature:Double? {
        didSet{
           
            if currentTemperature != nil && oldValue != currentTemperature{
                
                 delegate?.temperatureChanged(currentTemperature!)
            }
        }
    }
    
    
    var delegate:WeatherManagerDelegate?
    
    
    
    static let sharedInstance = WeatherManager()
    
    
     func getWeatherInfo(lat:Float, lon:Float){
        
        let baseURLString = "http://api.openweathermap.org/data/2.5/weather"
        
        let urlString = "\(baseURLString)?lat=\(lat)&lon=\(lon)&appid=\(API_KEY)"
        
        request(.GET, urlString).responseJSON {[weak self] response in
            
            switch response.result {
           
            case .Success:
               
               
                
                guard let dataFromNetworking = response.data else {
                    
                     print("data could not be returned")
                   
                    return
                }
                
                let json = JSON(data: dataFromNetworking)
                
                guard let temperature = json["main"]["temp"].double else {
                  
                    print("error occured while fetching Temperature json[\"main\"][\"temp\"]")
                    
                    return
                }
                
             
                self?.delegate?.temperatureChanged(temperature)
               
                
            case .Failure(let error):
                print("Response was NOT Successful \(error)")
            }
            
            
            
        }
        
        
    
    }
    
}
    

