//
//  FaceDetectionViewController.swift
//  iSensorSwift
//
//  Created by koogawa on 2016/04/23.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit

class FaceDetectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detectButton: UIButton!

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
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
    }

    @IBAction func didTapDetectTap(sender: AnyObject) {
        print(2)
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.contentMode = .ScaleAspectFit
            self.imageView.image = pickedImage
        }
        self.detectButton.enabled = true;
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
