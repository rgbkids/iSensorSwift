//
//  LocationViewController.swift
//  iSensorSwift
//
//  Created by Kosuke Ogawa on 2016/03/23.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var lngTextField: UITextField!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
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
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.latTextField.text = "".stringByAppendingFormat("%.4f", newLocation.coordinate.latitude)
        self.lngTextField.text = "".stringByAppendingFormat("%.4f", newLocation.coordinate.longitude)
    }
}
