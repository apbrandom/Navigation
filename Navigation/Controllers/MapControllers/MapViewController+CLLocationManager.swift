//
//  MapViewController+CLLocationManager.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 30.07.2023.
//

import UIKit
import CoreLocation
import MapKit

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Обработайте ошибку здесь
        print("Failed to get user's location: \(error)")
    }
}
