//
//  Request.swift
//  FoursquareVenuesFinder
//
//  Created by Sandra Morcos on 19/05/2022.
//

import Foundation
protocol Request {
    var scheme: String { get }
    var host: String { get }
    var endpoint: String { get }
    var params: [String: String] { get }
    var headers: [String: String] { get }
    func urlRequest() -> URLRequest?
}

extension Request {
    func urlRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = endpoint
        var queryItems = [URLQueryItem]()
        for param in params {
            let queryItem = URLQueryItem(name: param.key, value: param.value)
            queryItems.append(queryItem)
        }
        components.queryItems = queryItems
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return urlRequest
    }
}
