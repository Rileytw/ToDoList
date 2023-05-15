//
//  LocationManager.swift
//  ToDoList
//
//  Created by Lei on 2023/5/15.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
}
