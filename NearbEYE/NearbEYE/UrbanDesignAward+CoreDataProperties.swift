//
//  UrbanDesignAward+CoreDataProperties.swift
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

extension UrbanDesignAward {

    @NSManaged var address: String?
    @NSManaged var longitude: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var awardName: String?
    @NSManaged var projectName: String?
    @NSManaged var projectDescription: String?
    @NSManaged var juryComments: String?

}
