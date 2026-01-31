//
//  TimelineView.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import SwiftUI

/// Timeline view for displaying workout moments in recap
struct TimelineView: View {
    let moments: [Moment]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(moments.enumerated()), id: \.element.id) { index, moment in
                HStack(alignment: .top, spacing: 16) {
                    // Timeline line and dot
                    VStack(spacing: 0) {
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 12, height: 12)
                        
                        if index < moments.count - 1 {
                            Rectangle()
                                .fill(Color.purple.opacity(0.3))
                                .frame(width: 2)
                                .frame(maxHeight: .infinity)
                        }
                    }
                    .frame(width: 12)
                    
                    // Moment content
                    VStack(alignment: .leading, spacing: 8) {
                        Text(moment.timestamp.formatted(date: .omitted, time: .shortened))
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                        
                        if let image = moment.getImage() {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.1))
                                .frame(height: 150)
                                .overlay(
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundColor(.white.opacity(0.3))
                                )
                        }
                    }
                    .padding(.bottom, index < moments.count - 1 ? 24 : 0)
                }
            }
        }
    }
}

#Preview {
    TimelineView(moments: [])
        .padding()
        .background(Color(red: 0.1, green: 0.1, blue: 0.2))
}
