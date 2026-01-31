//
//  WorkoutMapView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI
import MapKit

/// Map view displaying the workout route and moments
struct WorkoutMapView: View {
    
    @ObservedObject var routeSimulator: RouteSimulator
    let moments: [Moment]
    let isActive: Bool
    let showFullRoute: Bool
    var onMomentTapped: ((Moment) -> Void)?
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $cameraPosition) {
            // Full route (light)
            if showFullRoute && !SampleRouteData.parkRoute.isEmpty {
                MapPolyline(coordinates: SampleRouteData.parkRoute)
                    .stroke(.white.opacity(0.3), lineWidth: 4)
            }
            
            // Traversed route (highlighted)
            if routeSimulator.traversedPoints.count > 1 {
                let coordinates = routeSimulator.traversedPoints.map { $0.coordinate }
                MapPolyline(coordinates: coordinates)
                    .stroke(
                        LinearGradient(
                            colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 5
                    )
            }
            
            // Current position marker
            if isActive {
                Annotation("", coordinate: routeSimulator.currentCoordinate) {
                    ZStack {
                        Circle()
                            .fill(.blue)
                            .frame(width: 20, height: 20)
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 10, height: 10)
                    }
                    .shadow(color: .blue.opacity(0.5), radius: 5)
                }
            }
            
            // Moment markers
            ForEach(moments) { moment in
                Annotation("", coordinate: moment.coordinate) {
                    Button(action: { onMomentTapped?(moment) }) {
                        ZStack {
                            Circle()
                                .fill(.purple)
                                .frame(width: 30, height: 30)
                            
                            Image(systemName: "camera.fill")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .shadow(color: .purple.opacity(0.5), radius: 5)
                    }
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .onChange(of: routeSimulator.currentCoordinate.latitude) { _, _ in
            updateCamera()
        }
    }
    
    private func updateCamera() {
        if isActive {
            withAnimation(.easeInOut(duration: 0.3)) {
                cameraPosition = .region(MKCoordinateRegion(
                    center: routeSimulator.currentCoordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                ))
            }
        }
    }
}

#Preview {
    WorkoutMapView(
        routeSimulator: RouteSimulator(),
        moments: [],
        isActive: true,
        showFullRoute: true
    )
}
