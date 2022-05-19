//
//  VenuesRepository.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import Foundation

class VenuesRepository {
    var radius = 500
    lazy var localRepository: VenuesLocalRepository = {
        return VenuesLocalRepository()
    }()
    
    func loadVenues(coordinates: String,
                    completion: @escaping (Result<[VenueViewModel], CustomError>)->Void) {
        
        guard NetworkHandler.shared.isConnected else {
            localRepository.fetch(completion: completion)
            return
        }
        
        DataLoader.shared.request(VenuesRequest.search(coordinates: coordinates, radius: radius),
                                  responseModel: PlacesResponse.self) { result in
            switch result {
            case .success(let model):
                if model.results.count == 5 || self.radius >= Constants.maxRadius {
                    let viewModels = model.results.map({VenueViewModel(venue: $0)})
                    self.localRepository.store(viewModels: viewModels)
                    completion(.success(viewModels))
                } else {
                    self.radius += 500
                    self.loadVenues(coordinates: coordinates,
                                    completion: completion)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
