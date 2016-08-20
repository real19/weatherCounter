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

    @IBOutlet weak var counter: UILabel!
    
    var startValue = 0
    
    let endValue = 9
    
    var  animationSubtype = kCATransitionFromTop
    
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        startLocationManager()
        
        counter.text = "\(startValue)";
        
        animate(startValue, value: endValue)
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


    
    func animate(newValue:Int, value:Int ){
        
      counter.layer.removeAllAnimations()
        
        let animation = CATransition()
        
        animation.delegate = self
        
        animation.removedOnCompletion = false
        
        animation.duration = 1
        
        animation.type = kCATransitionPush
        
        if (endValue > startValue){
            
            animationSubtype = kCATransitionFromTop

        } else if (endValue < startValue){
            
            animationSubtype = kCATransitionFromBottom

        }
     
        animation.subtype = animationSubtype
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        counter.layer.addAnimation(animation, forKey:"changeTextTransition")
        
        counter.layer
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if (endValue > startValue){
            
            startValue += 1
        } else if (endValue < startValue){
            
            startValue -= 1
        }
        else {
            return
        }
        
        counter.text = "\(startValue)";
        animate(startValue, value: endValue)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
           
            //
            
            print("location authorization changed \(status)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("location changed \(locations.last!)")
    }
}

