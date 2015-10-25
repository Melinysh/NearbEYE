//
//  CoreDataCommunicator.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class CoreDataCommunicator {

	let context : NSManagedObjectContext
	init (c : NSManagedObjectContext) {
		context = c
	}
	
	
 private func fetchRequest(entityName : String) -> NSFetchRequest {
	let fetchRequest = NSFetchRequest(entityName: entityName)
	fetchRequest.entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
	return fetchRequest
	}
	
	///Internal function that all other functions use to fetch against the store
	private func fetch(fetchReq: NSFetchRequest) -> [AnyObject] {
		var results = [AnyObject]()
		self.context.performBlockAndWait({ () -> Void in
			do {
				results = try self.context.executeFetchRequest(fetchReq)
			} catch {
				print("An error occured while executing the fetch request: \(error)")
			}
		})
		return results
	}
	
	func attractionsInRadius(maxLat :Double, minLat : Double, maxLong : Double, minLong : Double, userLocation : CLLocationCoordinate2D) -> [AnyObject] {
		let classNames = ["PointOfInterest", "SportField", "PlaceOfWorship", "Rink", "Park", "UrbanDesignAward", "Art", "Playground"]
		var results =  [AnyObject]()
		for name in classNames {
			let fetchReq = fetchRequest(name)
			fetchReq.predicate = NSPredicate(format: "(latitude <= %@) && (latitude >= %@) && (longitude >= %@) && (longitude <= %@)", argumentArray: [maxLat, minLat, minLong, maxLong])
			let objs = fetch(fetchReq)
			results += objs
		}
		results.sortInPlace { (one, two) -> Bool in
			return CoreDataCommunicator.dist(one.valueForKey("latitude") as! Double, longitude: one.valueForKey("longitude") as! Double, userLocaltion: userLocation) < CoreDataCommunicator.dist(two.valueForKey("latitude") as! Double, longitude: two.valueForKey("longitude") as! Double, userLocaltion: userLocation)
		}
		return results
	}
	
	class func dist(latitude :Double, longitude : Double, userLocaltion : CLLocationCoordinate2D) -> Double {
		return sqrt(pow((latitude - userLocaltion.latitude), 2) + pow((longitude - userLocaltion.longitude),2.0))
	}
}
