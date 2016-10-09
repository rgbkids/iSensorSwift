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

        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
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

    func locationManager(_ manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.latTextField.text = "".appendingFormat("%.4f", newLocation.coordinate.latitude)
        self.lngTextField.text = "".appendingFormat("%.4f", newLocation.coordinate.longitude)
    }
}
