//
//  ProximityViewController.swift
//  iSensorSwift
//
//  Created by koogawa on 2016/03/19.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit

class ProximityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIDevice.current.isProximityMonitoringEnabled = true

        // Observe proximity state
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(proximitySensorStateDidChange),
                                                         name: NSNotification.Name.UIDeviceProximityStateDidChange,
                                                         object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // Finish observation
        UIDevice.current.isProximityMonitoringEnabled = false

        NotificationCenter.default.removeObserver(self,
                                                            name: NSNotification.Name.UIDeviceProximityStateDidChange,
                                                            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Internal method

    @objc func proximitySensorStateDidChange() {
        print("proximityState : \(UIDevice.current.proximityState)")
    }
}
