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

    @IBAction func didTapSelectButton(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    @IBAction func didTapDetectTap(_ sender: AnyObject) {
        guard let image = self.imageView.image, let cgImage = image.cgImage else {
            return
        }
        
        // Create CIImage from CGImage
        let ciImage = CIImage(cgImage: cgImage)
        
        // Create CIDetector
        let detector = CIDetector(ofType: CIDetectorTypeFace,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        // CoreImage coordinate system origin is at the bottom left corner
        // and UIKit is at the top left corner. So we need to translate
        // features positions before drawing them to screen. In order to do
        // so we make an affine transform
        var transform = CGAffineTransform(scaleX: 1, y: -1);
        transform = transform.translatedBy(x: 0, y: -self.imageView.bounds.size.height);

        // Detect features from the image
        let features = detector?.features(in: ciImage, options: [CIDetectorSmile : true])
        for feature in features as! [CIFaceFeature] {
            // Get the face rect: Convert CoreImage to UIKit coordinates
            let faceRect = feature.bounds.applying(transform)

            // Create a UIView using the bounds of the face
            // Red border: smile :-)
            // Blue border: not smile :-(
            let faceView = UIView(frame:faceRect)
            faceView.layer.borderWidth = 1;
            faceView.layer.borderColor = feature.hasSmile ? UIColor.red.cgColor : UIColor.blue.cgColor
            self.imageView.addSubview(faceView)
        }
    }

    // Prevent that the coordinate is shifted
    func resizeImage(_ image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = self.resizeImage(pickedImage, newSize: CGSize(width: 280, height: 210))
        }
        self.detectButton.isEnabled = true;
        imagePicker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
