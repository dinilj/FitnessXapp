//
//  QuickWorkoutsView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// View displaying quick workout templates
struct QuickWorkoutsView: View {
    
    @State private var selectedDifficulty: DifficultyLevel?
    @State private var selectedTemplate: WorkoutTemplate?
    
    var filteredTemplates: [WorkoutTemplate] {
        if let difficulty = selectedDifficulty {
            return WorkoutTemplateData.all.filter { $0.difficulty == difficulty }
        }
        return WorkoutTemplateData.all
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 4) {
                    Text("Quick Workouts")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Ready-to-go workouts you can start right away")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.top, 8)
                .padding(.bottom, 12)
                
                // Difficulty filter
                difficultyFilter
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                
                // Templates grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredTemplates) { template in
                            TemplateCard(template: template)
                                .onTapGesture {
                                    selectedTemplate = template
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Quick Workouts")
        .navigationBarTitleDisplayMode(.large)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationDestination(item: $selectedTemplate) { template in
            TemplateDetailView(template: template)
        }
    }
    
    // MARK: - Difficulty Filter
    
    private var difficultyFilter: some View {
        HStack(spacing: 10) {
            FilterChip(
                title: "All",
                isSelected: selectedDifficulty == nil,
                action: { selectedDifficulty = nil }
            )
            
            ForEach(DifficultyLevel.allCases) { level in
                FilterChip(
                    title: level.displayName,
                    isSelected: selectedDifficulty == level,
                    action: { selectedDifficulty = level }
                )
            }
        }
    }
}

// MARK: - Template Card

struct TemplateCard: View {
    let template: WorkoutTemplate
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: template.type.gradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 44, height: 44)
                        .shadow(color: template.type.themeColor.opacity(0.4), radius: 8, y: 3)
                    
                    Image(systemName: template.type.iconName)
                        .font(.body)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Duration badge
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.caption2)
                    Text("\(template.durationMinutes) min")
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Capsule().fill(Color.white.opacity(0.15)))
            }
            
            Text(template.name)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text(template.description)
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
                .lineLimit(2)
                .frame(height: 32, alignment: .top)
            
            // Stats row
            HStack(spacing: 8) {
                // Exercise count
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.caption2)
                        .foregroundColor(.orange)
                    Text("\(template.exerciseCount)")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                // Estimated calories
                HStack(spacing: 4) {
                    Text("•")
                        .foregroundColor(.white.opacity(0.3))
                    Text("~\(template.durationMinutes * 7) cal")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.5))
                }
                
                Spacer()
            }
            
            // Difficulty badge
            Text(template.difficulty.displayName)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(template.difficulty.color)
                )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        QuickWorkoutsView()
    }
}
