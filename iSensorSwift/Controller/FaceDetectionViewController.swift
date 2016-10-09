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
        guard let image = self.imageView.image, cgImage = image.CGImage else {
            return
        }
        
        // Create CIImage from CGImage
        let ciImage = CIImage(CGImage: cgImage)
        
        // Create CIDetector
        let detector = CIDetector(ofType: CIDetectorTypeFace,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        // CoreImage coordinate system origin is at the bottom left corner
        // and UIKit is at the top left corner. So we need to translate
        // features positions before drawing them to screen. In order to do
        // so we make an affine transform
        var transform = CGAffineTransformMakeScale(1, -1);
        transform = CGAffineTransformTranslate(transform, 0, -self.imageView.bounds.size.height);

        // Detect features from the image
        let features = detector?.featuresInImage(ciImage, options: [CIDetectorSmile : true])
        for feature in features as! [CIFaceFeature] {
            // Get the face rect: Convert CoreImage to UIKit coordinates
            let faceRect = CGRectApplyAffineTransform(feature.bounds, transform)

            // Create a UIView using the bounds of the face
            // Red border: smile :-)
            // Blue border: not smile :-(
            let faceView = UIView(frame:faceRect)
            faceView.layer.borderWidth = 1;
            faceView.layer.borderColor = feature.hasSmile ? UIColor.redColor().CGColor : UIColor.blueColor().CGColor
            self.imageView.addSubview(faceView)
        }
    }

    // Prevent that the coordinate is shifted
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.contentMode = .ScaleAspectFit
            self.imageView.image = self.resizeImage(pickedImage, newSize: CGSizeMake(280, 210))
        }
        self.detectButton.enabled = true;
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
