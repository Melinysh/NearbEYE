//
//  NearbyAttractionsViewController.swift
//  NearbEYE
//
//  Created by Ethan Hardy on 2015-10-25.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import MapKit

class NearbyAttractionsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView : MKMapView!
    var nearbyAttractions : [AnyObject]!
    var lastLocation : CLLocationCoordinate2D!
    let minimumDistanceForRefresh = 0.0005

    override func viewDidLoad() {
        super.viewDidLoad()
        lastLocation = mapView.userLocation.coordinate
        mapView.setRegion(MKCoordinateRegion(center: lastLocation, span: MKCoordinateSpanMake(0.03, 0.03)), animated: false)
        nearbyAttractions = [AnyObject]()
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateNearbyAttractions() {
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if (CoreDataCommunicator.dist(lastLocation.latitude, longitude: lastLocation.longitude, userLocaltion: userLocation.coordinate) >= minimumDistanceForRefresh) {
            lastLocation = userLocation.coordinate
            updateNearbyAttractions()
        }
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
