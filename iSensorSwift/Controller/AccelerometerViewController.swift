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

        // Do any additional setup after loading the view.
        //取得の間隔
        manager.accelerometerUpdateInterval = 0.01;
        
        // 値取得時にしたい処理を作成
        let accelerometerHandler:CMAccelerometerHandler = {
            (data: CMAccelerometerData?, error: NSError?) -> Void in
            
            // 取得した値をコンソールに表示
            self.xLabel.text = "".stringByAppendingFormat("%.2f", data!.acceleration.x)
            self.yLabel.text = "".stringByAppendingFormat("%.2f", data!.acceleration.y)
            self.zLabel.text = "".stringByAppendingFormat("%.2f", data!.acceleration.z)

            print("x: \(data!.acceleration.x) y: \(data!.acceleration.y) z: \(data!.acceleration.z)")
        }
        
        /* 加速度センサーを開始する */
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!,
                                                 withHandler: accelerometerHandler)
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

}
