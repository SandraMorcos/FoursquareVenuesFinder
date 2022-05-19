//
//  VenuesListViewModel.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import Foundation
import CoreLocation

class VenuesListViewModel {
    var dataSource: [VenueViewModel] = []
    private var repo = VenuesRepository()
    
    func loadVenues(location: CLLocation,  completion: @escaping (CustomError?)->Void) {
        let coordinates = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        repo.loadVenues(coordinates: coordinates) { result in
            switch result {
            case .success(let model):
                self.dataSource = model
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
