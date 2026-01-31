//
//  Workout.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation

/// Represents the current state of a workout session
enum WorkoutStatus: String, Codable, CaseIterable {
    case idle      // Not started
    case active    // Currently in progress
    case paused    // Temporarily paused
    case completed // Finished
}

/// Represents a complete workout session
struct Workout: Identifiable, Codable {
    let id: UUID
    var startTime: Date
    var endTime: Date?
    var routePoints: [RoutePoint]
    var moments: [Moment]
    var status: WorkoutStatus
    var workoutType: WorkoutType?
    
    /// Total distance traveled in meters
    var totalDistance: Double {
        guard routePoints.count > 1 else { return 0 }
        var distance: Double = 0
        for i in 1..<routePoints.count {
            distance += routePoints[i-1].distance(to: routePoints[i])
        }
        return distance
    }
    
    /// Formatted distance string
    var formattedDistance: String {
        if totalDistance >= 1000 {
            return String(format: "%.2f km", totalDistance / 1000)
        } else {
            return String(format: "%.0f m", totalDistance)
        }
    }
    
    /// Duration of the workout in seconds
    var duration: TimeInterval {
        guard let end = endTime else {
            return Date().timeIntervalSince(startTime)
        }
        return end.timeIntervalSince(startTime)
    }
    
    /// Formatted duration string
    var formattedDuration: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    /// Average pace in minutes per kilometer
    var averagePace: Double? {
        guard totalDistance > 0 else { return nil }
        let kilometers = totalDistance / 1000
        let minutes = duration / 60
        return minutes / kilometers
    }
    
    /// Formatted pace string
    var formattedPace: String {
        guard let pace = averagePace else { return "--:-- /km" }
        let minutes = Int(pace)
        let seconds = Int((pace - Double(minutes)) * 60)
        return String(format: "%d:%02d /km", minutes, seconds)
    }
    
    init(
        id: UUID = UUID(),
        startTime: Date = Date(),
        endTime: Date? = nil,
        routePoints: [RoutePoint] = [],
        moments: [Moment] = [],
        status: WorkoutStatus = .idle,
        workoutType: WorkoutType? = nil
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.routePoints = routePoints
        self.moments = moments
        self.status = status
        self.workoutType = workoutType
    }
}
