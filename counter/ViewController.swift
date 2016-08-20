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
        
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
           
            //
            
            guard let counterLabelView = counterLabelView else {
                return
            }
            
            counterLabelView.startValue = 0
            
            counterLabelView.endValue = 9
            
            counterLabelView.animate( counterLabelView.startValue, value: counterLabelView.endValue)
            
            print("location authorization changed \(status)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        print("location changed \(locations.last!)")
    }
}

