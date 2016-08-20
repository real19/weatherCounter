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
        
        collectionView.layer.borderWidth = 10.0
        
        collectionView.layer.borderColor = UIColor.blackColor().CGColor
        
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
        
        let location = locations.last!
        
        print("location changed \(location)")
        
        WeatherManager.sharedInstance.location = location
        
       location.getLocationName {[weak self] (locationName) in
            
            self?.label.text = "Weather in City of \(locationName)"
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CounterCollectionViewCell
        
        cell.counterLabelView.index = indexPath.item
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

