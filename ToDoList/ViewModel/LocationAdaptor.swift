//
//  LocationAdaptor.swift
//  ToDoList
//
//  Created by Lei on 2023/7/10.
//

import Foundation

protocol LocationService {
    var location: String { get set }
    func getLocation()
}

class LocationServiceAdaptor: LocationService {
    @Published var location: String = ""
    let locationManager = LocationManager()
    
    init() {
        locationManager.delegate = self
    }

    func getLocation() {
        locationManager.requestLocation()
    }
}

extension LocationServiceAdaptor: LocationDelegate {
    func didGetLocation(location: String) {
        self.location = location
    }
    
    func locationRequestFailed(error: Error) {
        print("Error:\(error.localizedDescription)")
    }
}

extension LocationServiceAdaptor: ObservableObject {}

