//
//  CustomDetailUnwindSegue.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-25.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class CustomDetailUnwindSegue: UIStoryboardSegue {
	
	override func perform() {

		let secondVCView = self.sourceViewController.view as UIView!
		let firstVCView = (self.destinationViewController as! CameraViewController).cameraView.view
		
		//let screenHeight = UIScreen.mainScreen().bounds.size.height
		let screenWidth = UIScreen.mainScreen().bounds.size.width

		
		let window = UIApplication.sharedApplication().keyWindow
		window?.insertSubview(firstVCView, aboveSubview: secondVCView)
		
		
		// Animate the transition.
		UIView.animateWithDuration(0.4, animations: { () -> Void in
		firstVCView.frame = CGRectOffset(firstVCView.frame, screenWidth, 0.0)
		secondVCView.frame = CGRectOffset(secondVCView.frame, -screenWidth, 0.0)
		
		}) { (Finished) -> Void in
		
			self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
		}
		
	}
	

	
}
