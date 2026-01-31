//
//  HomeView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// Main landing screen of the FitnessX app
struct HomeView: View {
    
    @EnvironmentObject var viewModel: WorkoutViewModel
    @State private var animateGradient = false
    
    // Navigation states
    @State private var showWorkoutTypeSelection = false
    @State private var showExerciseLibrary = false
    @State private var showPrograms = false
    @State private var showQuickWorkouts = false
    @State private var showRecapView = false
    @State private var showGPSWorkout = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Animated gradient background
                LinearGradient(
                    colors: [
                        Color(red: 0.1, green: 0.1, blue: 0.2),
                        Color(red: 0.15, green: 0.2, blue: 0.35),
                        Color(red: 0.1, green: 0.15, blue: 0.25)
                    ],
                    startPoint: animateGradient ? .topLeading : .bottomLeading,
                    endPoint: animateGradient ? .bottomTrailing : .topTrailing
                )
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
                
                ScrollView {
                    VStack(spacing: 24) {
                        // App branding
                        headerSection
                            .padding(.top, 20)
                        
                        // Quick actions
                        quickActionsSection
                        
                        // Feature cards
                        featureCardsSection
                        
                        // Last workout card
                        if let lastWorkout = viewModel.lastWorkout {
                            lastWorkoutCard(workout: lastWorkout)
                        }
                        
                        Spacer(minLength: 30)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationDestination(isPresented: $showWorkoutTypeSelection) {
                WorkoutTypeSelectionView()
                    .environmentObject(viewModel)
            }
            .navigationDestination(isPresented: $showExerciseLibrary) {
                ExerciseLibraryView()
            }
            .navigationDestination(isPresented: $showPrograms) {
                WorkoutProgramsView()
            }
            .navigationDestination(isPresented: $showQuickWorkouts) {
                QuickWorkoutsView()
            }
            .navigationDestination(isPresented: $showGPSWorkout) {
                WorkoutView()
                    .environmentObject(viewModel)
            }
            .navigationDestination(isPresented: $showRecapView) {
                RecapView()
                    .environmentObject(viewModel)
            }
        }
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)
                    .shadow(color: .blue.opacity(0.5), radius: 15, y: 5)
                
                Image(systemName: "figure.run")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
            }
            
            Text("FitnessX")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Your Personal Fitness Companion")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
    }
    
    // MARK: - Quick Actions Section
    
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Start")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack(spacing: 12) {
                // GPS Run Button
                Button(action: { showGPSWorkout = true }) {
                    VStack(spacing: 8) {
                        Image(systemName: "location.fill")
                            .font(.title2)
                        Text("GPS Run")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(
                        LinearGradient(
                            colors: [.orange, .red],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .orange.opacity(0.3), radius: 10, y: 5)
                }
                
                // Quick Workout Button
                Button(action: { showQuickWorkouts = true }) {
                    VStack(spacing: 8) {
                        Image(systemName: "bolt.fill")
                            .font(.title2)
                        Text("Quick Workout")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(
                        LinearGradient(
                            colors: [.green, .mint],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .green.opacity(0.3), radius: 10, y: 5)
                }
                
                // Choose Type Button
                Button(action: { showWorkoutTypeSelection = true }) {
                    VStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                        Text("Choose Type")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .blue.opacity(0.3), radius: 10, y: 5)
                }
            }
        }
    }
    
    // MARK: - Feature Cards Section
    
    private var featureCardsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Explore")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(spacing: 12) {
                // Exercise Library card
                FeatureCard(
                    title: "Exercise Library",
                    subtitle: "\(ExerciseData.all.count)+ exercises with instructions",
                    icon: "figure.strengthtraining.traditional",
                    gradientColors: [.red, .pink]
                )
                .onTapGesture { showExerciseLibrary = true }
                
                // Workout Programs card
                FeatureCard(
                    title: "Workout Programs",
                    subtitle: "\(WorkoutProgramData.all.count) structured training plans",
                    icon: "calendar.badge.clock",
                    gradientColors: [.purple, .indigo]
                )
                .onTapGesture { showPrograms = true }
                
                // View Last Workout card (if available)
                if viewModel.hasCompletedWorkout {
                    FeatureCard(
                        title: "View Last Workout",
                        subtitle: "See your workout recap and stats",
                        icon: "chart.bar.fill",
                        gradientColors: [.cyan, .blue]
                    )
                    .onTapGesture { showRecapView = true }
                }
            }
        }
    }
    
    // MARK: - Last Workout Card
    
    private func lastWorkoutCard(workout: Workout) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Activity")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: workout.workoutType?.gradientColors ?? [.blue, .cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: workout.workoutType?.iconName ?? "figure.run")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(workout.workoutType?.displayName ?? "Workout")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(workout.startTime.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(workout.formattedDistance)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(workout.formattedDuration)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.08))
            )
            .onTapGesture { showRecapView = true }
        }
    }
}

// MARK: - Feature Card Component

struct FeatureCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let gradientColors: [Color]
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.4))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
        )
    }
}

#Preview {
    HomeView()
        .environmentObject(WorkoutViewModel())
}
