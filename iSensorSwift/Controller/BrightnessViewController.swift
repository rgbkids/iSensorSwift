//
//  BrightnessViewController.swift
//  iSensorSwift
//
//  Created by koogawa on 2016/03/21.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit

class BrightnessViewController: UIViewController {

    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var brightStepper: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UIStepper
        let screen = UIScreen.mainScreen()
        self.brightStepper.value = Double(screen.brightness)

        self.updateBrightnessLabel()

        // Observe screen brightness
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "screenBrightnessDidChange:",
                                                         name: UIScreenBrightnessDidChangeNotification,
                                                         object: nil)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

        // Finish observation
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIScreenBrightnessDidChangeNotification,
                                                            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Internal methods

    func updateBrightnessLabel() {
        let screen = UIScreen.mainScreen()
        self.brightnessLabel.text = "".stringByAppendingFormat("%.2f", screen.brightness)
    }

    func screenBrightnessDidChange(notification: NSNotification) {
        if let screen = notification.object {
            self.brightnessLabel.text = "".stringByAppendingFormat("%.2f", screen.brightness)
        }
    }

    // MARK: - Action methods

    @IBAction func stepperDidTap(stepper: UIStepper) {
        UIScreen.mainScreen().brightness = CGFloat(stepper.value)
        self.updateBrightnessLabel()
    }
}
