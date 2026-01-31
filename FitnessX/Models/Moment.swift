//
//  Moment.swift
//  FitnessX
//
//  Created by Dinil Jayatunge on 2025-12-16.
//

import Foundation
import CoreLocation
import SwiftUI

/// Types of media that can be captured as moments
enum MediaType: String, Codable {
    case photo
    case video
}

/// Represents a captured moment during a workout
struct Moment: Identifiable, Codable {
    let id: UUID
    let timestamp: Date
    let coordinate: CLLocationCoordinate2D
    let mediaType: MediaType
    let imageName: String
    
    init(id: UUID = UUID(), timestamp: Date = Date(), coordinate: CLLocationCoordinate2D, mediaType: MediaType, imageName: String) {
        self.id = id
        self.timestamp = timestamp
        self.coordinate = coordinate
        self.mediaType = mediaType
        self.imageName = imageName
    }
    
    /// Get the image from documents directory
    func getImage() -> UIImage? {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagePath = documentsPath.appendingPathComponent(imageName)
        guard let data = try? Data(contentsOf: imagePath) else { return nil }
        return UIImage(data: data)
    }
    
    // MARK: - Codable conformance for CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case id, timestamp, latitude, longitude, mediaType, imageName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        timestamp = try container.decode(Date.self, forKey: .timestamp)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mediaType = try container.decode(MediaType.self, forKey: .mediaType)
        imageName = try container.decode(String.self, forKey: .imageName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(mediaType, forKey: .mediaType)
        try container.encode(imageName, forKey: .imageName)
    }
}
