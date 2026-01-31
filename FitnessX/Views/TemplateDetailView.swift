//
//  TemplateDetailView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// Detailed view for a workout template
struct TemplateDetailView: View {
    
    let template: WorkoutTemplate
    @State private var showWorkoutSession = false
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.2)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    headerSection
                    
                    // Stats
                    statsSection
                    
                    // Exercises list
                    exercisesSection
                    
                    // Start button
                    startButton
                    
                    Spacer(minLength: 30)
                }
                .padding()
            }
        }
        .navigationTitle(template.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .fullScreenCover(isPresented: $showWorkoutSession) {
            TemplateWorkoutSessionView(template: template)
        }
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: template.type.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)
                
                Image(systemName: template.type.iconName)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
            Text(template.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
            
            Text(template.difficulty.displayName)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(template.difficulty.color)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(template.difficulty.color.opacity(0.2))
                )
        }
    }
    
    // MARK: - Stats Section
    
    private var statsSection: some View {
        HStack(spacing: 0) {
            statItem(value: "\(template.durationMinutes)", label: "Minutes")
            Divider().frame(height: 40).background(Color.white.opacity(0.2))
            statItem(value: "\(template.exerciseCount)", label: "Exercises")
            Divider().frame(height: 40).background(Color.white.opacity(0.2))
            statItem(value: "\(template.totalSets)", label: "Total Sets")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
        )
    }
    
    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Exercises Section
    
    private var exercisesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Exercises")
                .font(.headline)
                .foregroundColor(.white)
            
            ForEach(Array(template.exercises.enumerated()), id: \.element.id) { index, exercise in
                HStack {
                    Text("\(index + 1)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Circle().fill(Color.blue))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(exercise.exerciseName)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        Text(exerciseDetailString(exercise))
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    
                    Spacer()
                    
                    Text("\(exercise.restSeconds)s rest")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.05))
                )
            }
        }
    }
    
    private func exerciseDetailString(_ exercise: TemplateExercise) -> String {
        if let reps = exercise.reps {
            return "\(exercise.sets) sets × \(reps) reps"
        } else if let duration = exercise.durationSeconds {
            return "\(exercise.sets) sets × \(duration)s"
        }
        return "\(exercise.sets) sets"
    }
    
    // MARK: - Start Button
    
    private var startButton: some View {
        Button(action: { showWorkoutSession = true }) {
            HStack {
                Image(systemName: "play.fill")
                Text("Start Workout")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    colors: template.type.gradientColors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

// MARK: - Template Workout Session View

struct TemplateWorkoutSessionView: View {
    
    let template: WorkoutTemplate
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentExerciseIndex = 0
    @State private var currentSet = 1
    @State private var isResting = false
    @State private var timer: Timer?
    @State private var timeRemaining = 0
    @State private var isCompleted = false
    
    var currentExercise: TemplateExercise? {
        guard currentExerciseIndex < template.exercises.count else { return nil }
        return template.exercises[currentExerciseIndex]
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.2)
                .ignoresSafeArea()
            
            if isCompleted {
                completedView
            } else if let exercise = currentExercise {
                VStack(spacing: 24) {
                    // Progress
                    progressHeader
                    
                    Spacer()
                    
                    // Current exercise
                    exerciseDisplay(exercise: exercise)
                    
                    Spacer()
                    
                    // Timer or action button
                    if isResting {
                        restTimerView
                    } else {
                        actionButton
                    }
                }
                .padding()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    // MARK: - Progress Header
    
    private var progressHeader: some View {
        VStack(spacing: 8) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                Text("Exercise \(currentExerciseIndex + 1) of \(template.exercises.count)")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Color.clear.frame(width: 30)
            }
            
            ProgressView(value: Double(currentExerciseIndex) / Double(template.exercises.count))
                .tint(.blue)
        }
    }
    
    // MARK: - Exercise Display
    
    private func exerciseDisplay(exercise: TemplateExercise) -> some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: template.type.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                
                Image(systemName: template.type.iconName)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }
            
            Text(exercise.exerciseName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Set \(currentSet) of \(exercise.sets)")
                .font(.title3)
                .foregroundColor(.white.opacity(0.7))
            
            if let reps = exercise.reps {
                Text("\(reps) reps")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            } else if let duration = exercise.durationSeconds {
                Text("\(duration) seconds")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }
        }
    }
    
    // MARK: - Rest Timer
    
    private var restTimerView: some View {
        VStack(spacing: 16) {
            Text("Rest")
                .font(.title2)
                .foregroundColor(.white.opacity(0.7))
            
            Text("\(timeRemaining)s")
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .foregroundColor(.cyan)
            
            Button(action: { skipRest() }) {
                Text("Skip Rest")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 16)
                    .background(Capsule().fill(Color.white.opacity(0.2)))
            }
        }
    }
    
    // MARK: - Action Button
    
    private var actionButton: some View {
        Button(action: { completeSet() }) {
            Text("Complete Set")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
    // MARK: - Completed View
    
    private var completedView: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Workout Complete!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(template.name)
                .font(.headline)
                .foregroundColor(.white.opacity(0.7))
            
            Button(action: { dismiss() }) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: template.type.gradientColors,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal, 40)
        }
    }
    
    // MARK: - Actions
    
    private func completeSet() {
        guard let exercise = currentExercise else { return }
        
        if currentSet < exercise.sets {
            currentSet += 1
            startRest(seconds: exercise.restSeconds)
        } else {
            if currentExerciseIndex < template.exercises.count - 1 {
                currentExerciseIndex += 1
                currentSet = 1
                if let nextExercise = template.exercises[safe: currentExerciseIndex] {
                    startRest(seconds: nextExercise.restSeconds)
                }
            } else {
                isCompleted = true
            }
        }
    }
    
    private func startRest(seconds: Int) {
        isResting = true
        timeRemaining = seconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                skipRest()
            }
        }
    }
    
    private func skipRest() {
        timer?.invalidate()
        isResting = false
    }
}

// MARK: - Safe Array Access

extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    NavigationStack {
        TemplateDetailView(template: WorkoutTemplateData.morningEnergizer)
    }
}
