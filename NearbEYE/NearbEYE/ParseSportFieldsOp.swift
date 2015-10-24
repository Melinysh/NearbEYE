//
//  ParseSportFieldsOp.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import CoreData

class ParseSportFieldsOp: Operation {

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
				
				let r = NSEntityDescription.insertNewObjectForEntityForName("SportField", inManagedObjectContext: self.context!) as! SportField

				
				guard let properties =  rink["properties"] as? [String : AnyObject]  else {
					fatalError("No properties in json")
				}
				
				guard let area = properties["AREA_M"] as? String else {
					fatalError("Could not extract PARK_NAME from JSON.")
				}
				
				guard let hasLstr = properties["LIGHTS"] as? String else {
					fatalError("Could not extract desc from JSON")
				}
				
				if let hasPStr = properties["PARKING"] as? String  {
					r.hasParking = self.toBool(hasPStr)
				}
				
				if let hasWStr = properties["WASHROOMS"] as? String  {
					r.hasWashrooms = self.toBool(hasWStr)
				}
				
				if let hasPlayGSte = properties["PLAYGRND"] as? String  {
					r.hasPlayground = self.toBool(hasPlayGSte)
				}
				
				guard let geometry = rink["geometry"] as? [String : AnyObject] else {
					fatalError("No geometry, talk to stephen.")
				}
				
				if let coordinates = geometry["coordinates"] as? [[[Double]]]  {
					r.longitude = coordinates[0][0][0]
					r.latitude = coordinates[0][0][1]
				} else if let coordinates = geometry["coordinates"] as? [[[[Double]]]] {
					r.longitude = coordinates[0][0][0][0]
					r.latitude = coordinates[0][0][0][1]
					
				}
				
				
				r.area = Double(area)
				r.hasLights = self.toBool(hasLstr)
				print("Added field")

			}
		})
		finish()
	}
	
	
	private func toBool(str : String) -> Bool {
		if str == "NO" {
			return false
		}
		return true
	}

	
}
