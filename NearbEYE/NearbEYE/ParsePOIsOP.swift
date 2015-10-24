//
//  ParsePOIsOP.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import CoreData

class ParsePOIsOP: Operation {

	var loadJSONOp : LoadJSONOperation!
	init(loadJSONOp : LoadJSONOperation!) {
		self.loadJSONOp = loadJSONOp
		super.init()
	}
	
	override func execute() {
		guard let features = loadJSONOp.json["features"] as? [[String : AnyObject]] else {
			fatalError("JSON loaded from LoadJSONOperation is different than what was expected.")
		}
		context!.performBlockAndWait({ () -> Void in
			
			
			for rink in features {
				
				let r = NSEntityDescription.insertNewObjectForEntityForName("PointOfInterest", inManagedObjectContext: self.context!) as! PointOfInterest

				guard let properties =  rink["properties"] as? [String : AnyObject]  else {
					fatalError("No properties in json")
				}
				
				guard let name = properties["FACILITY"] as? String else {
					fatalError("Could not extract PARK_NAME from JSON.")
				}
				
				guard let owner = properties["OWNER"] as? String else {
					fatalError("Could not extract desc from JSON")
				}
				
				if let type = properties["TYPE"] as? String  {
					r.type = type
				}
				
				guard let geometry = rink["geometry"] as? [String : AnyObject] else {
					fatalError("No geometry, talk to stephen.")
				}
				
				guard let coordinates = geometry["coordinates"] as? [Double] else {
					fatalError("No coords, talk to stephen.")
				}
				
				r.longitude = coordinates[0]
				r.latitude = coordinates[1]
				r.name = name
				r.owner = owner
				print("Added POI")

			}
		})
		finish()
	}
	

	
}
