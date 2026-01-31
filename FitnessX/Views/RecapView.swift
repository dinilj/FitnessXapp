//
//  RecapView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI
import MapKit

/// Workout recap and summary screen
struct RecapView: View {
    
    @EnvironmentObject var viewModel: WorkoutViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showShareSheet = false
    
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
            
            if let workout = viewModel.lastWorkout {
                ScrollView {
                    VStack(spacing: 24) {
                        // Title
                        Text("Workout Recap")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Workout complete header
                        completionHeader(workout: workout)
                        
                        // Map preview
                        mapPreview(workout: workout)
                        
                        // Stats grid
                        statsGrid(workout: workout)
                        
                        // Moments timeline
                        if !workout.moments.isEmpty {
                            momentsSection(moments: workout.moments)
                        }
                        
                        // Share button at bottom
                        shareButton
                        
                        Spacer(minLength: 30)
                    }
                    .padding()
                }
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "figure.run.circle")
                        .font(.system(size: 60))
                        .foregroundColor(.white.opacity(0.3))
                    Text("No workout to display")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showShareSheet = true }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            if let workout = viewModel.lastWorkout {
                ShareSheet(items: [generateShareText(workout: workout)])
            }
        }
    }
    
    // MARK: - Completion Header
    
    private func completionHeader(workout: Workout) -> some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.green, .mint],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)
                    .shadow(color: .green.opacity(0.4), radius: 15, y: 5)
                
                Image(systemName: "checkmark")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Text("Workout Complete!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(workout.startTime.formatted(date: .abbreviated, time: .shortened))
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(.top)
    }
    
    // MARK: - Map Preview
    
    private func mapPreview(workout: Workout) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            if workout.routePoints.count > 1 {
                Map {
                    MapPolyline(coordinates: workout.routePoints.map { $0.coordinate })
                        .stroke(
                            LinearGradient(
                                colors: [.cyan, .blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 4
                        )
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .disabled(true)
            }
            
            HStack {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: workout.workoutType?.gradientColors ?? [.blue, .cyan],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: workout.workoutType?.iconName ?? "figure.run")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(workout.workoutType?.displayName ?? "Workout")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("Completed")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    // MARK: - Stats Grid
    
    private func statsGrid(workout: Workout) -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                statCard(value: workout.formattedDistance, label: "Distance", icon: "location.fill", color: .cyan)
                statCard(value: workout.formattedDuration, label: "Duration", icon: "clock.fill", color: .green)
            }
            
            HStack(spacing: 12) {
                statCard(value: workout.formattedPace, label: "Avg Pace", icon: "speedometer", color: .orange)
                statCard(value: "\(workout.moments.count)", label: "Moments", icon: "camera.fill", color: .purple)
            }
        }
    }
    
    private func statCard(value: String, label: String, icon: String, color: Color) -> some View {
        VStack(spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundColor(color)
                Text(label)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    // MARK: - Moments Section
    
    private func momentsSection(moments: [Moment]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Moments")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(moments.count) photos")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            
            TimelineView(moments: moments)
        }
    }
    
    // MARK: - Share Button
    
    private var shareButton: some View {
        Button(action: { showShareSheet = true }) {
            HStack {
                Image(systemName: "square.and.arrow.up")
                Text("Share Workout")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
    // MARK: - Helper Methods
    
    private func generateShareText(workout: Workout) -> String {
        """
        🏃 FitnessX Workout Complete!
        
        📍 Distance: \(workout.formattedDistance)
        ⏱️ Duration: \(workout.formattedDuration)
        ⚡ Pace: \(workout.formattedPace)
        📸 Moments: \(workout.moments.count)
        
        #FitnessX #Workout
        """
    }
}

// MARK: - Share Sheet

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    NavigationStack {
        RecapView()
            .environmentObject(WorkoutViewModel())
    }
}
