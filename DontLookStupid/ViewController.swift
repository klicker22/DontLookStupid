//
//  ViewController.swift
//  DontLookStupid
//
//  Created by Andrew Klick on 2/16/17.
//  Copyright © 2017 Andrew Klick. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var frontCameraView: UIView!
    @IBOutlet weak var picTakenLabel: UILabel!
    
    
    let captureSession = AVCaptureSession()
    let sessionOutput = AVCaptureVideoDataOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    override func viewWillAppear(_ animated: Bool) {
        
        let deviceSession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInDualCamera, .builtInTelephotoCamera, .builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .unspecified)
        
        for device in (deviceSession?.devices)! {
            
            if device.position == AVCaptureDevicePosition.front {
                
                do {
                    
                    let input = try AVCaptureDeviceInput(device: device)
                    
                    if captureSession.canAddInput(input) {
                        captureSession.addInput(input)
                        
                        if captureSession.canAddOutput(sessionOutput) {
                            captureSession.addOutput(sessionOutput)
                            
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                            previewLayer.connection.videoOrientation = .portrait
                            
                            frontCameraView.layer.addSublayer(previewLayer)
                            frontCameraView.addSubview(speedLabel)
                            frontCameraView.addSubview(picTakenLabel)
                            
                            previewLayer.position = CGPoint(x: self.frontCameraView.frame.width / 2, y: self.frontCameraView.frame.height / 2)
                            previewLayer.bounds = frontCameraView.frame
                            
                            captureSession.startRunning()
                            
                        }
                        
                    }
                    
                } catch let avError {
                    print(avError)
                }
                
            }
            
        }
    }
    
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

    
//    @IBAction func librarySwipe(_ sender: Any) {
//        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
//            var imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePicker.allowsEditing = true
//            self.presentedViewController(imagePicker, animated: true, completion: nil)
//            
//        }
//        
//    }

}

