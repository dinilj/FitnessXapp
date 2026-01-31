//
//  FitnessXApp.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

@main
struct FitnessXApp: App {
    @StateObject private var workoutViewModel = WorkoutViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(workoutViewModel)
        }
    }
}
