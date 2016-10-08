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

    
    var timer = Timer()
    

    let notificationCenter = NotificationCenter.default
    
    var currentTemperature:Double? {
        didSet{
           
            if currentTemperature != nil && oldValue != currentTemperature{
                
                 print("temprature changed  to \(currentTemperature!)")
                
         notificationCenter.post(name: Notification.Name(rawValue: "temperatureChanged"),
                                        object: nil,
                                        userInfo: ["temperature":currentTemperature!])
            }
        }
    }
    
 
    let baseURLString = "http://api.openweathermap.org/data/2.5/weather"
    
    static let sharedInstance = WeatherManager()
    
    
    

    @objc func pullWeatherEveryMinuteTest(){
        
       
        currentTemperature = Double(arc4random_uniform(1000))
    }
    
    
    
    func startPullingWeatherTest(){

        timer.invalidate() // just in case this button is tapped multiple times

        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(pullWeatherEveryMinuteTest), userInfo: nil, repeats: true)

        timer.fire()
        
    }

    
    
    
    
    
}
    

