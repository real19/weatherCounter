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
    
    var timer = NSTimer()
    
    var location:CLLocation? {
       
        didSet{
            
            latitude = Float((location?.coordinate.latitude)!)
            
            longitude = Float((location?.coordinate.longitude)!)
            
            startPullingWeather()
            
           
        }
    }
    
    var currentTemperature:Double? {
        didSet{
           
            if currentTemperature != nil && oldValue != currentTemperature{
                
                 print("temprature changed \(currentTemperature!)")
                
                 delegate?.temperatureChanged(currentTemperature!)
            }
        }
    }
    
    
    var delegate:WeatherManagerDelegate?
    
    let baseURLString = "http://api.openweathermap.org/data/2.5/weather"
    
    static let sharedInstance = WeatherManager()
    
    
    
    func startPullingWeather(){
        
        timer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: #selector(pullWeatherEveryMinute), userInfo: nil, repeats: true)
        
        timer.fire()
    }
    
    
    @objc func pullWeatherEveryMinute(){
        
        getWeatherInfo(latitude, lon: longitude)
    }
    
    
    
     func getWeatherInfo(lat:Float, lon:Float){
        
        
        
        let urlString = "\(baseURLString)?lat=\(lat)&lon=\(lon)&appid=\(API_KEY)"
        
        request(.GET, urlString).responseJSON {[weak self] response in
            
            switch response.result {
           
            case .Success:
               
               guard let dataFromNetworking = response.data else {
                    
                     print("data could not be found")
                   
                    return
                }
                
                let json = JSON(data: dataFromNetworking)
                
                guard let temperature = json["main"]["temp"].double else {
                  
                    print("error occured while fetching Temperature")
                    
                    return
                }
               
               
             
                self?.currentTemperature = temperature
                
            case .Failure(let error):
               
                print("Response was NOT Successful \(error)")
            }
 
        }
    
    }
    
    
    
    
    
    
}
    

