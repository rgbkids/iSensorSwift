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
            
            // Specifies the minimum amount of change in degrees needed for a heading service update (default: 1 degree)
            locationManager.headingFilter = kCLHeadingFilterNone
            
            // Specifies a physical device orientation from which heading calculation should be referenced
            locationManager.headingOrientation = .portrait

            locationManager.startUpdatingHeading()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingHeading()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CLLocationManager delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.textField.text = "".appendingFormat("%.2f", newHeading.magneticHeading)
    }
}
