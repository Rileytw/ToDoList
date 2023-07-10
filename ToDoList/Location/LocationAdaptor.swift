//
//  LocationAdaptor.swift
//  ToDoList
//
//  Created by Lei on 2023/7/10.
//

import Foundation

protocol LocationService {
    var location: String { get set }
    var isError: Bool { get set }
    var errorMessage: String? { get set }
    func getLocation()
}

class LocationServiceAdaptor: LocationService {
    @Published var location: String = ""
    @Published var isError: Bool = false
    @Published var errorMessage: String?
    
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
        self.isError = true
        self.errorMessage = AlertMessage.getLocationFailed.message + "\n \(error.localizedDescription)"
    }
}

extension LocationServiceAdaptor: ObservableObject {}

