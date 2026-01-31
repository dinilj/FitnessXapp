//
//  WorkoutProgramsView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// View displaying all available workout programs
struct WorkoutProgramsView: View {
    
    @State private var selectedProgram: WorkoutProgram?
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.2)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(spacing: 4) {
                        Text("Workout Programs")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Structured plans to achieve your fitness goals")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.top, 8)
                    
                    // Program cards
                    ForEach(WorkoutProgramData.all, id: \.id) { program in
                        ProgramCard(program: program)
                            .onTapGesture {
                                selectedProgram = program
                            }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Programs")
        .navigationBarTitleDisplayMode(.large)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationDestination(item: $selectedProgram) { program in
            ProgramDetailView(program: program)
        }
    }
}

// MARK: - Program Card

struct ProgramCard: View {
    let program: WorkoutProgram
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(program.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(program.description)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(2)
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: program.category.iconName)
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            HStack(spacing: 12) {
                // Duration badge
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .font(.caption2)
                    Text("\(program.durationWeeks) Week\(program.durationWeeks > 1 ? "s" : "")")
                        .font(.caption2)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Capsule().fill(Color.white.opacity(0.2)))
                
                // Days badge
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.caption2)
                    Text("\(program.workoutDays) days")
                        .font(.caption2)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Capsule().fill(Color.white.opacity(0.2)))
                
                Spacer()
                
                // Difficulty badge
                HStack(spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .font(.caption2)
                    Text(program.difficulty.displayName)
                        .font(.caption2)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Capsule().fill(Color.white.opacity(0.2)))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: program.category.gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: program.category.themeColor.opacity(0.3), radius: 10, y: 5)
        )
    }
}

#Preview {
    NavigationStack {
        WorkoutProgramsView()
    }
}
