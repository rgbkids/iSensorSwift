//
//  HeadingViewController.swift
//  iSensorSwift
//
//  Created by Kosuke Ogawa on 2016/03/30.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import CoreLocation

class HeadingViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            //
            locationManager.headingFilter = kCLHeadingFilterNone
            
            // デバイスの度の向きを北とするか（デフォルトは画面上部）
            locationManager.headingOrientation = .Portrait //CLDeviceOrientationPortrait;

            locationManager.startUpdatingHeading()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CLLocationManager delegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .Restricted, .Denied:
            break
        case .Authorized, .AuthorizedWhenInUse:
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.textField.text = "".stringByAppendingFormat("%.2f", newHeading.magneticHeading)
    }
}
