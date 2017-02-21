//
//  ViewController.swift
//  DontLookStupid
//
//  Created by Andrew Klick on 2/16/17.
//  Copyright © 2017 Andrew Klick. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    
    @IBOutlet weak var speedLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            
            
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            
            locationManager.startUpdatingLocation()
            
        }
        
        
    }

    
    // Obtained from http://stackoverflow.com/questions/25296691/get-users-current-location-coordinates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let speed = (((manager.location!.speed) * 2.23694) * 100).rounded() / 100
        //let location = locations[0]
        
        
        //let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        
        //speedLabel.text = "Latitude = \(location.coordinate.latitude)\n Longitude = \(location.coordinate.longitude)"
        
        if speed < 0 {
            
            speedLabel.text = "0.0 MPH"
            
        } else {
            speedLabel.text = "\(speed) MPH"
        }
    }


}

