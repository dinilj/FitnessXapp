//
//  WorkoutProgram.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation

/// An exercise within a program day
struct ProgramExercise: Identifiable, Codable, Hashable {
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
        restSeconds: Int = 45
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

/// A single day within a workout program
struct ProgramDay: Identifiable, Codable, Hashable {
    let id: UUID
    let dayNumber: Int
    let name: String
    let description: String
    let exercises: [ProgramExercise]
    let isRestDay: Bool
    
    init(
        id: UUID = UUID(),
        dayNumber: Int,
        name: String,
        description: String = "",
        exercises: [ProgramExercise] = [],
        isRestDay: Bool = false
    ) {
        self.id = id
        self.dayNumber = dayNumber
        self.name = name
        self.description = description
        self.exercises = exercises
        self.isRestDay = isRestDay
    }
    
    var estimatedDuration: Int {
        exercises.reduce(0) { total, exercise in
            let exerciseTime = (exercise.durationSeconds ?? 30) * exercise.sets
            let restTime = exercise.restSeconds * (exercise.sets - 1)
            return total + exerciseTime + restTime
        }
    }
}

/// A complete workout program
struct WorkoutProgram: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let durationWeeks: Int
    let difficulty: DifficultyLevel
    let category: WorkoutType
    let days: [ProgramDay]
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        durationWeeks: Int,
        difficulty: DifficultyLevel,
        category: WorkoutType,
        days: [ProgramDay]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.durationWeeks = durationWeeks
        self.difficulty = difficulty
        self.category = category
        self.days = days
    }
    
    var totalDays: Int { days.count }
    var workoutDays: Int { days.filter { !$0.isRestDay }.count }
}
