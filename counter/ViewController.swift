//
//  ViewController.swift
//  counter
//
//  Created by Suleman Imdad on 8/19/16.
//  Copyright © 2016 Suleman Imdad. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var counterLabelView: CounterLabelView!
    
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startLocationManager()
        
        
    }
    
    func startLocationManager(){
        
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startMonitoringSignificantLocationChanges()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
           
            //
            
              print("location authorization changed \(status)")

          
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("location changed \(locations.last!)")
        
        WeatherManager.sharedInstance.location = locations.last!
        
    }
    
    
}

