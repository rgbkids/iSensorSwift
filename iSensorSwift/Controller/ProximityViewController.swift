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
        UIDevice.currentDevice().proximityMonitoringEnabled = true

        // Observe proximity state
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "proximitySensorStateDidChange",
            name: UIDeviceProximityStateDidChangeNotification,
            object: nil)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

        // Finish observation
        UIDevice.currentDevice().proximityMonitoringEnabled = false

        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIDeviceProximityStateDidChangeNotification,
                                                            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Internal method

    func proximitySensorStateDidChange() {
        print("proximityState : \(UIDevice.currentDevice().proximityState)")
    }
}
