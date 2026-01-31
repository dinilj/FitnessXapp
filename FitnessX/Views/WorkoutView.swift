//
//  WorkoutView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// Active workout screen with map, controls, and moment capture
struct WorkoutView: View {
    
    @EnvironmentObject var viewModel: WorkoutViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showPhotoPicker = false
    @State private var selectedImage: UIImage?
    @State private var showEndConfirmation = false
    @State private var navigateToRecap = false
    @State private var selectedMoment: Moment?
    
    var body: some View {
        ZStack {
            // Map takes full screen
            WorkoutMapView(
                routeSimulator: viewModel.routeSimulator,
                moments: viewModel.moments,
                isActive: viewModel.workoutStatus == .active,
                showFullRoute: true,
                onMomentTapped: { moment in
                    selectedMoment = moment
                }
            )
            .ignoresSafeArea()
            
            // Overlay UI
            VStack {
                // Top stats bar
                statsBar
                    .padding(.top, 8)
                
                Spacer()
                
                // Bottom controls
                VStack(spacing: 16) {
                    // Moments preview (if any)
                    if !viewModel.moments.isEmpty {
                        momentsPreview
                    }
                    
                    // Control buttons
                    controlsBar
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal)
            
            // Moment preview overlay
            if let moment = selectedMoment {
                momentPreviewOverlay(moment: moment)
            }
        }
        .navigationBarBackButtonHidden(viewModel.workoutStatus != .idle)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if viewModel.workoutStatus == .idle {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(Color.black.opacity(0.5)))
                    }
                }
            }
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(selectedImage: $selectedImage)
        }
        .onChange(of: selectedImage) { oldValue, newValue in
            if let image = newValue {
                viewModel.addMoment(with: image)
                selectedImage = nil
            }
        }
        .alert("End Workout?", isPresented: $showEndConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("End", role: .destructive) {
                viewModel.endWorkout()
                navigateToRecap = true
            }
        } message: {
            Text("Your workout will be saved and you'll see your recap.")
        }
        .navigationDestination(isPresented: $navigateToRecap) {
            RecapView()
                .environmentObject(viewModel)
        }
    }
    
    // MARK: - Stats Bar
    
    private var statsBar: some View {
        HStack(spacing: 20) {
            statItem(value: viewModel.formattedTime, label: "TIME", icon: "clock.fill")
            statItem(value: viewModel.formattedDistance, label: "DISTANCE", icon: "location.fill")
            statItem(value: viewModel.formattedPace, label: "PACE", icon: "speedometer")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
    }
    
    private func statItem(value: String, label: String, icon: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.orange)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Moments Preview
    
    private var momentsPreview: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.moments) { moment in
                    if let image = moment.getImage() {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.white, lineWidth: 2)
                            )
                            .onTapGesture {
                                selectedMoment = moment
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Controls Bar
    
    private var controlsBar: some View {
        HStack(spacing: 20) {
            // Camera button
            Button(action: { showPhotoPicker = true }) {
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: "camera.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .disabled(viewModel.workoutStatus != .active)
            .opacity(viewModel.workoutStatus == .active ? 1 : 0.5)
            
            // Main control button
            Button(action: { viewModel.toggleWorkout() }) {
                ZStack {
                    Circle()
                        .fill(
                            viewModel.workoutStatus == .idle ? Color.green :
                            viewModel.workoutStatus == .active ? Color.orange : Color.green
                        )
                        .frame(width: 80, height: 80)
                        .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
                    
                    Image(systemName: workoutButtonIcon)
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            
            // End button
            Button(action: { showEndConfirmation = true }) {
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: "stop.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            }
            .disabled(viewModel.workoutStatus == .idle)
            .opacity(viewModel.workoutStatus == .idle ? 0.5 : 1)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(.ultraThinMaterial)
        )
    }
    
    private var workoutButtonIcon: String {
        switch viewModel.workoutStatus {
        case .idle: return "play.fill"
        case .active: return "pause.fill"
        case .paused: return "play.fill"
        case .completed: return "play.fill"
        }
    }
    
    // MARK: - Moment Preview Overlay
    
    private func momentPreviewOverlay(moment: Moment) -> some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture { selectedMoment = nil }
            
            VStack(spacing: 20) {
                if let image = moment.getImage() {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Text(moment.timestamp.formatted(date: .abbreviated, time: .shortened))
                    .font(.headline)
                    .foregroundColor(.white)
                
                Button("Close") { selectedMoment = nil }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Capsule().fill(.ultraThinMaterial))
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        WorkoutView()
            .environmentObject(WorkoutViewModel())
    }
}
