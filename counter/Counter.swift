//
//  CounterLabel.swift
//  counter
//
//  Created by Suleman Imdad on 8/19/16.
//  Copyright © 2016 Suleman Imdad. All rights reserved.
//

import UIKit

class CounterLabelView: UIView {
    
    @IBOutlet weak var counterLabel: UILabel!
    
    
    var startValue = 0
    
    let endValue = 9
    
    var  animationSubtype = kCATransitionFromTop
    
    
    
    override func layoutSubviews() {
        
        counterLabel.text = "\(startValue)";
        
        animate(startValue, value: endValue)
    }

    
    func animate(newValue:Int, value:Int ){
        
        counterLabel.layer.removeAllAnimations()
        
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
        
        counterLabel.layer.addAnimation(animation, forKey:"changeTextTransition")
        
        counterLabel.layer
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
        
        counterLabel.text = "\(startValue)";
        animate(startValue, value: endValue)
    }
  
}

