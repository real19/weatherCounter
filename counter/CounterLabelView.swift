//
//  CounterLabel.swift
//  counter
//
//  Created by Suleman Imdad on 8/19/16.
//  Copyright © 2016 Suleman Imdad. All rights reserved.
//

import UIKit

enum CounterUnit:Int {
    
    case Units = 0
    
    case Tens = 1
    
    case Hundreds = 2
}



class CounterLabelView: UIView, WeatherManagerDelegate {
    
    @IBOutlet weak var counterLabel: UILabel!
    
    
    var startValue = 0
    
    var endValue = 0
    
    var  animationSubtype = kCATransitionFromTop
    
    var counterUnit: CounterUnit? = .Hundreds
    
    override func layoutSubviews() {
        
        counterLabel.text = "";
        
        WeatherManager.sharedInstance.delegate = self
    }

    
    func animate(){
        
        print(startValue)
        
        counterLabel.layer.removeAllAnimations()
        
        let animation = CATransition()
        
        animation.delegate = self
        
        animation.removedOnCompletion = false
        
        animation.duration = 1/Double(startValue - endValue)
        
        animation.type = kCATransitionPush
        
        if (endValue > startValue){
            
            animationSubtype = kCATransitionFromTop
            
        } else if (endValue < startValue){
            
            animationSubtype = kCATransitionFromBottom
            
        }
        
        animation.subtype = animationSubtype
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        counterLabel.layer.addAnimation(animation, forKey:"changeTextTransition")

    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        animate()
   
        if (endValue > startValue){
            
            startValue += 1
       
        } else if (endValue < startValue){
            
            startValue -= 1
            
        } else {
            
            return
        }
        
        counterLabel.text = "\(startValue)";
       
    }
    
    //MARK:Weather Manager Delegate Method
    
    func temperatureChanged(temperature: Double) {
        
    
        
        
        let tempratureString = String(Int(temperature))
        
            print("the temperature recieved was " + tempratureString)
        
        var tempratureStringArray = tempratureString.characters.map { String($0) }
        
        
        guard let index:Int = counterUnit?.rawValue else {
            return
        }
        

        
      
    
        guard let changeToValue = Int(tempratureStringArray[index]) else {
            
            return
        }
        
        endValue = changeToValue
        

        print(endValue)
        
        animate()
        
    }
  
}

