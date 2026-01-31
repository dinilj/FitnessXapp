//
//  WorkoutTypeSelectionView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// View for selecting workout type before starting
struct WorkoutTypeSelectionView: View {
    
    @EnvironmentObject var viewModel: WorkoutViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedType: WorkoutType?
    @State private var navigateToWorkout = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.08, green: 0.08, blue: 0.15),
                    Color(red: 0.12, green: 0.1, blue: 0.2)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Text("Choose Your Workout")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Select a workout type to get started")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.top, 20)
                
                // Workout type grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(WorkoutType.allCases) { type in
                            WorkoutTypeCard(
                                type: type,
                                isSelected: selectedType == type,
                                action: { selectedType = type }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Start button - always visible with selection indication
                VStack(spacing: 12) {
                    if let selected = selectedType {
                        Button(action: {
                            navigateToWorkout = true
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "play.fill")
                                    .font(.headline)
                                Text("Start \(selected.displayName)")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(
                                    colors: selected.gradientColors,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: selected.themeColor.opacity(0.4), radius: 10, y: 5)
                        }
                    } else {
                        // Placeholder button when nothing selected
                        HStack(spacing: 12) {
                            Image(systemName: "hand.tap.fill")
                                .font(.headline)
                            Text("Select a Workout Type")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white.opacity(0.5))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.1))
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Workout Type")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationDestination(isPresented: $navigateToWorkout) {
            WorkoutView()
                .environmentObject(viewModel)
        }
    }
}

// MARK: - Workout Type Card

struct WorkoutTypeCard: View {
    let type: WorkoutType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: type.gradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 56, height: 56)
                        .shadow(color: type.themeColor.opacity(isSelected ? 0.5 : 0.2), radius: isSelected ? 10 : 5, y: 3)
                    
                    Image(systemName: type.iconName)
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Text(type.displayName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(type.description)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(height: 30)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.white.opacity(0.15) : Color.white.opacity(0.06))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                isSelected ? type.themeColor : Color.white.opacity(0.1),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
            )
            .scaleEffect(isSelected ? 1.02 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
    }
}

#Preview {
    NavigationStack {
        WorkoutTypeSelectionView()
            .environmentObject(WorkoutViewModel())
    }
}
