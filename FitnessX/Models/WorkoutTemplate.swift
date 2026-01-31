//
//  WorkoutTemplate.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation

/// An exercise within a quick workout template
struct TemplateExercise: Identifiable, Codable, Hashable {
    let id: UUID
    let exerciseId: UUID
    let exerciseName: String
    let sets: Int
    let reps: Int?
    let durationSeconds: Int?
    let restSeconds: Int
    
    init(
        id: UUID = UUID(),
        exerciseId: UUID,
        exerciseName: String,
        sets: Int = 3,
        reps: Int? = nil,
        durationSeconds: Int? = nil,
        restSeconds: Int = 30
    ) {
        self.id = id
        self.exerciseId = exerciseId
        self.exerciseName = exerciseName
        self.sets = sets
        self.reps = reps
        self.durationSeconds = durationSeconds
        self.restSeconds = restSeconds
    }
}

/// A pre-defined quick workout template
struct WorkoutTemplate: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let durationMinutes: Int
    let difficulty: DifficultyLevel
    let type: WorkoutType
    let exercises: [TemplateExercise]
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        durationMinutes: Int,
        difficulty: DifficultyLevel,
        type: WorkoutType,
        exercises: [TemplateExercise]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.durationMinutes = durationMinutes
        self.difficulty = difficulty
        self.type = type
        self.exercises = exercises
    }
    
    var exerciseCount: Int { exercises.count }
    var totalSets: Int { exercises.reduce(0) { $0 + $1.sets } }
}

