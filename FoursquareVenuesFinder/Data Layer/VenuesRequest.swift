//
//  VenuesRequest.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import Foundation

enum VenuesRequest: Request {
    case nearby(coordinates: String)
    case search(coordinates: String, radius: Int)
    
    enum queryParams: String {
        case location = "ll"
        case limit
        case fields
        case radius
        case sort
    }
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.foursquare.com"
    }
    
    var endpoint: String {
        switch self {
        case .nearby:
            return "/v3/places/nearby"
        case .search:
            return "/v3/places/search"
        }
        
    }
    
    var params: [String: String] {
        switch self {
        case .nearby(let coordinates):
            return [queryParams.location.rawValue: coordinates,
                    queryParams.limit.rawValue: "5"]
        case .search(let coordinates, let radius):
            return [queryParams.location.rawValue: coordinates,
                    queryParams.limit.rawValue: "5",
                    queryParams.radius.rawValue: "\(radius)",
                    queryParams.sort.rawValue: "distance",
                    queryParams.fields.rawValue: "photos,name,location,fsq_id,location,categories,website,geocodes,rating,price"]
        }
    }
    
    var headers: [String: String] {
        return ["Authorization": Constants.apiKey]
    }

}
