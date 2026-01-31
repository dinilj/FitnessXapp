//
//  WorkoutProgramData.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation

/// Pre-defined structured workout programs
struct WorkoutProgramData {
    
    static var all: [WorkoutProgram] {
        [
            beginnerKickstart,
            strengthBuilder4Week,
            hiitChallenge,
            totalTransformation
        ]
    }
    
    // MARK: - 7-Day Beginner Kickstart
    
    static let beginnerKickstart = WorkoutProgram(
        name: "7-Day Beginner Kickstart",
        description: "Perfect introduction to fitness. Build foundational strength and habits.",
        durationWeeks: 1,
        difficulty: .beginner,
        category: .strength,
        days: [
            ProgramDay(dayNumber: 1, name: "Full Body Intro", description: "Light introduction to basic movements", exercises: [
                ProgramExercise(exerciseId: exerciseId("Squats"), exerciseName: "Squats", sets: 2, reps: 10, restSeconds: 45),
                ProgramExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: 2, reps: 8, restSeconds: 45),
                ProgramExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 2, durationSeconds: 20, restSeconds: 30)
            ]),
            ProgramDay(dayNumber: 2, name: "Active Recovery", description: "Light stretching and mobility", exercises: [
                ProgramExercise(exerciseId: exerciseId("Cat-Cow Stretch"), exerciseName: "Cat-Cow Stretch", sets: 1, durationSeconds: 60, restSeconds: 15),
                ProgramExercise(exerciseId: exerciseId("Downward Dog"), exerciseName: "Downward Dog", sets: 2, durationSeconds: 30, restSeconds: 15)
            ]),
            ProgramDay(dayNumber: 3, name: "Lower Body", description: "Strengthen your legs", exercises: [
                ProgramExercise(exerciseId: exerciseId("Squats"), exerciseName: "Squats", sets: 3, reps: 12, restSeconds: 45),
                ProgramExercise(exerciseId: exerciseId("Lunges"), exerciseName: "Lunges", sets: 2, reps: 10, restSeconds: 45),
                ProgramExercise(exerciseId: exerciseId("Glute Bridges"), exerciseName: "Glute Bridges", sets: 3, reps: 15, restSeconds: 30)
            ]),
            ProgramDay(dayNumber: 4, name: "Rest Day", description: "Complete rest for recovery", isRestDay: true),
            ProgramDay(dayNumber: 5, name: "Upper Body", description: "Build upper body strength", exercises: [
                ProgramExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: 3, reps: 10, restSeconds: 45),
                ProgramExercise(exerciseId: exerciseId("Tricep Dips"), exerciseName: "Tricep Dips", sets: 2, reps: 10, restSeconds: 45),
                ProgramExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 2, durationSeconds: 30, restSeconds: 30)
            ]),
            ProgramDay(dayNumber: 6, name: "Cardio & Core", description: "Elevate heart rate", exercises: [
                ProgramExercise(exerciseId: exerciseId("Jumping Jacks"), exerciseName: "Jumping Jacks", sets: 2, durationSeconds: 45, restSeconds: 30),
                ProgramExercise(exerciseId: exerciseId("High Knees"), exerciseName: "High Knees", sets: 2, durationSeconds: 30, restSeconds: 30),
                ProgramExercise(exerciseId: exerciseId("Mountain Climbers"), exerciseName: "Mountain Climbers", sets: 2, durationSeconds: 30, restSeconds: 30)
            ]),
            ProgramDay(dayNumber: 7, name: "Full Body Finale", description: "Put it all together", exercises: [
                ProgramExercise(exerciseId: exerciseId("Squats"), exerciseName: "Squats", sets: 3, reps: 12, restSeconds: 40),
                ProgramExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: 3, reps: 10, restSeconds: 40),
                ProgramExercise(exerciseId: exerciseId("Lunges"), exerciseName: "Lunges", sets: 2, reps: 12, restSeconds: 40),
                ProgramExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 2, durationSeconds: 30, restSeconds: 30)
            ])
        ]
    )
    
    // MARK: - 4-Week Strength Builder
    
    static let strengthBuilder4Week = WorkoutProgram(
        name: "4-Week Strength Builder",
        description: "Progressive strength training to build muscle over 4 weeks.",
        durationWeeks: 4,
        difficulty: .intermediate,
        category: .strength,
        days: generateStrengthBuilderDays()
    )
    
    // MARK: - 21-Day HIIT Challenge
    
    static let hiitChallenge = WorkoutProgram(
        name: "21-Day HIIT Challenge",
        description: "Intense high-intensity interval training to boost metabolism.",
        durationWeeks: 3,
        difficulty: .advanced,
        category: .hiit,
        days: generateHIITChallengeDays()
    )
    
    // MARK: - 30-Day Total Transformation
    
    static let totalTransformation = WorkoutProgram(
        name: "30-Day Total Transformation",
        description: "Comprehensive program combining strength, cardio, and flexibility.",
        durationWeeks: 4,
        difficulty: .intermediate,
        category: .strength,
        days: generateTotalTransformationDays()
    )
    
    // MARK: - Helper Methods
    
    private static func exerciseId(_ name: String) -> UUID {
        // Return a new UUID to avoid circular static initialization
        UUID()
    }
    
    private static func generateStrengthBuilderDays() -> [ProgramDay] {
        var days: [ProgramDay] = []
        for week in 1...4 {
            let baseReps = 8 + (week * 2)
            let sets = min(3 + (week - 1), 4)
            
            days.append(ProgramDay(dayNumber: (week-1)*7 + 1, name: "Week \(week): Push", description: "Chest, shoulders, triceps", exercises: [
                ProgramExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: sets, reps: baseReps, restSeconds: 45),
                ProgramExercise(exerciseId: exerciseId("Shoulder Press"), exerciseName: "Shoulder Press", sets: sets, reps: baseReps-2, restSeconds: 60),
                ProgramExercise(exerciseId: exerciseId("Tricep Dips"), exerciseName: "Tricep Dips", sets: sets, reps: baseReps, restSeconds: 45)
            ]))
            days.append(ProgramDay(dayNumber: (week-1)*7 + 2, name: "Week \(week): Pull", description: "Back and biceps", exercises: [
                ProgramExercise(exerciseId: exerciseId("Dumbbell Rows"), exerciseName: "Dumbbell Rows", sets: sets, reps: baseReps, restSeconds: 60),
                ProgramExercise(exerciseId: exerciseId("Bicep Curls"), exerciseName: "Bicep Curls", sets: sets, reps: baseReps, restSeconds: 45)
            ]))
            days.append(ProgramDay(dayNumber: (week-1)*7 + 3, name: "Week \(week): Legs", description: "Quads, hamstrings, glutes", exercises: [
                ProgramExercise(exerciseId: exerciseId("Squats"), exerciseName: "Squats", sets: sets, reps: baseReps, restSeconds: 60),
                ProgramExercise(exerciseId: exerciseId("Lunges"), exerciseName: "Lunges", sets: sets, reps: baseReps-2, restSeconds: 60),
                ProgramExercise(exerciseId: exerciseId("Glute Bridges"), exerciseName: "Glute Bridges", sets: sets, reps: baseReps+4, restSeconds: 45)
            ]))
            days.append(ProgramDay(dayNumber: (week-1)*7 + 4, name: "Rest Day", description: "Recovery", isRestDay: true))
            days.append(ProgramDay(dayNumber: (week-1)*7 + 5, name: "Week \(week): Full Body", description: "Total body workout", exercises: [
                ProgramExercise(exerciseId: exerciseId("Squats"), exerciseName: "Squats", sets: 3, reps: baseReps, restSeconds: 45),
                ProgramExercise(exerciseId: exerciseId("Push-ups"), exerciseName: "Push-ups", sets: 3, reps: baseReps, restSeconds: 45),
                ProgramExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 3, durationSeconds: 30+(week*5), restSeconds: 30)
            ]))
            days.append(ProgramDay(dayNumber: (week-1)*7 + 6, name: "Week \(week): Core & Cardio", description: "Abs and conditioning", exercises: [
                ProgramExercise(exerciseId: exerciseId("Mountain Climbers"), exerciseName: "Mountain Climbers", sets: 3, durationSeconds: 30+(week*5), restSeconds: 30),
                ProgramExercise(exerciseId: exerciseId("Plank"), exerciseName: "Plank", sets: 3, durationSeconds: 30+(week*5), restSeconds: 30),
                ProgramExercise(exerciseId: exerciseId("Jumping Jacks"), exerciseName: "Jumping Jacks", sets: 3, durationSeconds: 45, restSeconds: 30)
            ]))
            days.append(ProgramDay(dayNumber: (week-1)*7 + 7, name: "Active Recovery", description: "Light stretching", exercises: [
                ProgramExercise(exerciseId: exerciseId("Downward Dog"), exerciseName: "Downward Dog", sets: 2, durationSeconds: 30, restSeconds: 15),
                ProgramExercise(exerciseId: exerciseId("Cat-Cow Stretch"), exerciseName: "Cat-Cow Stretch", sets: 2, durationSeconds: 30, restSeconds: 15)
            ]))
        }
        return days
    }
    
    private static func generateHIITChallengeDays() -> [ProgramDay] {
        var days: [ProgramDay] = []
        for day in 1...21 {
            if day % 7 == 0 {
                days.append(ProgramDay(dayNumber: day, name: "Rest Day", description: "Complete rest", isRestDay: true))
            } else {
                let intensity = (day / 7) + 1
                days.append(ProgramDay(dayNumber: day, name: "Day \(day): HIIT", description: "High intensity intervals", exercises: [
                    ProgramExercise(exerciseId: exerciseId("Burpees"), exerciseName: "Burpees", sets: 3, reps: 8+intensity, restSeconds: 30),
                    ProgramExercise(exerciseId: exerciseId("Mountain Climbers"), exerciseName: "Mountain Climbers", sets: 3, durationSeconds: 25+(intensity*5), restSeconds: 20),
                    ProgramExercise(exerciseId: exerciseId("Squat Jumps"), exerciseName: "Squat Jumps", sets: 3, reps: 10+intensity, restSeconds: 30),
                    ProgramExercise(exerciseId: exerciseId("High Knees"), exerciseName: "High Knees", sets: 2, durationSeconds: 25+(intensity*5), restSeconds: 20)
                ]))
            }
        }
        return days
    }
    
    private static func generateTotalTransformationDays() -> [ProgramDay] {
        var days: [ProgramDay] = []
        let templates: [(String, String, [(String, Int?, Int?)])] = [
            ("Strength", "Build muscle", [("Push-ups", 12, nil), ("Squats", 15, nil), ("Lunges", 12, nil)]),
            ("HIIT", "Burn fat", [("Burpees", 10, nil), ("Mountain Climbers", nil, 30), ("High Knees", nil, 30)]),
            ("Lower Body", "Legs & glutes", [("Squats", 15, nil), ("Lunges", 12, nil), ("Glute Bridges", 15, nil)]),
            ("Rest", "Recovery", []),
            ("Upper Body", "Chest, back, arms", [("Push-ups", 12, nil), ("Dumbbell Rows", 12, nil), ("Tricep Dips", 12, nil)]),
            ("Cardio", "Conditioning", [("Jumping Jacks", nil, 45), ("High Knees", nil, 30)]),
            ("Yoga", "Flexibility", [("Downward Dog", nil, 30), ("Warrior I", nil, 30), ("Child's Pose", nil, 45)])
        ]
        
        for day in 1...30 {
            let template = templates[(day - 1) % 7]
            let week = (day - 1) / 7 + 1
            
            if template.2.isEmpty {
                days.append(ProgramDay(dayNumber: day, name: "Day \(day): \(template.0)", description: template.1, isRestDay: true))
            } else {
                let exercises: [ProgramExercise] = template.2.map { ex in
                    if let reps = ex.1 {
                        return ProgramExercise(exerciseId: exerciseId(ex.0), exerciseName: ex.0, sets: 2+week, reps: reps+week, restSeconds: 45)
                    } else if let duration = ex.2 {
                        return ProgramExercise(exerciseId: exerciseId(ex.0), exerciseName: ex.0, sets: 2+week, durationSeconds: duration+(week*5), restSeconds: 30)
                    }
                    return ProgramExercise(exerciseId: exerciseId(ex.0), exerciseName: ex.0)
                }
                days.append(ProgramDay(dayNumber: day, name: "Day \(day): \(template.0)", description: "Week \(week) - \(template.1)", exercises: exercises))
            }
        }
        return days
    }
    
    static func programs(for difficulty: DifficultyLevel) -> [WorkoutProgram] {
        all.filter { $0.difficulty == difficulty }
    }
    
    static func programs(for category: WorkoutType) -> [WorkoutProgram] {
        all.filter { $0.category == category }
    }
}
