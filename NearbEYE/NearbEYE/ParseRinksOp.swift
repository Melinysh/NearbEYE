//
//  ParseRinksOp.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import CoreData

class ParseRinksOp: Operation {
	
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
	
					guard let properties =  rink["properties"] as? [String : AnyObject]  else {
					 fatalError("No properties in json")
					}
	
					guard let name = properties["PARK_NAME"] as? String else {
						fatalError("Could not extract PARK_NAME from JSON.")
					}
	
					guard let desc = properties["DESC_"] as? String else {
						fatalError("Could not extract desc from JSON")
					}
	
					guard let url_schd = properties["PDF_SCHEDULE"] as? String else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let geometry = rink["geometry"] as? [String : AnyObject] else {
						fatalError("No geometry, talk to stephen.")
					}
					
					guard let coordinates = geometry["coordinates"] as? [Double] else {
						fatalError("No coords, talk to stephen.")
					}
	
					let r = NSEntityDescription.insertNewObjectForEntityForName("Rink", inManagedObjectContext: self.context!) as! Rink
					r.longitude = coordinates[0]
					r.latitude = coordinates[1]
					r.name = name
					r.desc = desc
					r.schedule_url = url_schd
					print("Added Rink")
				}
			})
			finish()
		}


}
