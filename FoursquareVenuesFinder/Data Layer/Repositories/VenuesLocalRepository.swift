//
//  VenuesLocalRepository.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import UIKit
import CoreData

class VenuesLocalRepository {
    
    func fetch(completion: (Result<[VenueViewModel], CustomError>) -> Void) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = VenueEntity.fetchRequest()
            do {
                let models = try context.fetch(fetchRequest)
                var viewModels = [VenueViewModel]()
                for model in models {
                    let viewModel = VenueViewModel(venue: model)
                    viewModels.append(viewModel)
                }
                completion(.success(viewModels))
            } catch let error as NSError {
                completion(.failure(.customErrorMessage(message: "\(error.userInfo)")))
            }
        }
    }
    
    func store(viewModels: [VenueViewModel]) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let context = appDelegate.persistentContainer.viewContext
                for viewModel in viewModels {
                    let venue = VenueEntity(context: context)
                    venue.setup(viewModel: viewModel)
                }
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
}
