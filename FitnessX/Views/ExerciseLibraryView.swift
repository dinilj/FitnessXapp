//
//  ExerciseLibraryView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// Library view showing all exercises with search and filter
struct ExerciseLibraryView: View {
    
    @State private var searchText = ""
    @State private var selectedCategory: ExerciseCategory?
    @State private var selectedExercise: Exercise?
    
    var filteredExercises: [Exercise] {
        var exercises = ExerciseData.all
        
        if let category = selectedCategory {
            exercises = exercises.filter { $0.category == category }
        }
        
        if !searchText.isEmpty {
            exercises = exercises.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return exercises
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Search bar
                searchBar
                    .padding(.horizontal)
                    .padding(.top)
                
                // Category filter
                categoryFilter
                    .padding(.vertical)
                
                // Exercise list
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredExercises) { exercise in
                            ExerciseRowCard(exercise: exercise)
                                .onTapGesture {
                                    selectedExercise = exercise
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Exercise Library")
        .navigationBarTitleDisplayMode(.large)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationDestination(item: $selectedExercise) { exercise in
            ExerciseDetailView(exercise: exercise)
        }
    }
    
    // MARK: - Search Bar
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.5))
            
            TextField("Search exercises...", text: $searchText)
                .foregroundColor(.white)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.5))
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.08))
        )
    }
    
    // MARK: - Category Filter
    
    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                FilterChip(
                    title: "All",
                    isSelected: selectedCategory == nil,
                    action: { selectedCategory = nil }
                )
                
                ForEach(ExerciseCategory.allCases) { category in
                    FilterChip(
                        title: category.displayName,
                        isSelected: selectedCategory == category,
                        action: { selectedCategory = category }
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Filter Chip

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .white.opacity(0.7))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.blue : Color.white.opacity(0.1))
                )
        }
    }
}

// MARK: - Exercise Row Card

struct ExerciseRowCard: View {
    let exercise: Exercise
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(exercise.difficulty.color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: exercise.category.iconName)
                    .font(.title3)
                    .foregroundColor(exercise.difficulty.color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(exercise.primaryMuscle.displayName)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(exercise.difficulty.displayName)
                    .font(.caption)
                    .foregroundColor(exercise.difficulty.color)
                
                if exercise.isTimeBased {
                    Text("\(exercise.durationSeconds ?? 0)s")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                } else if exercise.isRepBased {
                    Text("\(exercise.defaultReps ?? 0) reps")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.3))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
        )
    }
}

#Preview {
    NavigationStack {
        ExerciseLibraryView()
    }
}
