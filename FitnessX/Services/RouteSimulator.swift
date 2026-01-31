//
//  RouteSimulator.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation
import CoreLocation
import Combine

/// Simulates movement along a predefined GPS route
@MainActor
class RouteSimulator: ObservableObject {
    
    @Published var currentCoordinate: CLLocationCoordinate2D
    @Published var traversedPoints: [RoutePoint] = []
    @Published var progress: Double = 0
    @Published var isActive: Bool = false
    
    private let routeCoordinates: [CLLocationCoordinate2D]
    private var currentIndex: Int = 0
    private var timer: Timer?
    private let updateInterval: TimeInterval = 0.5
    private var speed: Double = 1.0
    
    init(route: [CLLocationCoordinate2D] = SampleRouteData.parkRoute) {
        self.routeCoordinates = route
        self.currentCoordinate = route.first ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    func start() {
        guard !routeCoordinates.isEmpty else { return }
        
        isActive = true
        currentIndex = 0
        traversedPoints = []
        
        addCurrentPoint()
        startTimer()
    }
    
    func pause() {
        isActive = false
        timer?.invalidate()
        timer = nil
    }
    
    func resume() {
        guard !routeCoordinates.isEmpty else { return }
        isActive = true
        startTimer()
    }
    
    func reset() {
        pause()
        currentIndex = 0
        traversedPoints = []
        progress = 0
        if let first = routeCoordinates.first {
            currentCoordinate = first
        }
    }
    
    func setSpeed(_ newSpeed: Double) {
        speed = max(0.5, min(3.0, newSpeed))
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: updateInterval / speed, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.moveToNextPoint()
            }
        }
    }
    
    private func moveToNextPoint() {
        guard isActive, currentIndex < routeCoordinates.count - 1 else {
            if currentIndex >= routeCoordinates.count - 1 {
                currentIndex = 0
            }
            return
        }
        
        currentIndex += 1
        currentCoordinate = routeCoordinates[currentIndex]
        addCurrentPoint()
        
        progress = Double(currentIndex) / Double(routeCoordinates.count - 1)
    }
    
    private func addCurrentPoint() {
        let point = RoutePoint(
            latitude: currentCoordinate.latitude,
            longitude: currentCoordinate.longitude
        )
        traversedPoints.append(point)
    }
}
