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

    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func downButtonDidTap(sender: AnyObject) {
        var brightness = UIScreen.mainScreen().brightness
        brightness -= 0.1
        if brightness < 0.0 { brightness = 0.0 }
        UIScreen.mainScreen().brightness = brightness
        self.updateBrightnessLabel()
    }

    @IBAction func upButtonDidTap(sender: AnyObject) {
        var brightness = UIScreen.mainScreen().brightness
        brightness += 0.1
        if brightness > 1.0 { brightness = 1.0 }
        UIScreen.mainScreen().brightness = brightness
        self.updateBrightnessLabel()
    }
}
