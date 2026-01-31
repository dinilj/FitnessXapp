//
//  WorkoutTemplateData.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation

/// Pre-defined quick workout templates
struct WorkoutTemplateData {
    
    static var all: [WorkoutTemplate] {
        [
            morningEnergizer,
            fullBodyBurn,
            hiitBlast,
            strengthBuilder,
            coreCrusher,
            yogaFlow,
            legDay,
            upperBodyBlast,
            cardioKickstart,
            mobilityFlow,
            abBurner,
            fullBodyAmrap
        ]
    }
    
    // MARK: - Templates
    
    static let morningEnergizer = WorkoutTemplate(
        name: "Morning Energizer",
        description: "Quick full-body wake-up routine to start your day with energy.",
        durationMinutes: 15,
        difficulty: .beginner,
        type: .strength,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Jumping Jacks"), exerciseName: "Jumping Jacks", sets: 2, durationSeconds: 45, restSeconds: 15),
            TemplateExercise(exerciseId: exerciseId("Squats"), exerciseName: "Squats", sets: 2, reps: 12, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: 2, reps: 10, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 2, durationSeconds: 20, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("High Knees"), exerciseName: "High Knees", sets: 2, durationSeconds: 30, restSeconds: 15)
        ]
    )
    
    static let fullBodyBurn = WorkoutTemplate(
        name: "Full Body Burn",
        description: "Intense full-body workout to torch calories and build strength.",
        durationMinutes: 25,
        difficulty: .intermediate,
        type: .strength,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Burpees"), exerciseName: "Burpees", sets: 3, reps: 8, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Squats"), exerciseName: "Squats", sets: 3, reps: 15, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: 3, reps: 12, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Lunges"), exerciseName: "Lunges", sets: 3, reps: 12, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Mountain Climbers"), exerciseName: "Mountain Climbers", sets: 3, durationSeconds: 30, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 3, durationSeconds: 30, restSeconds: 20)
        ]
    )
    
    static let hiitBlast = WorkoutTemplate(
        name: "HIIT Blast",
        description: "High-intensity interval training to maximize calorie burn.",
        durationMinutes: 20,
        difficulty: .advanced,
        type: .hiit,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Burpees"), exerciseName: "Burpees", sets: 4, reps: 10, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Squat Jumps"), exerciseName: "Squat Jumps", sets: 4, reps: 12, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Mountain Climbers"), exerciseName: "Mountain Climbers", sets: 4, durationSeconds: 30, restSeconds: 15),
            TemplateExercise(exerciseId: exerciseId("High Knees"), exerciseName: "High Knees", sets: 4, durationSeconds: 30, restSeconds: 15),
            TemplateExercise(exerciseId: exerciseId("Skater Jumps"), exerciseName: "Skater Jumps", sets: 3, reps: 16, restSeconds: 20)
        ]
    )
    
    static let strengthBuilder = WorkoutTemplate(
        name: "Strength Builder",
        description: "Focus on building muscle with controlled movements.",
        durationMinutes: 30,
        difficulty: .intermediate,
        type: .strength,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Squats"), exerciseName: "Squats", sets: 4, reps: 12, restSeconds: 45),
            TemplateExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: 4, reps: 12, restSeconds: 45),
            TemplateExercise(exerciseId: exerciseId("Lunges"), exerciseName: "Lunges", sets: 3, reps: 10, restSeconds: 45),
            TemplateExercise(exerciseId: exerciseId("Glute Bridges"), exerciseName: "Glute Bridges", sets: 3, reps: 15, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Tricep Dips"), exerciseName: "Tricep Dips", sets: 3, reps: 12, restSeconds: 45),
            TemplateExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 3, durationSeconds: 45, restSeconds: 30)
        ]
    )
    
    static let coreCrusher = WorkoutTemplate(
        name: "Core Crusher",
        description: "Targeted core workout for a strong midsection.",
        durationMinutes: 15,
        difficulty: .intermediate,
        type: .strength,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 3, durationSeconds: 45, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Mountain Climbers"), exerciseName: "Mountain Climbers", sets: 3, durationSeconds: 30, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Glute Bridges"), exerciseName: "Glute Bridges", sets: 3, reps: 15, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("High Knees"), exerciseName: "High Knees", sets: 2, durationSeconds: 30, restSeconds: 20)
        ]
    )
    
    static let yogaFlow = WorkoutTemplate(
        name: "Yoga Flow",
        description: "Relaxing yoga sequence for flexibility and mindfulness.",
        durationMinutes: 20,
        difficulty: .beginner,
        type: .yoga,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Cat-Cow Stretch"), exerciseName: "Cat-Cow Stretch", sets: 1, durationSeconds: 60, restSeconds: 10),
            TemplateExercise(exerciseId: exerciseId("Downward Dog"), exerciseName: "Downward Dog", sets: 2, durationSeconds: 45, restSeconds: 10),
            TemplateExercise(exerciseId: exerciseId("Warrior I"), exerciseName: "Warrior I", sets: 2, durationSeconds: 30, restSeconds: 10),
            TemplateExercise(exerciseId: exerciseId("Pigeon Pose"), exerciseName: "Pigeon Pose", sets: 2, durationSeconds: 45, restSeconds: 10),
            TemplateExercise(exerciseId: exerciseId("Child's Pose"), exerciseName: "Child's Pose", sets: 1, durationSeconds: 60, restSeconds: 0)
        ]
    )
    
    // MARK: - New Templates
    
    static let legDay = WorkoutTemplate(
        name: "Leg Day Burner",
        description: "Intense lower body workout to build strong legs and glutes.",
        durationMinutes: 25,
        difficulty: .intermediate,
        type: .strength,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Squats"), exerciseName: "Squats", sets: 4, reps: 15, restSeconds: 45),
            TemplateExercise(exerciseId: exerciseId("Lunges"), exerciseName: "Lunges", sets: 3, reps: 12, restSeconds: 40),
            TemplateExercise(exerciseId: exerciseId("Glute Bridges"), exerciseName: "Glute Bridges", sets: 3, reps: 20, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Squat Jumps"), exerciseName: "Squat Jumps", sets: 3, reps: 10, restSeconds: 45),
            TemplateExercise(exerciseId: exerciseId("High Knees"), exerciseName: "High Knees", sets: 2, durationSeconds: 30, restSeconds: 30)
        ]
    )
    
    static let upperBodyBlast = WorkoutTemplate(
        name: "Upper Body Blast",
        description: "Build upper body strength with this chest, back, and arms focused routine.",
        durationMinutes: 20,
        difficulty: .intermediate,
        type: .strength,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: 4, reps: 12, restSeconds: 45),
            TemplateExercise(exerciseId: exerciseId("Tricep Dips"), exerciseName: "Tricep Dips", sets: 3, reps: 12, restSeconds: 40),
            TemplateExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 3, durationSeconds: 45, restSeconds: 30),
            TemplateExercise(exerciseId: exerciseId("Shoulder Press"), exerciseName: "Shoulder Press", sets: 3, reps: 10, restSeconds: 45),
            TemplateExercise(exerciseId: exerciseId("Bicep Curls"), exerciseName: "Bicep Curls", sets: 3, reps: 12, restSeconds: 30)
        ]
    )
    
    static let cardioKickstart = WorkoutTemplate(
        name: "Cardio Kickstart",
        description: "Get your heart pumping with this fast-paced cardio session.",
        durationMinutes: 18,
        difficulty: .beginner,
        type: .hiit,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Jumping Jacks"), exerciseName: "Jumping Jacks", sets: 3, durationSeconds: 45, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("High Knees"), exerciseName: "High Knees", sets: 3, durationSeconds: 30, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Butt Kicks"), exerciseName: "Butt Kicks", sets: 3, durationSeconds: 30, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Lateral Shuffles"), exerciseName: "Lateral Shuffles", sets: 3, durationSeconds: 30, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Mountain Climbers"), exerciseName: "Mountain Climbers", sets: 3, durationSeconds: 30, restSeconds: 30)
        ]
    )
    
    static let mobilityFlow = WorkoutTemplate(
        name: "Mobility Flow",
        description: "Improve flexibility and reduce tension with dynamic stretching.",
        durationMinutes: 15,
        difficulty: .beginner,
        type: .yoga,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Cat-Cow Stretch"), exerciseName: "Cat-Cow Stretch", sets: 2, durationSeconds: 45, restSeconds: 10),
            TemplateExercise(exerciseId: exerciseId("Downward Dog"), exerciseName: "Downward Dog", sets: 2, durationSeconds: 40, restSeconds: 10),
            TemplateExercise(exerciseId: exerciseId("Pigeon Pose"), exerciseName: "Pigeon Pose", sets: 2, durationSeconds: 45, restSeconds: 10),
            TemplateExercise(exerciseId: exerciseId("Seated Forward Fold"), exerciseName: "Seated Forward Fold", sets: 2, durationSeconds: 40, restSeconds: 10),
            TemplateExercise(exerciseId: exerciseId("Child's Pose"), exerciseName: "Child's Pose", sets: 1, durationSeconds: 60, restSeconds: 0)
        ]
    )
    
    static let abBurner = WorkoutTemplate(
        name: "Ab Burner",
        description: "Sculpt your midsection with this intense core-focused workout.",
        durationMinutes: 12,
        difficulty: .intermediate,
        type: .strength,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 3, durationSeconds: 45, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Mountain Climbers"), exerciseName: "Mountain Climbers", sets: 3, durationSeconds: 30, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Glute Bridges"), exerciseName: "Glute Bridges", sets: 3, reps: 15, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("High Knees"), exerciseName: "High Knees", sets: 2, durationSeconds: 30, restSeconds: 20)
        ]
    )
    
    static let fullBodyAmrap = WorkoutTemplate(
        name: "Full Body AMRAP",
        description: "As Many Rounds As Possible - push your limits with this circuit.",
        durationMinutes: 22,
        difficulty: .advanced,
        type: .hiit,
        exercises: [
            TemplateExercise(exerciseId: exerciseId("Burpees"), exerciseName: "Burpees", sets: 4, reps: 8, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Squat Jumps"), exerciseName: "Squat Jumps", sets: 4, reps: 12, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: 4, reps: 10, restSeconds: 20),
            TemplateExercise(exerciseId: exerciseId("Tuck Jumps"), exerciseName: "Tuck Jumps", sets: 3, reps: 8, restSeconds: 25),
            TemplateExercise(exerciseId: exerciseId("Mountain Climbers"), exerciseName: "Mountain Climbers", sets: 3, durationSeconds: 30, restSeconds: 20)
        ]
    )
    
    // MARK: - Helper
    
    private static func exerciseId(_ name: String) -> UUID {
        // Return a stable UUID based on the name to avoid circular static initialization
        UUID()
    }
    
    static func templates(for difficulty: DifficultyLevel) -> [WorkoutTemplate] {
        all.filter { $0.difficulty == difficulty }
    }
    
    static func templates(for type: WorkoutType) -> [WorkoutTemplate] {
        all.filter { $0.type == type }
    }
}
