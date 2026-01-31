//
//  WorkoutType.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// Categories of workout activities
enum WorkoutType: String, Codable, CaseIterable, Identifiable, Hashable {
    case running
    case walking
    case cycling
    case strength
    case hiit
    case yoga
    case swimming
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .running: return "Running"
        case .walking: return "Walking"
        case .cycling: return "Cycling"
        case .strength: return "Strength"
        case .hiit: return "HIIT"
        case .yoga: return "Yoga"
        case .swimming: return "Swimming"
        }
    }
    
    var iconName: String {
        switch self {
        case .running: return "figure.run"
        case .walking: return "figure.walk"
        case .cycling: return "figure.outdoor.cycle"
        case .strength: return "dumbbell.fill"
        case .hiit: return "flame.fill"
        case .yoga: return "figure.yoga"
        case .swimming: return "figure.pool.swim"
        }
    }
    
    var themeColor: Color {
        switch self {
        case .running: return .orange
        case .walking: return .green
        case .cycling: return .blue
        case .strength: return .red
        case .hiit: return .pink
        case .yoga: return .purple
        case .swimming: return .cyan
        }
    }
    
    var gradientColors: [Color] {
        switch self {
        case .running: return [.orange, .red]
        case .walking: return [.green, .mint]
        case .cycling: return [.blue, .cyan]
        case .strength: return [.red, .pink]
        case .hiit: return [.pink, .orange]
        case .yoga: return [.purple, .indigo]
        case .swimming: return [.cyan, .blue]
        }
    }
    
    var description: String {
        switch self {
        case .running: return "Track your outdoor runs with GPS"
        case .walking: return "Log your walks and steps"
        case .cycling: return "Monitor your cycling routes"
        case .strength: return "Build muscle with weight training"
        case .hiit: return "High intensity interval training"
        case .yoga: return "Flexibility and mindfulness"
        case .swimming: return "Track your pool sessions"
        }
    }
    
    var usesGPS: Bool {
        switch self {
        case .running, .walking, .cycling, .swimming: return true
        case .strength, .hiit, .yoga: return false
        }
    }
    
    var isExerciseBased: Bool {
        switch self {
        case .strength, .hiit, .yoga: return true
        case .running, .walking, .cycling, .swimming: return false
        }
    }
}

// MARK: - Muscle Groups

enum MuscleGroup: String, Codable, CaseIterable, Identifiable, Hashable {
    case chest, back, shoulders, arms, core, legs, glutes, fullBody, cardio
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .chest: return "Chest"
        case .back: return "Back"
        case .shoulders: return "Shoulders"
        case .arms: return "Arms"
        case .core: return "Core"
        case .legs: return "Legs"
        case .glutes: return "Glutes"
        case .fullBody: return "Full Body"
        case .cardio: return "Cardio"
        }
    }
    
    var iconName: String {
        switch self {
        case .chest: return "figure.arms.open"
        case .back: return "figure.stand"
        case .shoulders: return "figure.boxing"
        case .arms: return "figure.strengthtraining.traditional"
        case .core: return "figure.core.training"
        case .legs: return "figure.run"
        case .glutes: return "figure.walk"
        case .fullBody: return "figure.mixed.cardio"
        case .cardio: return "heart.fill"
        }
    }
}

// MARK: - Difficulty Level

enum DifficultyLevel: String, Codable, CaseIterable, Identifiable, Hashable {
    case beginner, intermediate, advanced
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .beginner: return "Beginner"
        case .intermediate: return "Intermediate"
        case .advanced: return "Advanced"
        }
    }
    
    var color: Color {
        switch self {
        case .beginner: return .green
        case .intermediate: return .orange
        case .advanced: return .red
        }
    }
}

// MARK: - Equipment

enum Equipment: String, Codable, CaseIterable, Identifiable, Hashable {
    case none, dumbbells, barbell, kettlebell, resistanceBand, pullUpBar, bench, yogaMat, jumpRope
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .none: return "No Equipment"
        case .dumbbells: return "Dumbbells"
        case .barbell: return "Barbell"
        case .kettlebell: return "Kettlebell"
        case .resistanceBand: return "Resistance Band"
        case .pullUpBar: return "Pull-up Bar"
        case .bench: return "Bench"
        case .yogaMat: return "Yoga Mat"
        case .jumpRope: return "Jump Rope"
        }
    }
}
