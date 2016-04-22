//
//  MotionActivityViewController.swift
//  iSensorSwift
//
//  Created by koogawa on 2016/04/10.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import CoreMotion

class MotionActivityViewController: UIViewController {

    @IBOutlet weak var stepLabel: UILabel!

    @IBOutlet weak var stationaryLabel: UILabel!
    @IBOutlet weak var walkingLabel: UILabel!
    @IBOutlet weak var runningLabel: UILabel!
    @IBOutlet weak var automotiveLabel: UILabel!
    @IBOutlet weak var unknowLabel: UILabel!

    @IBOutlet weak var confidenceLabel: UILabel!

    let stepCounter = CMStepCounter()
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.stepCounter.startStepCountingUpdatesToQueue(NSOperationQueue.mainQueue(), updateOn: 1, withHandler: { numberOfSteps, timestamp, error in
            if error == nil {
//                self.stepLabel.text = "Steps: \(numberOfSteps)"
            } else {
                print("Step Counter error: \(error)")
            }
        })
        self.startStepCounting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func startStepCounting() {
        // CMPedometerが利用できるか確認
        if CMPedometer.isStepCountingAvailable() {
            // 計測開始
            self.pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: {
                [unowned self] data, error in
                dispatch_async(dispatch_get_main_queue(), {
                    print("update")
                    if error != nil {
                        // エラー
//                        self.label.text = "エラー : \(error)"
                        print("エラー : \(error)")
                    } else {
                        let lengthFormatter = NSLengthFormatter()
                        // 歩数
                        let steps = data?.numberOfSteps
                        // 結果をラベルに出力
                        self.stepLabel.text = "Steps: \(data?.numberOfSteps)"
                    }
                })
                })
        }
    }
}
