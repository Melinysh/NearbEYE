//
//  DetailAttractionViewController.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import MapKit

extension Bool {
	func stringFromBool() -> String {
		if self == true {
			return "Yes"
		}
		return "No"
	}
}

class DetailAttractionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var attraction : AnyObject!
	
	var propertiesList = [String]()
 
	var directions : MKDirectionsResponse!
    var userLocation : CLLocationCoordinate2D!
	

	@IBOutlet weak var mapView: MKMapView!
	
	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
		
		propertiesList = (attraction.performSelector("propertyList").retain().takeRetainedValue() as! [String])
		let request = MKDirectionsRequest()
		request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation, addressDictionary: nil))
		request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2DMake(attraction.valueForKey("latitude") as! Double, attraction.valueForKey("longitude") as! Double) , addressDictionary: nil))
		request.transportType = MKDirectionsTransportType.Walking
		let directions = MKDirections(request: request)
		directions.calculateDirectionsWithCompletionHandler { (response, error) -> Void in
			if let error = error {
				print("There was an error calculating the route \(error)")
				return
			}
			if let resp = response {
				self.directions = resp
				if let route = resp.routes.first {
					self.mapView.addOverlay(route.polyline)
					//self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
				}
			}
		}
		
		tableView.dataSource = self
		tableView.delegate = self
	
		
		titleLabel.text = (attraction.performSelector("selfName").retain().takeRetainedValue() as! String)
		
		tableView.estimatedRowHeight = 44.0
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.reloadData()
		
		let swipe = UISwipeGestureRecognizer(target: self, action: "moveBack")
		swipe.direction = UISwipeGestureRecognizerDirection.Right
		self.view.addGestureRecognizer(swipe)
		
		// Do any additional setup after loading the view.
    }
	
	override func viewDidAppear(animated: Bool) {
		

		
		let location = mapView.userLocation
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
		
		mapView.setRegion(region, animated: true)
		mapView.showsUserLocation = true
		mapView.showsCompass = true
		mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
	}
	
	func moveBack() {
		self.performSegueWithIdentifier("toMain", sender: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func getDirections(sender: AnyObject) {
		if let d = directions {
			let place = d.destination.placemark
			MKMapItem(placemark: place).openInMapsWithLaunchOptions([MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
		}
	}
	
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? DetailTableViewCell {
			let propertyName = propertiesList[indexPath.row]
			cell.propertyTitle.text =  wordify(propertyName)
			cell.propertyValue.text  = String(attraction.valueForKey(propertyName)!)
			
			return cell
		}
		let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "attraction")
		return cell
		
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return propertiesList.count
	}
	
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	
	func wordify(str :String) -> String {
		var firstword = ""
		var secondword = ""
		var toSecondWord = false
			for ch in str.characters {
				if (ch >= "A" && ch <= "Z") || toSecondWord {
					toSecondWord = true
					secondword += String(ch)
				} else {
					firstword += String(ch)
				}
			}
		return firstword.capitalizedString + " " + secondword.capitalizedString
	}
	
	// MARK: - Custom Segue
	
	override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
		return CustomDetailUnwindSegue(identifier: identifier, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
			print("Unwinding from detail vc")
		})
	}

}
