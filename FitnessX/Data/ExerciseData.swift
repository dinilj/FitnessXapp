//
//  ExerciseData.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation

/// Static library of pre-defined exercises
struct ExerciseData {
    
    static var all: [Exercise] { strength + cardio + flexibility + plyometric }
    
    // MARK: - Strength Exercises
    
    static let strength: [Exercise] = [
        Exercise(
            name: "Push-ups",
            description: "Classic upper body exercise targeting chest, shoulders, and triceps.",
            instructions: ["Start in a plank position", "Lower your body until chest nearly touches floor", "Push back up to starting position", "Keep core engaged throughout"],
            muscleGroups: [.chest, .shoulders, .arms],
            difficulty: .beginner,
            category: .strength,
            defaultReps: 12,
            caloriesPerMinute: 7.0
        ),
        Exercise(
            name: "Squats",
            description: "Fundamental lower body exercise for building leg and glute strength.",
            instructions: ["Stand with feet shoulder-width apart", "Lower your body by bending knees", "Keep back straight and chest up", "Return to standing position"],
            muscleGroups: [.legs, .glutes],
            difficulty: .beginner,
            category: .strength,
            defaultReps: 15,
            caloriesPerMinute: 6.0
        ),
        Exercise(
            name: "Lunges",
            description: "Single-leg exercise for balance and lower body strength.",
            instructions: ["Step forward with one leg", "Lower hips until both knees are at 90 degrees", "Push back to starting position", "Alternate legs"],
            muscleGroups: [.legs, .glutes],
            difficulty: .beginner,
            category: .strength,
            defaultReps: 12,
            caloriesPerMinute: 5.5
        ),
        Exercise(
            name: "Plank",
            description: "Isometric core exercise for building stability and endurance.",
            instructions: ["Start in forearm plank position", "Keep body in straight line", "Engage core and glutes", "Hold position without sagging"],
            muscleGroups: [.core],
            difficulty: .beginner,
            category: .strength,
            durationSeconds: 30,
            caloriesPerMinute: 4.0
        ),
        Exercise(
            name: "Glute Bridges",
            description: "Excellent for activating and strengthening the glutes.",
            instructions: ["Lie on back with knees bent", "Push hips up toward ceiling", "Squeeze glutes at the top", "Lower back down slowly"],
            muscleGroups: [.glutes, .core],
            difficulty: .beginner,
            category: .strength,
            defaultReps: 15,
            caloriesPerMinute: 4.5
        ),
        Exercise(
            name: "Dumbbell Rows",
            description: "Back exercise for building pulling strength.",
            instructions: ["Bend forward at hips holding dumbbells", "Pull weights to your ribcage", "Squeeze shoulder blades together", "Lower weights with control"],
            muscleGroups: [.back, .arms],
            difficulty: .intermediate,
            equipment: [.dumbbells],
            category: .strength,
            defaultReps: 12,
            caloriesPerMinute: 6.0
        ),
        Exercise(
            name: "Shoulder Press",
            description: "Overhead pressing movement for shoulder development.",
            instructions: ["Hold dumbbells at shoulder height", "Press weights overhead", "Fully extend arms at the top", "Lower back to shoulders"],
            muscleGroups: [.shoulders, .arms],
            difficulty: .intermediate,
            equipment: [.dumbbells],
            category: .strength,
            defaultReps: 10,
            caloriesPerMinute: 5.5
        ),
        Exercise(
            name: "Tricep Dips",
            description: "Bodyweight exercise targeting the triceps.",
            instructions: ["Place hands on bench behind you", "Lower body by bending elbows", "Keep elbows pointing backward", "Push back up to start"],
            muscleGroups: [.arms],
            difficulty: .intermediate,
            equipment: [.bench],
            category: .strength,
            defaultReps: 12,
            caloriesPerMinute: 5.0
        ),
        Exercise(
            name: "Bicep Curls",
            description: "Isolation exercise for bicep development.",
            instructions: ["Hold dumbbells at sides", "Curl weights toward shoulders", "Keep elbows stationary", "Lower with control"],
            muscleGroups: [.arms],
            difficulty: .beginner,
            equipment: [.dumbbells],
            category: .strength,
            defaultReps: 12,
            caloriesPerMinute: 4.0
        ),
        Exercise(
            name: "Deadlifts",
            description: "Compound exercise for posterior chain strength.",
            instructions: ["Stand with feet hip-width apart", "Hinge at hips to lower weight", "Keep back flat and core tight", "Drive through heels to stand"],
            muscleGroups: [.back, .legs, .glutes],
            difficulty: .advanced,
            equipment: [.barbell],
            category: .strength,
            defaultReps: 8,
            caloriesPerMinute: 8.0
        ),
        Exercise(
            name: "Diamond Push-ups",
            description: "Tricep-focused push-up variation with hands close together.",
            instructions: ["Form a diamond with thumbs and index fingers", "Lower chest toward hands", "Push back up while keeping elbows close", "Maintain core engagement"],
            muscleGroups: [.arms, .chest],
            difficulty: .intermediate,
            category: .strength,
            defaultReps: 10,
            caloriesPerMinute: 7.5
        ),
        Exercise(
            name: "Bulgarian Split Squats",
            description: "Single-leg squat with rear foot elevated for intense leg work.",
            instructions: ["Place rear foot on bench behind you", "Lower down until front thigh is parallel", "Push through front heel to stand", "Keep torso upright"],
            muscleGroups: [.legs, .glutes],
            difficulty: .advanced,
            equipment: [.bench],
            category: .strength,
            defaultReps: 10,
            caloriesPerMinute: 7.0
        ),
        Exercise(
            name: "Pike Push-ups",
            description: "Shoulder-focused push-up with hips elevated.",
            instructions: ["Start in downward dog position", "Bend elbows and lower head toward floor", "Push back up to starting position", "Keep legs straight"],
            muscleGroups: [.shoulders, .arms],
            difficulty: .intermediate,
            category: .strength,
            defaultReps: 10,
            caloriesPerMinute: 6.0
        ),
        Exercise(
            name: "Wall Sit",
            description: "Isometric leg exercise for building quad endurance.",
            instructions: ["Lean back against a wall", "Slide down until thighs are parallel to floor", "Keep knees at 90 degrees", "Hold position as long as possible"],
            muscleGroups: [.legs],
            difficulty: .beginner,
            category: .strength,
            durationSeconds: 45,
            caloriesPerMinute: 4.0
        ),
        Exercise(
            name: "Calf Raises",
            description: "Isolation exercise for building calf muscles.",
            instructions: ["Stand with feet hip-width apart", "Rise up onto the balls of your feet", "Hold briefly at the top", "Lower back down with control"],
            muscleGroups: [.legs],
            difficulty: .beginner,
            category: .strength,
            defaultReps: 20,
            caloriesPerMinute: 3.5
        ),
        Exercise(
            name: "Pull-ups",
            description: "Classic upper body pull exercise for back and biceps.",
            instructions: ["Grip bar with hands shoulder-width apart", "Pull body up until chin clears bar", "Lower with control", "Avoid swinging"],
            muscleGroups: [.back, .arms],
            difficulty: .advanced,
            equipment: [.pullUpBar],
            category: .strength,
            defaultReps: 8,
            caloriesPerMinute: 9.0
        ),
        Exercise(
            name: "Superman",
            description: "Back extension exercise for lower back strength.",
            instructions: ["Lie face down with arms extended", "Lift arms, chest, and legs simultaneously", "Hold briefly at the top", "Lower back down slowly"],
            muscleGroups: [.back, .core],
            difficulty: .beginner,
            equipment: [.yogaMat],
            category: .strength,
            durationSeconds: 30,
            caloriesPerMinute: 4.0
        ),
        Exercise(
            name: "Decline Push-ups",
            description: "Push-up variation with feet elevated for upper chest focus.",
            instructions: ["Place feet on elevated surface", "Perform push-up with hands on floor", "Lower chest toward ground", "Push back up maintaining form"],
            muscleGroups: [.chest, .shoulders, .arms],
            difficulty: .intermediate,
            equipment: [.bench],
            category: .strength,
            defaultReps: 12,
            caloriesPerMinute: 7.5
        )
    ]
    
    // MARK: - Cardio Exercises
    
    static let cardio: [Exercise] = [
        Exercise(
            name: "Jumping Jacks",
            description: "Classic cardio exercise to elevate heart rate.",
            instructions: ["Start standing with arms at sides", "Jump feet apart while raising arms", "Jump feet together, lower arms", "Maintain a steady rhythm"],
            muscleGroups: [.cardio, .fullBody],
            difficulty: .beginner,
            category: .cardio,
            durationSeconds: 45,
            caloriesPerMinute: 8.0
        ),
        Exercise(
            name: "High Knees",
            description: "Running in place with high knee lifts.",
            instructions: ["Stand tall with feet hip-width apart", "Drive one knee up toward chest", "Alternate legs quickly", "Pump arms as you run"],
            muscleGroups: [.cardio, .legs],
            difficulty: .beginner,
            category: .cardio,
            durationSeconds: 30,
            caloriesPerMinute: 9.0
        ),
        Exercise(
            name: "Butt Kicks",
            description: "Running in place kicking heels to glutes.",
            instructions: ["Stand tall with arms at sides", "Kick one heel back to touch glute", "Alternate legs quickly", "Keep upper body stable"],
            muscleGroups: [.cardio, .legs],
            difficulty: .beginner,
            category: .cardio,
            durationSeconds: 30,
            caloriesPerMinute: 8.0
        ),
        Exercise(
            name: "Mountain Climbers",
            description: "Total body cardio exercise from plank position.",
            instructions: ["Start in high plank position", "Drive one knee toward chest", "Quickly switch legs", "Keep hips level throughout"],
            muscleGroups: [.cardio, .core],
            difficulty: .intermediate,
            category: .cardio,
            durationSeconds: 30,
            caloriesPerMinute: 10.0
        ),
        Exercise(
            name: "Burpees",
            description: "Full body exercise combining squat, plank, and jump.",
            instructions: ["Start standing, drop to squat", "Kick feet back to plank", "Do a push-up (optional)", "Jump feet forward and jump up"],
            muscleGroups: [.fullBody, .cardio],
            difficulty: .advanced,
            category: .cardio,
            defaultReps: 10,
            caloriesPerMinute: 12.0
        ),
        Exercise(
            name: "Lateral Shuffles",
            description: "Side-to-side movement for agility and cardio.",
            instructions: ["Start in athletic stance", "Shuffle quickly to one side", "Touch ground at each end", "Shuffle back to other side"],
            muscleGroups: [.cardio, .legs],
            difficulty: .beginner,
            category: .cardio,
            durationSeconds: 30,
            caloriesPerMinute: 7.0
        ),
        Exercise(
            name: "Jump Rope",
            description: "Classic cardio exercise with or without rope.",
            instructions: ["Hold rope handles at hip height", "Jump over rope as it passes under", "Land softly on balls of feet", "Maintain steady rhythm"],
            muscleGroups: [.cardio, .legs],
            difficulty: .intermediate,
            equipment: [.jumpRope],
            category: .cardio,
            durationSeconds: 60,
            caloriesPerMinute: 11.0
        )
    ]
    
    // MARK: - Flexibility Exercises
    
    static let flexibility: [Exercise] = [
        Exercise(
            name: "Downward Dog",
            description: "Yoga pose stretching hamstrings and calves.",
            instructions: ["Start on hands and knees", "Lift hips up and back", "Straighten legs and arms", "Push chest toward thighs"],
            muscleGroups: [.legs, .back],
            difficulty: .beginner,
            equipment: [.yogaMat],
            category: .flexibility,
            durationSeconds: 30,
            caloriesPerMinute: 3.0
        ),
        Exercise(
            name: "Cat-Cow Stretch",
            description: "Spinal mobility exercise alternating between flexion and extension.",
            instructions: ["Start on hands and knees", "Arch back and look up (cow)", "Round spine and tuck chin (cat)", "Flow between positions"],
            muscleGroups: [.back, .core],
            difficulty: .beginner,
            equipment: [.yogaMat],
            category: .flexibility,
            durationSeconds: 45,
            caloriesPerMinute: 2.5
        ),
        Exercise(
            name: "Child's Pose",
            description: "Restorative pose for back and hip relaxation.",
            instructions: ["Kneel on the floor", "Sit back on heels", "Reach arms forward on floor", "Rest forehead on mat"],
            muscleGroups: [.back, .glutes],
            difficulty: .beginner,
            equipment: [.yogaMat],
            category: .flexibility,
            durationSeconds: 45,
            caloriesPerMinute: 2.0
        ),
        Exercise(
            name: "Warrior I",
            description: "Standing yoga pose for hip flexibility and leg strength.",
            instructions: ["Step one foot back", "Bend front knee to 90 degrees", "Raise arms overhead", "Square hips forward"],
            muscleGroups: [.legs, .core],
            difficulty: .beginner,
            equipment: [.yogaMat],
            category: .flexibility,
            durationSeconds: 30,
            caloriesPerMinute: 3.5
        ),
        Exercise(
            name: "Pigeon Pose",
            description: "Deep hip opener targeting the hip flexors.",
            instructions: ["Start in downward dog", "Bring one knee forward behind wrist", "Extend other leg back", "Fold forward over front leg"],
            muscleGroups: [.glutes, .legs],
            difficulty: .intermediate,
            equipment: [.yogaMat],
            category: .flexibility,
            durationSeconds: 45,
            caloriesPerMinute: 2.5
        ),
        Exercise(
            name: "Seated Forward Fold",
            description: "Hamstring and lower back stretch.",
            instructions: ["Sit with legs extended", "Hinge forward at hips", "Reach toward toes", "Keep back as straight as possible"],
            muscleGroups: [.legs, .back],
            difficulty: .beginner,
            equipment: [.yogaMat],
            category: .flexibility,
            durationSeconds: 30,
            caloriesPerMinute: 2.0
        )
    ]
    
    // MARK: - Plyometric Exercises
    
    static let plyometric: [Exercise] = [
        Exercise(
            name: "Squat Jumps",
            description: "Explosive lower body exercise.",
            instructions: ["Start in squat position", "Explode upward into jump", "Land softly back in squat", "Immediately repeat"],
            muscleGroups: [.legs, .glutes],
            difficulty: .intermediate,
            category: .plyometric,
            defaultReps: 12,
            caloriesPerMinute: 10.0
        ),
        Exercise(
            name: "Box Jumps",
            description: "Jump onto elevated platform for power.",
            instructions: ["Stand facing the box", "Swing arms and jump up", "Land softly on the box", "Step down and repeat"],
            muscleGroups: [.legs, .glutes],
            difficulty: .advanced,
            equipment: [.bench],
            category: .plyometric,
            defaultReps: 10,
            caloriesPerMinute: 9.0
        ),
        Exercise(
            name: "Tuck Jumps",
            description: "High intensity jump bringing knees to chest.",
            instructions: ["Stand with feet shoulder-width", "Jump up explosively", "Bring knees toward chest", "Land softly and repeat"],
            muscleGroups: [.legs, .core],
            difficulty: .advanced,
            category: .plyometric,
            defaultReps: 8,
            caloriesPerMinute: 11.0
        ),
        Exercise(
            name: "Skater Jumps",
            description: "Lateral jumping movement for agility.",
            instructions: ["Stand on one leg", "Jump laterally to other leg", "Land softly on single leg", "Immediately jump back"],
            muscleGroups: [.legs, .glutes],
            difficulty: .intermediate,
            category: .plyometric,
            defaultReps: 16,
            caloriesPerMinute: 9.0
        )
    ]
    
    // MARK: - Helper Methods
    
    static func exercises(for category: ExerciseCategory) -> [Exercise] {
        all.filter { $0.category == category }
    }
    
    static func exercises(for muscleGroup: MuscleGroup) -> [Exercise] {
        all.filter { $0.muscleGroups.contains(muscleGroup) }
    }
    
    static func exercises(for difficulty: DifficultyLevel) -> [Exercise] {
        all.filter { $0.difficulty == difficulty }
    }
    
    static func search(_ query: String) -> [Exercise] {
        let lowercasedQuery = query.lowercased()
        return all.filter {
            $0.name.lowercased().contains(lowercasedQuery) ||
            $0.description.lowercased().contains(lowercasedQuery)
        }
    }
}
