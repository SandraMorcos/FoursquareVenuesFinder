//
//  DataLoader.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case generalError
    case parsingError
    case noInternetConnection
    case locationPermissionMissing
    case customErrorMessage(message: String)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .generalError:
            return "An Error Occured Please Try Again Later"
        case .parsingError:
            return "Invalid Data"
        case .noInternetConnection:
            return "Please Check if the Device is Connected to the Internet"
        case .locationPermissionMissing:
            return "Access to your location is necessary to provide you with suggested venues. Please enable Location Services from Settings"
        case .customErrorMessage(let message):
            return message
        }
    }
}

class DataLoader {
    static let shared = DataLoader()
    
    func request<Response: Codable>(_ request: Request,
                                           responseModel: Response.Type,
                                           then completion: @escaping (Result<Response, CustomError>)->Void) {
        guard let url = request.urlRequest() else {
            completion(.failure(.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.customErrorMessage(message: error.localizedDescription)))
            } else if let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode),
                      let data = data {
                do {
                    let model = try JSONDecoder().decode(responseModel, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(.parsingError))
                }
            } else {
                completion(.failure(.generalError))
            }
        }
        dataTask.resume()
    }
}
