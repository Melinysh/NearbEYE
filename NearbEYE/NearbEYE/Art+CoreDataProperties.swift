//
//  Art+CoreDataProperties.swift
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

extension Art {

    @NSManaged var longitude: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var artist: String?
    @NSManaged var yearInstalled: NSNumber?
    @NSManaged var url: String?

	func propertyList() -> [String] {
		return ["name", "artist", "yearInstalled", "url"]
	}
	
}
