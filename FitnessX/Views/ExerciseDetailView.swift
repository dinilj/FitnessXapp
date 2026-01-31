//
//  ExerciseDetailView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// Detailed view for a single exercise
struct ExerciseDetailView: View {
    
    let exercise: Exercise
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.2)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    headerSection
                    
                    // Quick stats
                    statsRow
                    
                    // Muscle groups
                    muscleGroupsSection
                    
                    // Equipment
                    if exercise.equipment.first != .none {
                        equipmentSection
                    }
                    
                    // Instructions
                    instructionsSection
                    
                    Spacer(minLength: 30)
                }
                .padding()
            }
        }
        .navigationTitle(exercise.name)
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
                            colors: [exercise.difficulty.color, exercise.difficulty.color.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                
                Image(systemName: exercise.category.iconName)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            
            Text(exercise.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Stats Row
    
    private var statsRow: some View {
        HStack(spacing: 0) {
            statItem(
                value: exercise.difficulty.displayName,
                label: "Difficulty",
                color: exercise.difficulty.color
            )
            
            Divider()
                .frame(height: 40)
                .background(Color.white.opacity(0.2))
            
            statItem(
                value: exercise.category.displayName,
                label: "Category",
                color: .blue
            )
            
            Divider()
                .frame(height: 40)
                .background(Color.white.opacity(0.2))
            
            statItem(
                value: String(format: "%.0f", exercise.caloriesPerMinute),
                label: "Cal/min",
                color: .orange
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
        )
    }
    
    private func statItem(value: String, label: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .foregroundColor(color)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Muscle Groups Section
    
    private var muscleGroupsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Targeted Muscles")
                .font(.headline)
                .foregroundColor(.white)
            
            FlowLayout(spacing: 8) {
                ForEach(exercise.muscleGroups) { muscle in
                    HStack(spacing: 6) {
                        Image(systemName: muscle.iconName)
                            .font(.caption)
                        Text(muscle.displayName)
                            .font(.subheadline)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.purple.opacity(0.3))
                    )
                }
            }
        }
    }
    
    // MARK: - Equipment Section
    
    private var equipmentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Equipment Needed")
                .font(.headline)
                .foregroundColor(.white)
            
            FlowLayout(spacing: 8) {
                ForEach(exercise.equipment) { equipment in
                    Text(equipment.displayName)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.blue.opacity(0.3))
                        )
                }
            }
        }
    }
    
    // MARK: - Instructions Section
    
    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("How To Perform")
                .font(.headline)
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(exercise.instructions.enumerated()), id: \.offset) { index, instruction in
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(index + 1)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .background(Circle().fill(Color.green))
                        
                        Text(instruction)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.08))
            )
        }
    }
}

// MARK: - Flow Layout

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y), proposal: .unspecified)
        }
    }
    
    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint]) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if currentX + size.width > maxWidth && currentX > 0 {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            
            positions.append(CGPoint(x: currentX, y: currentY))
            lineHeight = max(lineHeight, size.height)
            currentX += size.width + spacing
        }
        
        return (CGSize(width: maxWidth, height: currentY + lineHeight), positions)
    }
}

#Preview {
    NavigationStack {
        ExerciseDetailView(exercise: ExerciseData.strength.first!)
    }
}
