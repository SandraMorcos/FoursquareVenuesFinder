//
//  PlacesResponse.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import Foundation

// MARK: - PlacesResponse
struct PlacesResponse: Codable {
    let results: [Place]
}




// MARK: - Place
struct Place: Codable {
    let fsqID: String
    let categories: [Category]?
    let geocodes: Geocodes
    let website: String?
    let location: Location
    let name: String
    let photos: [Photo]
    let price: Int?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case categories, geocodes, website, location, name, photos, price, rating
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    let icon: Icon
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String
    let suffix: String

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

// MARK: - Geocodes
struct Geocodes: Codable {
    let main: Center
    let roof: Center?
}

// MARK: - Center
struct Center: Codable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
    let address, country, crossStreet, formattedAddress: String?
    let locality, postcode, region: String?
    let neighborhood: [String]?
    
    enum CodingKeys: String, CodingKey {
        case address
        case country
        case crossStreet = "cross_street"
        case formattedAddress = "formatted_address"
        case locality
        case neighborhood
        case postcode
        case region
    }
    
}

// MARK: - Photo
struct Photo: Codable {
    let id, createdAt: String?
    let photoPrefix: String
    let suffix: String
    let width, height: Int?
    let classifications: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case photoPrefix = "prefix"
        case suffix, width, height, classifications
    }
}
