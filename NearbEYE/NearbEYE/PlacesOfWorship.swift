//
//  PlacesOfWorship.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import Foundation
import CoreData

@objc(PlaceOfWorship)

class PlaceOfWorship: NSManagedObject, Stringify {

// Insert code here to add functionality to your managed object subclass

	func selfName() -> String {
		return name != nil ? name! : "Place of Worship"
	}
}
