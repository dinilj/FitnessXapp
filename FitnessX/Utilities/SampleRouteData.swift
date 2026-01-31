//
//  SampleRouteData.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation
import CoreLocation

/// Sample GPS route data for workout simulation
struct SampleRouteData {
    
    /// Sample route through a park (approximately 2km loop)
    static let parkRoute: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        CLLocationCoordinate2D(latitude: 37.7752, longitude: -122.4185),
        CLLocationCoordinate2D(latitude: 37.7758, longitude: -122.4178),
        CLLocationCoordinate2D(latitude: 37.7765, longitude: -122.4172),
        CLLocationCoordinate2D(latitude: 37.7772, longitude: -122.4168),
        CLLocationCoordinate2D(latitude: 37.7780, longitude: -122.4165),
        CLLocationCoordinate2D(latitude: 37.7788, longitude: -122.4163),
        CLLocationCoordinate2D(latitude: 37.7795, longitude: -122.4165),
        CLLocationCoordinate2D(latitude: 37.7800, longitude: -122.4170),
        CLLocationCoordinate2D(latitude: 37.7803, longitude: -122.4178),
        CLLocationCoordinate2D(latitude: 37.7805, longitude: -122.4188),
        CLLocationCoordinate2D(latitude: 37.7803, longitude: -122.4198),
        CLLocationCoordinate2D(latitude: 37.7798, longitude: -122.4208),
        CLLocationCoordinate2D(latitude: 37.7790, longitude: -122.4215),
        CLLocationCoordinate2D(latitude: 37.7782, longitude: -122.4218),
        CLLocationCoordinate2D(latitude: 37.7773, longitude: -122.4218),
        CLLocationCoordinate2D(latitude: 37.7765, longitude: -122.4215),
        CLLocationCoordinate2D(latitude: 37.7758, longitude: -122.4210),
        CLLocationCoordinate2D(latitude: 37.7752, longitude: -122.4203),
        CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    ]
    
    /// Convert coordinates to RoutePoints
    static var routePoints: [RoutePoint] {
        parkRoute.map { coord in
            RoutePoint(latitude: coord.latitude, longitude: coord.longitude)
        }
    }
}
