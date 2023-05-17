//
//  LocationManager.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import Foundation
import CoreLocation

protocol LocationDelegate: AnyObject {
    func didGetLocation(location: String)
    func locationRequestFailed(error: Error)
}

class LocationManager: NSObject, ObservableObject {
    private var locationManager = CLLocationManager()
    weak var delegate: LocationDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationString = Utils.getDefaultLocationString(location: locations.first?.coordinate)
        delegate?.didGetLocation(location: locationString)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationRequestFailed(error: error)
    }

}
