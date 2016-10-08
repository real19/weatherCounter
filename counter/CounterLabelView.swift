//
//  CounterLabel.swift
//  counter
//
//  Created by Suleman Imdad on 8/19/16.
//  Copyright © 2016 Suleman Imdad. All rights reserved.
//

import UIKit



class CounterLabelView: UIView, CAAnimationDelegate {
    
    @IBOutlet weak var counterLabel: UILabel!
    
    var index:Int = 0
    
    var startValue = 0
    
    var endValue = 0
    
    var  animationSubtype = kCATransitionFromTop
    
    var counterUnit: Int = 2
    
    let nc = NotificationCenter.default
    
    override func layoutSubviews() {
        
        counterLabel.text = "0";
    
      
        nc.addObserver(self,
                       selector: #selector(CounterLabelView.catchNotification),
                       name: NSNotification.Name(rawValue: "temperatureChanged"),
                       object: nil)
        
        
    }

    func catchNotification(_ notification:Notification) -> Void {
        
        
        guard let userInfo = (notification as NSNotification).userInfo,
            let temperature  = userInfo["temperature"] as? Double else {
                print("No userInfo found in notification")
                return
        }
     
        temperatureChanged(temperature)
        
    }
    

    func animate(){
        
      let animation = CATransition()
        
        animation.delegate = self
        
        animation.isRemovedOnCompletion = false
        
        animation.duration = 0.10
        
        animation.type = kCATransitionPush
        
        if (endValue > startValue){
            
            animationSubtype = kCATransitionFromTop
            
        } else if (endValue < startValue){
            
            animationSubtype = kCATransitionFromBottom
            
        }
        
        animation.subtype = animationSubtype
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        counterLabel.layer.removeAllAnimations()
        
        counterLabel.layer.add(animation, forKey:"changeTextTransition")

    }
    
     func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
       
        if (startValue == endValue) {
            return
        }
        
        animate()
   
        if (endValue > startValue){
            
            startValue += 1
       
        } else if (endValue < startValue){
            
            startValue -= 1
            
        }
        
        counterLabel.text = "\(startValue)";
       
    }
    
    //MARK:Weather Manager Delegate Method
    
    func temperatureChanged(_ temperature: Double) {
       
        let temperatureInt:Int = Int(temperature)
        
       let tempratureString =  String(format: "%03d", temperatureInt)
        
        var tempratureStringArray = tempratureString.characters.map { String($0) }
        
        guard let changeToValue = Int(tempratureStringArray[index]) else {
            return
        }
        
        endValue = changeToValue

        animate()
        
    }
    
    deinit{
        
        nc.removeObserver(self)
    }
    
  
}

