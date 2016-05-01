//
//  ShakeViewController.swift
//  iSensorSwift
//
//  Created by koogawa on 2016/03/20.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit

class ShakeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Override methods

    override var canBecomeFirstResponder : Bool {
        return true
    }

    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.type == UIEventType.motion && event?.subtype == UIEventSubtype.motionShake {
            let text = self.textView.text
            self.textView.text = text! + "\nMotion began"
        }
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.type == UIEventType.motion && event?.subtype == UIEventSubtype.motionShake {
            let text = self.textView.text
            self.textView.text = text! + "\nMotion ended"
        }
    }

    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.type == UIEventType.motion && event?.subtype == UIEventSubtype.motionShake {
            let text = self.textView.text
            self.textView.text = text! + "\nMotion cancelled"
        }
    }
}
