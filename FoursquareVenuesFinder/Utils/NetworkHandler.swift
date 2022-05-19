//
//  NetworkHandler.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import Foundation
import Network

class NetworkHandler {
    
    static let shared: NetworkHandler = NetworkHandler()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    var isConnected: Bool = false
    
    func trackNetworkStatus() {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
        monitor.start(queue: queue)
    }
}
