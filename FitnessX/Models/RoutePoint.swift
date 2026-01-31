//
//  RoutePoint.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation
import CoreLocation

/// Represents a single GPS coordinate point along a workout route
struct RoutePoint: Identifiable, Codable, Equatable {
    let id: UUID
    let latitude: Double
    let longitude: Double
    let timestamp: Date
    
    init(id: UUID = UUID(), latitude: Double, longitude: Double, timestamp: Date = Date()) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
    }
    
    /// Convert to CLLocationCoordinate2D for MapKit
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    /// Calculate distance to another route point in meters
    func distance(to other: RoutePoint) -> Double {
        let location1 = CLLocation(latitude: latitude, longitude: longitude)
        let location2 = CLLocation(latitude: other.latitude, longitude: other.longitude)
        return location1.distance(from: location2)
    }
}
