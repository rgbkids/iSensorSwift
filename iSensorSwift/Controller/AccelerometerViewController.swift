//
//  AccelerometerViewController.swift
//  iSensorSwift
//
//  Created by koogawa on 2016/04/04.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import CoreMotion

class AccelerometerViewController: UIViewController {

    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    let manager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        if manager.isAccelerometerAvailable {
            manager.accelerometerUpdateInterval = 1 / 10; // 10Hz

            let accelerometerHandler:CMAccelerometerHandler = {
                [weak self] (data: CMAccelerometerData?, error: NSError?) -> Void in

                self?.xLabel.text = "".appendingFormat("x %.4f", data!.acceleration.x)
                self?.yLabel.text = "".appendingFormat("y %.4f", data!.acceleration.y)
                self?.zLabel.text = "".appendingFormat("z %.4f", data!.acceleration.z)

                print("x: \(data!.acceleration.x) y: \(data!.acceleration.y) z: \(data!.acceleration.z)")
            } as! CMAccelerometerHandler

            manager.startAccelerometerUpdates(to: OperationQueue.current!,
                                                     withHandler: accelerometerHandler)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if manager.isAccelerometerAvailable {
            manager.stopAccelerometerUpdates()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
