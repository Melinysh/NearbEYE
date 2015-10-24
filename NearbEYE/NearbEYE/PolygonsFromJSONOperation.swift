//
//  LoadHealthUnitJSON.swift
//  WellWaterExperiment
//
//  Created by Stephen Melinyshyn on 2015-07-31.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import CoreData

//class PolygonsFromJSONOperation: Operation {
//
//    var context : NSManagedObjectContext!
//    var loadJSONOp : LoadJSONOperation!
//    
//    init(context : NSManagedObjectContext, loadJSONOp : LoadJSONOperation) {
//        self.context = context
//        self.loadJSONOp = loadJSONOp
//        super.init()
//    }
//    
//    
//    override func execute() {
//        guard let features = loadJSONOp.json["features"] as? [[String : AnyObject]] else {
//            fatalError("JSON loaded from LoadJSONOperation is different than what was expected.")
//        }
//        context!.performBlockAndWait({ () -> Void in
//        
//
//            for unit in features {
//
//                guard let attributes =  unit["attributes"] as? [String : AnyObject]  else {
//                 fatalError("No attributes in json")
//                }
//                
//                guard let geology = attributes["ROCKTYPE_P"] as? String else {
//                    fatalError("Could not extract geo type from JSON.")
//                }
//                
//                guard let latitude = attributes["Centroid_Y"] as? Double else {
//                    fatalError("Could not extract latitude from JSON")
//                }
//                
//                guard let longitude = attributes["Centroid_X"] as? Double else {
//                    fatalError("Could not extract latitude from JSON")
//                }
//                
//                let centriodPt = NSEntityDescription.insertNewObjectForEntityForName("Point", inManagedObjectContext: self.context!) as! Point
//                centriodPt.longitude = longitude
//                centriodPt.latitude = latitude
//               
//                
//                
//                guard let geometry = unit["geometry"] as? [String : AnyObject] else {
//                    fatalError("Geometry value in JSON is different than what was expected.")
//                }
//                
//                guard let rings = geometry["rings"] as? [[[Float]]] else {
//                    fatalError("Rings value in JSON is different than what was expected.")
//                }
//
//                // may need to move into rings for loop
//                print("There are \(rings.count) rings")
//                for ring in rings {
//                    let pointsSet =  NSMutableOrderedSet()
//                    let polygon = NSEntityDescription.insertNewObjectForEntityForName("Polygon", inManagedObjectContext: self.context!) as! Polygon
//
//                    for pointArr in ring {
//                        let point = NSEntityDescription.insertNewObjectForEntityForName("Point", inManagedObjectContext: self.context!) as! Point
//                        point.longitude = pointArr[0]
//                        point.latitude = pointArr[1]
//                        pointsSet.addObject(point)
//                    }
//                    polygon.points = pointsSet
//                    polygon.centroid = centriodPt
//                    polygon.geology = geology
//                    print("Added poly with \(polygon.points!.array.count) shapes and \(polygon.geology!).")
//                    
//
//                }
//                
//            }
//        })
//        finish()
//    }
//}
