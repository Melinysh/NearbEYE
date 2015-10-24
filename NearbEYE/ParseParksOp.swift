//
//  ParseParksOp.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import CoreData

class ParseParksOp: Operation {
	
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
				
				
				for park in features {
					
					guard let properties =  park["properties"] as? [String : AnyObject]  else {
					 fatalError("No properties in json")
					}
					
					guard let name = properties["PARK_NAME"] as? String else {
						fatalError("Could not extract PARK_NAME from JSON.")
					}
					
					guard let playgrounds = properties["PLAYGROUND"] as? String else {
						fatalError("Could not extract desc from JSON")
					}
					
					guard let addr = properties["ADDRESS"] as? String else {
						fatalError("Could not extract desc from JSON")
					}
					
					guard let bridges = properties["BRIDGES"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let benches = properties["BENCHES"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let trashCansStr = properties["TRASH_CANS"] as? String else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let bike_racks = properties["BIKE_RACK"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let tennisCourts = properties["TENNIS_CRT"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let diamonds = properties["DIAMOND"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					
					guard let bball = properties["BASKETBALL"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let cricket = properties["CRICKET"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let rinksStr = properties["RINKS"] as? String else {
						fatalError("Could not extract latitude from JSON")
					}
					
					
					
					guard let toboggs = properties["TOBOGGAN"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let washrooms = properties["WASHROOM"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let fields = properties["FIELDS"] as? Int else {
						fatalError("Could not extract latitude from JSON")
					}
					
					guard let area = properties["AREA_M"] as? Double else {
						fatalError("Could not extract latitude from JSON")
					}

					let p = NSEntityDescription.insertNewObjectForEntityForName("Park", inManagedObjectContext: self.context!) as! Park

					
					
					guard let geometry = park["geometry"] as? [String : AnyObject] else {
						fatalError("No geometry, talk to stephen.")
					}
					
					if let coordinates = geometry["coordinates"] as? [[[Double]]]  {
						p.longitude = coordinates[0][0][0]
						p.latitude = coordinates[0][0][1]
					} else if let coordinates = geometry["coordinates"] as? [[[[[Double]]]]] {
						p.longitude = coordinates[0][0][0][0][0]
						p.latitude = coordinates[0][0][0][0][1]
					}
					
                    p.name = name
					p.playgrounds = Int(playgrounds)
					p.bridges = bridges
					p.benches = benches
					p.hasTrashcans = self.toBool(trashCansStr)
					p.bikeracks = bike_racks
					p.tenniscourts = tennisCourts
					p.diamonds = diamonds
					p.basketball = bball
					p.cricket = cricket
					p.hasRink = self.toBool(rinksStr)
					p.toboggans = toboggs
					p.area = area
					p.washrooms = washrooms
					p.address = addr
					p.fields = fields
					
					//	p.schedule_url = url_schd
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

