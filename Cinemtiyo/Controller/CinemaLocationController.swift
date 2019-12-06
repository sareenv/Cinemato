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
    var userLocation: CLLocationCoordinate2D? {
        didSet {
            self.setMapRegion()
            searchNearByCinemas()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        mapViewSettings()
        detectUserLocation()
        setMapRegion()
        searchNearByCinemas()
    }
    
    func detectUserLocation() {
        manager?.delegate = self
        manager?.desiredAccuracy = .greatestFiniteMagnitude
        manager?.requestAlwaysAuthorization()
        manager?.startUpdatingLocation()
    }
    
    fileprivate func searchNearByCinemas() {
        guard let userLocation = userLocation else { return }
           let request = MKLocalSearch.Request()
           request.naturalLanguageQuery = "Cinema"
           request.region = mapView.region
           let locationSearch = MKLocalSearch(request: request)
           locationSearch.start { (response, error) in
               if let error = error{
                   let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                   self.present(alertController, animated: true, completion: nil)
                   return
               }
               self.mapView.removeAnnotations(self.mapView.annotations)
               
               response?.mapItems.forEach({ (item) in
                   let annotation = MKPointAnnotation()
                   annotation.coordinate = item.placemark.coordinate
                   annotation.title = item.name
                   annotation.subtitle = item.placemark.title
                   self.mapView.addAnnotation(annotation)
               })
               let currentPlaceAnnotation = MKPointAnnotation()
               currentPlaceAnnotation.coordinate = userLocation
               
               self.mapView.addAnnotation(currentPlaceAnnotation)
               self.mapView.showAnnotations(self.mapView.annotations, animated: true)
           }
    }
    
    func setMapRegion() {
        guard let userLocation = userLocation else { return }
        let location = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
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
