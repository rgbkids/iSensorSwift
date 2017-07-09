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
        
        UIDevice.current.isBatteryMonitoringEnabled = true

        // Init Labels
        self.updateBatteryLevelLabel()
        self.updateBatteryStateLabel()
        
        // Observe battery level
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(BatteryViewController.batteryLevelDidChange),
                                                         name: NSNotification.Name.UIDeviceBatteryLevelDidChange,
                                                         object: nil)

        // Observe battery state
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(BatteryViewController.batteryStateDidChange),
                                                         name: NSNotification.Name.UIDeviceBatteryStateDidChange,
                                                         object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // Finish observation
        UIDevice.current.isBatteryMonitoringEnabled = false

        NotificationCenter.default.removeObserver(self,
            name: NSNotification.Name.UIDeviceBatteryLevelDidChange,
            object: nil)

        NotificationCenter.default.removeObserver(self,
            name: NSNotification.Name.UIDeviceBatteryStateDidChange,
            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Internal method

    func updateBatteryLevelLabel() {
        let batteryLevel = UIDevice.current.batteryLevel
        self.batteryLevelLabel?.text = "\(batteryLevel)"
    }

    func updateBatteryStateLabel() {
        let batteryStateString: String
    
        let status = UIDevice.current.batteryState
        switch status {
        case .full:
            batteryStateString = "Full"
        case .unplugged:
            batteryStateString = "Unplugged"
        case .charging:
            batteryStateString = "Charging"
        case .unknown:
            batteryStateString = "Unknown"
        }
        
        self.batteryStateLabel!.text = batteryStateString
    }
    
    @objc func batteryLevelDidChange() {
        self.updateBatteryLevelLabel()
    }
    
    @objc func batteryStateDidChange() {
        self.updateBatteryStateLabel()
    }
}
