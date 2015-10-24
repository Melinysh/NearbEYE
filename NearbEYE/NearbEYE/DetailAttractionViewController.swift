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
	
	var attraction : AnyObject! {
		didSet {
			propertiesList = (attraction.performSelector("propertyList").takeRetainedValue() as! [String])
		}
	}
	
	var propertiesList = [String]()  
	

	@IBOutlet weak var mapView: MKMapView!
	
	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
	
		
		titleLabel.text = String(attraction.dynamicType)
		
		mapView.showsUserLocation = true
		mapView.showsCompass = true
		
		tableView.estimatedRowHeight = 44.0
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.reloadData()
		
		let location = mapView.userLocation
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
		
		mapView.setRegion(region, animated: true)
		
		// Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? DetailTableViewCell {
			let propertyName = propertiesList[indexPath.row]
			cell.propertyTitle.text = propertyName
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


}
