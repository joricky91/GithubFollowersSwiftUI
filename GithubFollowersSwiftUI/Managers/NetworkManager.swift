//
//  NetworkManager.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"

    let decoder         = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy  = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getResponseList<T: Codable>(url: String) async throws -> [T] {
        let endpoint = baseURL + url
        
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
    
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            return try decoder.decode([T].self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
    
    func getResponseObject<T: Codable>(url: String) async throws -> T {
        let endpoint = baseURL + url
        
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
    
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
    
}
