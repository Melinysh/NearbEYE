//
//  Park+CoreDataProperties.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Park {

    @NSManaged var name: String?
    @NSManaged var address: String?
    @NSManaged var playgrounds: NSNumber?
    @NSManaged var bridges: NSNumber?
    @NSManaged var benches: NSNumber?
    @NSManaged var hasTrashcans: NSNumber?
    @NSManaged var bikeracks: NSNumber?
    @NSManaged var tenniscourts: NSNumber?
    @NSManaged var diamonds: NSNumber?
    @NSManaged var fields: NSNumber?
    @NSManaged var basketball: NSNumber?
    @NSManaged var cricket: NSNumber?
    @NSManaged var hasRink: NSNumber?
    @NSManaged var toboggans: NSNumber?
    @NSManaged var washrooms: NSNumber?
    @NSManaged var area: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var latitude: NSNumber?
	
	func propertyList() -> [String] {
		return ["name", "address", "playgrounds", "bridges", "benches", "hasTrashcans", "bikeracks", "tenniscourts", "diamonds", "fields", "basketball", "cricket", "hasRink", "toboggans", "washrooms", "area"]
	}

}
