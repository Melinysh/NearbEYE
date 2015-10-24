//
//  ParsePublicArtOp.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import CoreData

class ParsePublicArtOp: Operation {

	
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
				
				let p = NSEntityDescription.insertNewObjectForEntityForName("Art", inManagedObjectContext: self.context!) as! Art

				
				guard let properties =  rink["properties"] as? [String : AnyObject]  else {
					fatalError("No properties in json")
				}
				
				guard let name = properties["TITLE"] as? String else {
					fatalError("Could not extract PARK_NAME from JSON.")
				}
				
				guard let artist = properties["ARTIST"] as? String else {
					fatalError("Could not extract PARK_NAME from JSON.")
				}
				
				guard let installedYear = properties["INSTALLED"] as? String else {
					fatalError("Could not extract PARK_NAME from JSON.")
				}
				
				if let url = properties["URL"] as? String  {
					p.url = url
				}
			
					
				guard let geometry = rink["geometry"] as? [String : AnyObject] else {
					fatalError("No geometry, talk to stephen.")
				}
				
				guard let coordinates = geometry["coordinates"] as? [Double] else {
					fatalError("No coords, talk to stephen.")
				}
				
				p.longitude = coordinates[0]
				p.latitude = coordinates[1]
				p.name = name
				p.artist = artist
				p.yearInstalled = Int(installedYear)
				print("Added Art")

			}
		})
		finish()
	}
	
}
