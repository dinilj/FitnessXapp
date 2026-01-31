//
//  WorkoutViewModel.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

/// Central view model managing workout state and simulation
@MainActor
class WorkoutViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var currentWorkout: Workout?
    @Published var lastWorkout: Workout?
    @Published var workoutStatus: WorkoutStatus = .idle
    @Published var elapsedTime: TimeInterval = 0
    @Published var currentDistance: Double = 0
    @Published var moments: [Moment] = []
    @Published var routeSimulator: RouteSimulator
    @Published var showPhotoPicker: Bool = false
    @Published var selectedImage: UIImage?
    
    // MARK: - Private Properties
    
    private var timerCancellable: AnyCancellable?
    private var routeObserverCancellable: AnyCancellable?
    private var workoutStartTime: Date?
    private var pausedTime: TimeInterval = 0
    private var lastPauseTime: Date?
    
    // MARK: - Initialization
    
    init() {
        self.routeSimulator = RouteSimulator()
        setupRouteObserver()
    }
    
    // MARK: - Public Methods
    
    func startWorkout() {
        routeSimulator.reset()
        
        let workout = Workout(
            startTime: Date(),
            routePoints: [],
            moments: [],
            status: .active
        )
        
        currentWorkout = workout
        workoutStatus = .active
        workoutStartTime = Date()
        elapsedTime = 0
        pausedTime = 0
        currentDistance = 0
        moments = []
        
        routeSimulator.start()
        startTimer()
    }
    
    func pauseWorkout() {
        guard workoutStatus == .active else { return }
        
        workoutStatus = .paused
        lastPauseTime = Date()
        routeSimulator.pause()
        stopTimer()
    }
    
    func resumeWorkout() {
        guard workoutStatus == .paused else { return }
        
        if let pauseStart = lastPauseTime {
            pausedTime += Date().timeIntervalSince(pauseStart)
        }
        
        workoutStatus = .active
        lastPauseTime = nil
        routeSimulator.resume()
        startTimer()
    }
    
    func endWorkout() {
        guard workoutStatus == .active || workoutStatus == .paused else { return }
        
        stopTimer()
        routeSimulator.pause()
        workoutStatus = .completed
        
        if var workout = currentWorkout {
            workout.endTime = Date()
            workout.status = .completed
            workout.routePoints = routeSimulator.traversedPoints
            workout.moments = moments
            
            lastWorkout = workout
            currentWorkout = nil
        }
        
        workoutStatus = .idle
    }
    
    func addMoment(with image: UIImage) {
        let currentCoord = routeSimulator.currentCoordinate
        
        let imageName = "moment_\(UUID().uuidString).jpg"
        if let data = image.jpegData(compressionQuality: 0.8) {
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let imagePath = documentsPath.appendingPathComponent(imageName)
            try? data.write(to: imagePath)
        }
        
        let moment = Moment(
            timestamp: Date(),
            coordinate: currentCoord,
            mediaType: .photo,
            imageName: imageName
        )
        
        moments.append(moment)
        currentWorkout?.moments = moments
    }
    
    func toggleWorkout() {
        switch workoutStatus {
        case .idle:
            startWorkout()
        case .active:
            pauseWorkout()
        case .paused:
            resumeWorkout()
        case .completed:
            startWorkout()
        }
    }
    
    var hasCompletedWorkout: Bool {
        return lastWorkout != nil
    }
    
    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var formattedDistance: String {
        if currentDistance >= 1000 {
            return String(format: "%.2f km", currentDistance / 1000)
        } else {
            return String(format: "%.0f m", currentDistance)
        }
    }
    
    var formattedPace: String {
        guard currentDistance > 0 && elapsedTime > 0 else { return "--:-- /km" }
        
        let kilometers = currentDistance / 1000
        let minutes = elapsedTime / 60
        let pace = minutes / kilometers
        
        let paceMinutes = Int(pace)
        let paceSeconds = Int((pace - Double(paceMinutes)) * 60)
        
        return String(format: "%d:%02d /km", paceMinutes, paceSeconds)
    }
    
    // MARK: - Private Methods
    
    private func startTimer() {
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateElapsedTime()
            }
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    private func updateElapsedTime() {
        guard let startTime = workoutStartTime, workoutStatus == .active else { return }
        elapsedTime = Date().timeIntervalSince(startTime) - pausedTime
    }
    
    private func setupRouteObserver() {
        routeObserverCancellable = routeSimulator.$currentCoordinate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                let points = self.routeSimulator.traversedPoints
                guard points.count > 1 else {
                    self.currentDistance = 0
                    return
                }
                var total: Double = 0
                for i in 1..<points.count {
                    let prev = CLLocation(latitude: points[i-1].latitude, longitude: points[i-1].longitude)
                    let curr = CLLocation(latitude: points[i].latitude, longitude: points[i].longitude)
                    total += curr.distance(from: prev)
                }
                self.currentDistance = total
            }
    }
}
