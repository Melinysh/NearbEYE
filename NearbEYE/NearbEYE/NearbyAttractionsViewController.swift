//
//  NearbyAttractionsViewController.swift
//  NearbEYE
//
//  Created by Ethan Hardy on 2015-10-25.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import MapKit

class NEAnnotation: NSObject, MKAnnotation {
    private(set) var coordinate : CLLocationCoordinate2D
    var title : String?
    var attraction : AnyObject
    init(coord: CLLocationCoordinate2D, name: String, att: AnyObject) {
        title = name
        coordinate = coord
        attraction = att
    }
}

class NearbyAttractionsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView : MKMapView!
    var nearbyAttractions : [AnyObject]!
    var lastLocation : CLLocationCoordinate2D!
    let minimumDistanceForRefresh = 0.0005
    let mapSpan : MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
    var coreDataComm : CoreDataCommunicator!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
        lastLocation = mapView.userLocation.coordinate
        mapView.setRegion(MKCoordinateRegion(center: lastLocation, span: mapSpan), animated: false)
        nearbyAttractions = [AnyObject]()
    }
    
    override func viewDidAppear(animated: Bool) {
        mapView.setRegion(MKCoordinateRegion(center: lastLocation, span: MKCoordinateSpanMake(0.006, 0.006)), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func updateNearbyAttractions() {
        nearbyAttractions = coreDataComm.all(lastLocation)
        print("Attras \(nearbyAttractions.count)")
        nearbyAttractions = Array(nearbyAttractions.prefix(20))
        for attraction in nearbyAttractions {
            let long = attraction.valueForKey("longitude") as! NSNumber
            let lat = attraction.valueForKey("latitude") as! NSNumber
            let c = CLLocationCoordinate2D(latitude: lat.doubleValue, longitude: long.doubleValue)
            mapView.addAnnotation(NEAnnotation(coord: c, name: attraction.performSelector("selfName").retain().takeRetainedValue() as! String, att: attraction))
        }
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if (lastLocation == nil) {
            lastLocation = userLocation.coordinate
        }
        if (CoreDataCommunicator.dist(lastLocation.latitude, longitude: lastLocation.longitude, userLocaltion: userLocation.coordinate) >= minimumDistanceForRefresh) {
            lastLocation = userLocation.coordinate
            updateNearbyAttractions()
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("attraction") {
            return pinView
        }
        return MKPinAnnotationView(annotation: annotation, reuseIdentifier: "attraction")
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detailVC") as! DetailAttractionViewController
        vc.attraction = (view.annotation as! NEAnnotation).attraction
        vc.userLocation = mapView.userLocation.coordinate
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
