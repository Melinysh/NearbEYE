//
//  ViewController.swift
//  NearbEYE
//
//  Created by Stephen Melinyshyn on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

enum Direction {
	case North, East, South, West
}

let kLatitudeRange = 0.05
let kLongitudeRange = 0.05

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource  {

    let minimumHeadingChangeForRefresh = 60.0
    let minimumDistanceChangeForRefresh = 15.0
    var context : NSManagedObjectContext!
    var locationManager : CLLocationManager!
    var lastHeading : CLHeading!
    var lastLocation : CLLocation!
    var cameraOverlay : CameraOverlayView!
	
	var coreDataComm : CoreDataCommunicator!
	
	var attractionsNearby = [AnyObject]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		coreDataComm = CoreDataCommunicator(c: self.context)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if (status == CLAuthorizationStatus.Denied || status == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestWhenInUseAuthorization()
		} else {
			startHeadingAndLocation()
		}
		
    }
    
    override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
        
        if (cameraOverlay == nil) {
            let cameraView = UIImagePickerController()
            let screenSize = UIScreen.mainScreen().bounds.size
            cameraView.sourceType = UIImagePickerControllerSourceType.Camera
            cameraView.delegate = self
            cameraView.showsCameraControls = false
            cameraView.cameraViewTransform = CGAffineTransformTranslate(CGAffineTransformMakeScale(4.2/3.0, 4.2/3.0), 0, screenSize.height / 10.0)
            
            cameraOverlay = CameraOverlayView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height * 2), vc: self)
            cameraView.cameraOverlayView = cameraOverlay
            
            
            self.presentViewController(cameraView, animated: true, completion: nil)
        }
        
        
        
		// Do any additional setup after loading the view, typically from a nib.
	}
    
    override func viewWillDisappear(animated: Bool) {
        locationManager.stopUpdatingHeading()
        locationManager.stopUpdatingLocation()
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    func presentDetailViewControllerForAttraction(attraction: AnyObject?) {
        //TODO implement this
        stopHeadingAndLocation()
    }
    
    //MARK: - Location Manager Methods
    
    func startHeadingAndLocation() {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
            lastHeading = locationManager.heading
            lastLocation = locationManager.location
            locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopHeadingAndLocation() {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.stopUpdatingHeading()
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print(status.rawValue)
        if (status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            startHeadingAndLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if (lastHeading == nil) {
            lastHeading = newHeading
        }
        else if (fabs(newHeading.magneticHeading - lastHeading.magneticHeading) >= minimumHeadingChangeForRefresh) {
            lastHeading = newHeading
            refreshAttractions()
            print(lastHeading)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if (lastLocation == nil) {
            lastLocation = newLocation
            
        }
        else if (newLocation.distanceFromLocation(lastLocation) >= minimumDistanceChangeForRefresh) {
            lastLocation = newLocation
			
			refreshAttractions()
            print(lastLocation)
        }
    }
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let obj = attractionsNearby[indexPath.row]
        let reuseId = String(obj.dynamicType)
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseId, forIndexPath: indexPath)
        switch (reuseId) {
        case NSStringFromClass(Art.self):
            TableViewCellArt.configureCell(cell as! TableViewCellArt, data: obj as! Art)
            break
        case NSStringFromClass(Park.self):
            TableViewCellParks.configureCell(cell as! TableViewCellParks, data: obj as! Park)
            break
        case NSStringFromClass(Playground.self):
            TableViewCellPlayground.configureCell(cell as! TableViewCellPlayground, data: obj as! Playground)
            break
        case NSStringFromClass(PointOfInterest.self):
            TableViewCellPOI.configureCell(cell as! TableViewCellPOI, data: obj as! PointOfInterest)
            break
        case NSStringFromClass(Rink.self):
            TableViewCellRink.configureCell(cell as! TableViewCellRink, data: obj as! Rink)
            break
        case NSStringFromClass(SportField.self):
            TableViewCellSportField.configureCell(cell as! TableViewCellSportField, data: obj as! SportField)
            break
        case NSStringFromClass(UrbanDesignAward.self):
            TableViewCellUrbanDesign.configureCell(cell as! TableViewCellUrbanDesign, data: obj as! UrbanDesignAward)
            break
        case NSStringFromClass(PlaceOfWorship.self):
            TableViewCellWorship.configureCell(cell as! TableViewCellWorship, data: obj as! PlaceOfWorship)
            break
        default:
            print("Invalid reuseID")
            break
        }
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        presentDetailViewControllerForAttraction(nil)
        //TODO segue to detail vc
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detailVC") as! DetailAttractionViewController
        vc.userLocation = lastLocation.coordinate
		vc.attraction = attractionsNearby[indexPath.row]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractionsNearby.count
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
    }

	func wordify(str :String) -> String {
		var firstword = ""
		var secondword = ""
		var toSecondWord = false
		for ch in str.characters {
			if (ch >= "A" && ch <= "Z") || toSecondWord {
				toSecondWord = true
				secondword += String(ch)
			} else {
				firstword += String(ch)
			}
		}
		return firstword.capitalizedString + " " + secondword.capitalizedString
	}
	
	// MARK: - Attraction Finding Methods
	func refreshAttractions() {
        if (lastHeading == nil || lastLocation == nil) {
            return
        }
		let dir = directionForHeading(lastHeading)
		let latOffset = latitudeOffset(lastLocation.coordinate, dir: dir)
		let longOffset = longitudeOffset(lastLocation.coordinate, dir: dir)
	
		let maxLat = lastLocation.coordinate.latitude + latOffset.0
		let minLat = lastLocation.coordinate.latitude + latOffset.1
		let maxLong = lastLocation.coordinate.longitude + longOffset.0
		let minLong = lastLocation.coordinate.longitude + longOffset.1
		print("\(dir)  Max lat: \(maxLat) min lat: \(minLat) max long: \(maxLong) min long \(minLong)")
		attractionsNearby = coreDataComm.attractionsInRadius(maxLat, minLat: minLat, maxLong: maxLong, minLong: minLong, userLocation: lastLocation.coordinate)
		cameraOverlay.attractionsList.reloadData()
	}
	
	func latitudeOffset(userLocation : CLLocationCoordinate2D, dir :Direction) -> (Double, Double) {
		if (dir == .North || dir == .South) {
			return (kLatitudeRange, -kLatitudeRange)
		}
		if (dir == .East) {
			return (2 * kLatitudeRange, 0)
		} else {
			return (0, 2 * kLatitudeRange)
		}
	}
	
	func longitudeOffset(userLocation : CLLocationCoordinate2D, dir :Direction) -> (Double, Double) {
		if (dir == .East || dir == .West) {
			return (kLongitudeRange, -kLongitudeRange)
		}
		if (dir == .North) {
			return (2 * kLongitudeRange, 0)
		} else {
			return (0, 2 * kLongitudeRange)
		}
	}
	
	
	func directionForHeading(heading : CLHeading) -> Direction {
		if (heading.trueHeading >= 0 && heading.trueHeading < 45) || heading.trueHeading > 315 {
			return Direction.North
		} else if (heading.trueHeading >= 45 && heading.trueHeading < 135){
			return .East
		} else if (heading.trueHeading >= 135 && heading.trueHeading < 225) {
			return .South
		} else {
			return .West
		}
	}
	
}

