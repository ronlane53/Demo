//
//  DetailViewController.swift
//  DroneStrike
//
//  Created by Ron Lane on 7/24/16.
//  Copyright © 2016 Ron Lane. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Private
    private func createMapPins() {
        for strike in strikes {
            guard strike.latitude  != nil else { break }
            guard strike.latitude  != ""  else { break }
            guard strike.longitude != nil else { break }
            guard strike.longitude != ""  else { break }
            let  lat: CLLocationDegrees = Double(strike.latitude!)!
            let long: CLLocationDegrees = Double(strike.longitude!)!
            let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let  latDelta: CLLocationDegrees = 8.0
            let longDelta: CLLocationDegrees = 8.0
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            
            let region = MKCoordinateRegion(center: coord, span: span)
            
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.title      = strike.town
            annotation.subtitle   = strike.target
            annotation.coordinate = coord
            
            mapView.addAnnotation(annotation)
        }
    }

    // MARK: - Gesture
    @IBAction func scaleImage(sender: UIPinchGestureRecognizer) {
        mapView.transform = CGAffineTransformScale(mapView.transform, sender.scale, sender.scale)
        sender.scale = 1
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createMapPins()
    }
}
