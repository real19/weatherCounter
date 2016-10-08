//
//  ViewController.swift
//  counter
//
//  Created by Suleman Imdad on 8/19/16.
//  Copyright © 2016 Suleman Imdad. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate , UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var counterLabelView: CounterLabelView!
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    var locationManager: CLLocationManager!
    
   
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.layer.cornerRadius = 19.0
        
        collectionView.clipsToBounds = true
        
        collectionView.layer.borderWidth = 8.0
        
        collectionView.layer.borderColor = UIColor.black.cgColor
        
        WeatherManager.sharedInstance.startPullingWeatherTest()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CounterCollectionViewCell
        
        cell.counterLabelView.index = (indexPath as NSIndexPath).item
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

