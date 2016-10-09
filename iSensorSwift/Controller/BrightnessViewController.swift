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
        let screen = UIScreen.main
        self.brightStepper.value = Double(screen.brightness)

        self.updateBrightnessLabel()

        // Observe screen brightness
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(screenBrightnessDidChange(_:)),
                                                         name: NSNotification.Name.UIScreenBrightnessDidChange,
                                                         object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // Finish observation
        NotificationCenter.default.removeObserver(self,
                                                            name: NSNotification.Name.UIScreenBrightnessDidChange,
                                                            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Internal methods

    func updateBrightnessLabel() {
        let screen = UIScreen.main
        self.brightnessLabel.text = "".appendingFormat("%.2f", screen.brightness)
    }

    func screenBrightnessDidChange(_ notification: Notification) {
        if let screen = notification.object {
            self.brightnessLabel.text = "".appendingFormat("%.2f", (screen as AnyObject).brightness)
        }
    }

    // MARK: - Action methods

    @IBAction func stepperDidTap(_ stepper: UIStepper) {
        UIScreen.main.brightness = CGFloat(stepper.value)
        self.updateBrightnessLabel()
    }
}
