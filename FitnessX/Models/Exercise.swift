//
//  Exercise.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation

/// Category of exercises
enum ExerciseCategory: String, Codable, CaseIterable, Identifiable, Hashable {
    case strength, cardio, flexibility, plyometric
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .strength: return "Strength"
        case .cardio: return "Cardio"
        case .flexibility: return "Flexibility"
        case .plyometric: return "Plyometric"
        }
    }
    
    var iconName: String {
        switch self {
        case .strength: return "dumbbell.fill"
        case .cardio: return "heart.fill"
        case .flexibility: return "figure.yoga"
        case .plyometric: return "figure.jumprope"
        }
    }
}

/// Represents an individual exercise
struct Exercise: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let instructions: [String]
    let muscleGroups: [MuscleGroup]
    let difficulty: DifficultyLevel
    let equipment: [Equipment]
    let category: ExerciseCategory
    let durationSeconds: Int?
    let defaultReps: Int?
    let caloriesPerMinute: Double
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        instructions: [String],
        muscleGroups: [MuscleGroup],
        difficulty: DifficultyLevel,
        equipment: [Equipment] = [.none],
        category: ExerciseCategory,
        durationSeconds: Int? = nil,
        defaultReps: Int? = nil,
        caloriesPerMinute: Double = 5.0
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.instructions = instructions
        self.muscleGroups = muscleGroups
        self.difficulty = difficulty
        self.equipment = equipment
        self.category = category
        self.durationSeconds = durationSeconds
        self.defaultReps = defaultReps
        self.caloriesPerMinute = caloriesPerMinute
    }
    
    var isTimeBased: Bool { durationSeconds != nil }
    var isRepBased: Bool { defaultReps != nil }
    var primaryMuscle: MuscleGroup { muscleGroups.first ?? .fullBody }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
