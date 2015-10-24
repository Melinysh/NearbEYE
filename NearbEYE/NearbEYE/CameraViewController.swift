//
//  ViewController.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidAppear(animated: Bool) {
		super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        let cameraView = UIImagePickerController()
        let screenSize = UIScreen.mainScreen().bounds.size
        cameraView.sourceType = UIImagePickerControllerSourceType.Camera
        cameraView.delegate = self
        cameraView.showsCameraControls = false
        cameraView.cameraViewTransform = CGAffineTransformTranslate(CGAffineTransformMakeScale(4.2/3.0, 4.2/3.0), 0, screenSize.height / 10.0)
        
        let cameraOverlay = CameraOverlayView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height * 2))
        cameraView.cameraOverlayView = cameraOverlay
        
        self.presentViewController(cameraView, animated: true, completion: nil)
        
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
    }

}

