//
//  ViewController.swift
//  iSensorSwift
//
//  Created by Kosuke Ogawa on 2016/03/15.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var batteryLevelLabel: UILabel!    
    @IBOutlet weak var batteryStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // バッテリー状態を監視できるようにする
        UIDevice.currentDevice().batteryMonitoringEnabled = true
        
        // バッテリー残量監視オン
//        [[NSNotificationCenter defaultCenter] addObserver:self
//            selector:@selector(batteryLevelDidChange:)
//        name:UIDeviceBatteryLevelDidChangeNotification
//        object:nil];
        
        self.updateBatteryLevelLabel()
        
        self.updateBatteryStateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateBatteryLevelLabel() {
        // バッテリーの残量を取得する
        let batteryLevel = UIDevice.currentDevice().batteryLevel
    
        self.batteryLevelLabel?.text = "\(batteryLevel)"
    }

    func updateBatteryStateLabel() {
        let batteryStateString: String
        
//    NSString *batteryStateString;
    
        // バッテリーの充電状態を取得する
        let status = UIDevice.currentDevice().batteryState
        switch status {
        case .Full:
            batteryStateString = "Full"
        case .Unplugged:
            batteryStateString = "Full"
        case .Charging:
            batteryStateString = "Full"
        case .Unknown:
            batteryStateString = "Full"
        }
        
        self.batteryStateLabel!.text = batteryStateString
    }
    
    //    switch ([UIDevice currentDevice].batteryState)
//    {
//    case UIDeviceBatteryStateFull:
//    batteryStateString = @"Full";
//    break;
//    
//    case UIDeviceBatteryStateUnplugged:
//    batteryStateString = @"Unplugged";
//    break;
//    
//    case UIDeviceBatteryStateCharging:
//    batteryStateString = @"Charging";
//    break;
//    
//    case UIDeviceBatteryStateUnknown:
//    batteryStateString = @"Unknown";
//    break;
//    
//    default:
//    break;
//    }
//    
//    self.batteryStateLabel.text = batteryStateString;
    }


