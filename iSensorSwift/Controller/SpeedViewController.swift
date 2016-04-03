//
//  LocationViewController.swift
//  iSensorSwift
//
//  Created by Kosuke Ogawa on 2016/03/23.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import CoreLocation

class SpeedViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mpsTextField: UITextField!
    @IBOutlet weak var kphTextField: UITextField!

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
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

    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.mpsTextField.text = "".stringByAppendingFormat("%.4f", newLocation.coordinate.latitude)
        self.kphTextField.text = "".stringByAppendingFormat("%.4f", newLocation.coordinate.longitude)
    }
}
