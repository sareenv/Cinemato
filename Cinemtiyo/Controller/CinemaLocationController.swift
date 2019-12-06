//
//  CinemaLocationController.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 05/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit
import MapKit

class CinemaLocationController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var manager: CLLocationManager?
    var userLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        mapViewSettings()
        detectUserLocation()
    }
    
    func detectUserLocation() {
        manager?.delegate = self
        manager?.desiredAccuracy = .greatestFiniteMagnitude
        manager?.requestAlwaysAuthorization()
        manager?.startUpdatingLocation()
    }
    
    fileprivate func mapViewSettings() {
        mapView.delegate = self
    }
}

extension CinemaLocationController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLatitude = locations.last?.coordinate
        guard currentLatitude != nil else { return }
        userLocation = currentLatitude
        manager.stopUpdatingLocation()
       }
}
