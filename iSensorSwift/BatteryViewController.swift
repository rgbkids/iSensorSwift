//
//  BatteryViewController.swift
//  iSensorSwift
//
//  Created by Kosuke Ogawa on 2016/03/15.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit

class BatteryViewController: UIViewController {

    @IBOutlet weak var batteryLevelLabel: UILabel!    
    @IBOutlet weak var batteryStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.currentDevice().batteryMonitoringEnabled = true

        // Init Labels
        self.updateBatteryLevelLabel()
        self.updateBatteryStateLabel()
        
        // Observe battery level
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "batteryLevelDidChange",
            name: UIDeviceBatteryLevelDidChangeNotification,
            object: nil)

        // Observe battery state
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "batteryStateDidChange",
            name: UIDeviceBatteryStateDidChangeNotification,
            object: nil)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

        // Finish observation
        UIDevice.currentDevice().batteryMonitoringEnabled = false

        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIDeviceBatteryLevelDidChangeNotification,
            object: nil)

        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIDeviceBatteryStateDidChangeNotification,
            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateBatteryLevelLabel() {
        let batteryLevel = UIDevice.currentDevice().batteryLevel
        self.batteryLevelLabel?.text = "\(batteryLevel)"
    }

    func updateBatteryStateLabel() {
        let batteryStateString: String
    
        let status = UIDevice.currentDevice().batteryState
        switch status {
        case .Full:
            batteryStateString = "Full"
        case .Unplugged:
            batteryStateString = "Unplugged"
        case .Charging:
            batteryStateString = "Charging"
        case .Unknown:
            batteryStateString = "Unknown"
        }
        
        self.batteryStateLabel!.text = batteryStateString
    }
    
    func batteryLevelDidChange() {
        self.updateBatteryLevelLabel()
    }
    
    func batteryStateDidChange() {
        self.updateBatteryStateLabel()
    }
}
