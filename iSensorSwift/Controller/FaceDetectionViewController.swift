//
//  FaceDetectionViewController.swift
//  iSensorSwift
//
//  Created by koogawa on 2016/04/23.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit

class FaceDetectionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Internal methods

    @IBAction func didTapSelectButton(sender: AnyObject) {
        print(1)
    }

    @IBAction func didTapDetectTap(sender: AnyObject) {
        print(2)
    }
}
