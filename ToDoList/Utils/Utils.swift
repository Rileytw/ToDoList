//
//  Utils.swift
//  ToDoList
//
//  Created by Lei on 2023/5/16.
//

import Foundation
import CoreLocation

class Utils {
    static func getDefaultLocationString(location: CLLocationCoordinate2D?) -> String {
        guard let location = location else { return "" }
        
        let latitudeString = String(location.latitude)
        let longitudeString = String(location.longitude)
        let locationString = latitudeString + "," + longitudeString
        return locationString
    }
    
    static func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
