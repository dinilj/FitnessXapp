//
//  ProgramDetailView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// Detailed view for a workout program
struct ProgramDetailView: View {
    
    let program: WorkoutProgram
    @State private var expandedDay: UUID?
    
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
                    
                    // Days list
                    daysSection
                    
                    Spacer(minLength: 30)
                }
                .padding()
            }
        }
        .navigationTitle(program.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: program.category.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)
                
                Image(systemName: program.category.iconName)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
            Text(program.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
            
            Text(program.difficulty.displayName)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(program.difficulty.color)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(program.difficulty.color.opacity(0.2))
                )
        }
    }
    
    // MARK: - Stats Section
    
    private var statsSection: some View {
        HStack(spacing: 0) {
            statItem(value: "\(program.durationWeeks)", label: "Weeks")
            Divider().frame(height: 40).background(Color.white.opacity(0.2))
            statItem(value: "\(program.totalDays)", label: "Days")
            Divider().frame(height: 40).background(Color.white.opacity(0.2))
            statItem(value: "\(program.workoutDays)", label: "Workouts")
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
    
    // MARK: - Days Section
    
    private var daysSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Program Days")
                .font(.headline)
                .foregroundColor(.white)
            
            ForEach(program.days) { day in
                DayCard(
                    day: day,
                    isExpanded: expandedDay == day.id,
                    onTap: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            expandedDay = expandedDay == day.id ? nil : day.id
                        }
                    }
                )
            }
        }
    }
}

// MARK: - Day Card

struct DayCard: View {
    let day: ProgramDay
    let isExpanded: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            Button(action: onTap) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Day \(day.dayNumber)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                        
                        Text(day.name)
                            .font(.headline)
                            .foregroundColor(day.isRestDay ? .green : .white)
                    }
                    
                    Spacer()
                    
                    if day.isRestDay {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.green)
                    } else {
                        Text("\(day.exercises.count) exercises")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white.opacity(0.4))
                }
            }
            .padding()
            
            // Expanded content
            if isExpanded && !day.isRestDay {
                Divider()
                    .background(Color.white.opacity(0.1))
                
                VStack(alignment: .leading, spacing: 12) {
                    if !day.description.isEmpty {
                        Text(day.description)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    ForEach(day.exercises) { exercise in
                        HStack {
                            Text(exercise.exerciseName)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            if let reps = exercise.reps {
                                Text("\(exercise.sets)x\(reps)")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.6))
                            } else if let duration = exercise.durationSeconds {
                                Text("\(exercise.sets)x\(duration)s")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.03))
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
        )
    }
}

#Preview {
    NavigationStack {
        ProgramDetailView(program: WorkoutProgramData.beginnerKickstart)
    }
}
