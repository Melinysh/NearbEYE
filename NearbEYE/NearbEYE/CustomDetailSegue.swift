//
//  CustomDetailSegue.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-25.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class CustomDetailSegue: UIStoryboardSegue {
	
	override func perform() {
		// Assign the source and destination views to local variables.
		let firstVCView = (self.sourceViewController as! CameraViewController).cameraView.view
		let secondVCView = self.destinationViewController.view as UIView!
		
		// Get the screen width and height.
		let screenWidth = UIScreen.mainScreen().bounds.size.width
		let screenHeight = UIScreen.mainScreen().bounds.size.height
		
		// Specify the initial position of the destination view.
		secondVCView.frame = CGRectMake(screenWidth, 0.0, screenWidth, screenHeight)
		
		// Access the app's key window and insert the destination view above the current (source) one.
		let window = UIApplication.sharedApplication().keyWindow
		window?.insertSubview(secondVCView, aboveSubview: firstVCView)
		
		
		// Animate the transition.
		UIView.animateWithDuration(0.4, animations: { () -> Void in
			firstVCView.frame = CGRectOffset(firstVCView.frame, -screenWidth, 0)
			secondVCView.frame = CGRectOffset(secondVCView.frame, -screenWidth, 0)
			
			}) { (Finished) -> Void in
				self.sourceViewController.presentViewController(self.destinationViewController as UIViewController,
					animated: false,
					completion: nil)
		}
	}


}
