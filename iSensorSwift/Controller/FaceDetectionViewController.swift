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

        guard let image = self.imageView.image, cgImage = image.CGImage else {
            return
        }
        
        // Create CIImage from CGImage
        let ciImage = CIImage(CGImage: cgImage)
        
        // 顔認識なのでTypeをCIDetectorTypeFaceに指定する
        let detector = CIDetector(ofType: CIDetectorTypeFace,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        // 取得するパラメーターを指定する
        let options = [CIDetectorSmile : true, CIDetectorEyeBlink : true]
        
        // 画像から特徴を抽出する
        let features = detector.featuresInImage(ciImage, options: options)
        
        var resultString = "DETECTED FACES:\n\n"
        
        // CoreImageは、左下の座標が (0,0) となるので、UIKitと同じ座標系に変換
        var transform = CGAffineTransformMakeScale(1, -1);
        transform = CGAffineTransformTranslate(transform, 0, -self.imageView.bounds.size.height);

        for feature in features as! [CIFaceFeature] {
            resultString.appendContentsOf("bounds: \(NSStringFromCGRect(feature.bounds))\n")
            resultString.appendContentsOf("hasSmile: \(feature.hasSmile ? "YES" : "NO")\n")
            
            resultString.appendContentsOf("\n")
            
            // 座標変換
            let faceRect = CGRectApplyAffineTransform(feature.bounds, transform)
            resultString.appendContentsOf("bounds: \(NSStringFromCGRect(faceRect))\n")
            
            // 顔検出された範囲に赤い枠線を付ける
            let faceView = UIView(frame:faceRect)
            faceView.layer.borderWidth = 1;
            faceView.layer.borderColor = UIColor.redColor().CGColor
            self.imageView.addSubview(faceView)
        }
        
        print(resultString)
    }

    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
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
