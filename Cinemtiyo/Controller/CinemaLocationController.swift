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
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    var manager: CLLocationManager? {
        didSet {
            detectUserLocation()
        }
    }
    var userLocation: CLLocationCoordinate2D? {
        didSet {
            self.setMapRegion()
            searchNearByCinemas()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.title = "Local Cinema"
    }
    
    fileprivate func setupMapView() {
        self.view.addSubview(mapView)
        mapView.fillSuperView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        self.manager = CLLocationManager()
        mapViewSettings()
        detectUserLocation()
        setMapRegion()
        
    }
    
    func detectUserLocation() {
        guard let manager = manager else {
            print("Manager is not initialised")
            return
        }
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    fileprivate func searchNearByCinemas() {
        if let userLocation = userLocation {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "Movie Cinema"
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
        } else {
            print("User location is not detected !")
        }
    }
    
    func setMapRegion() {
        guard let userLocation = userLocation else { return }
        let location = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        manager?.stopUpdatingLocation()
    }
    
    fileprivate func mapViewSettings() {
        mapView.delegate = self
    }
}

extension CinemaLocationController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error is \(error)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .denied) {
            let alertController = UIAlertController(title: "Denied Access to the location", message: "App requires location to show nearby cinema", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else if(status == .authorizedAlways) {
            print("Authorised to update the location")
        } else if(status == .authorizedWhenInUse) {
            print("Only can be used when in the usage")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let currentLatitude = locations.last?.coordinate
            guard currentLatitude != nil else { return }
            userLocation = CLLocationCoordinate2D(latitude: 45.491614998694025, longitude: -73.58474995347673)
            searchNearByCinemas()
       }
 

    func openMapsAppWithDirections(to coordinate: CLLocationCoordinate2D, destinationName name: String) {
          let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
          let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
          let mapItem = MKMapItem(placemark: placemark)
          mapItem.name = name // Provide the name of the destination in the To: field
          mapItem.openInMaps(launchOptions: options)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let desiredLocation = view.annotation?.coordinate
        guard let userLocation = userLocation else { return }
        openMapsAppWithDirections(to: desiredLocation ?? userLocation, destinationName: (view.annotation?.title ?? "") ?? "")
    }
}

extension CinemaLocationController{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
        annotationView.pinTintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        annotationView.canShowCallout = true
        let btn = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = btn
        return annotationView
    }
}
