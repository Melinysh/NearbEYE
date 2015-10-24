//
//  ParseUrbdanDesignAOp.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import CoreData

class ParseUrbdanDesignAOp: Operation {

	
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
				
				guard let name = properties["PROJ_NAME"] as? String else {
					fatalError("Could not extract PARK_NAME from JSON.")
				}
				
				guard let addr = properties["ADDRESS"] as? String else {
					fatalError("Could not extract desc from JSON")
				}
				
				guard let award = properties["AWARD"] as? String else {
					fatalError("Could not extract desc from JSON")
				}
				
				guard let proj_desc = properties["PROJ_DESC"] as? String else {
					fatalError("Could not extract desc from JSON")
				}
				
				guard let jury_comments = properties["JURY_COMMENTS"] as? String else {
					fatalError("Could not extract desc from JSON")
				}
				
				guard let geometry = rink["geometry"] as? [String : AnyObject] else {
					fatalError("No geometry, talk to stephen.")
				}
				
				guard let coordinates = geometry["coordinates"] as? [Double] else {
					fatalError("No coords, talk to stephen.")
				}
				
				let p = NSEntityDescription.insertNewObjectForEntityForName("UrbanDesignAward", inManagedObjectContext: self.context!) as! UrbanDesignAward
				p.longitude = coordinates[0]
				p.latitude = coordinates[1]
				p.projectName = name
				p.address = addr
				p.awardName = award
				p.projectDescription = proj_desc
				p.juryComments = jury_comments
				print("Added UDA")

			}
		})
		finish()
	}

}
