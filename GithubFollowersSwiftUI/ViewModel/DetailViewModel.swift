//
//  DetailViewModel.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 03/09/24.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var user: User?
    
    @Published var isFetching: Bool = false
    @Published var didError: Bool = false
    @Published var errorMessage: String = ""
    
    @MainActor func getUserDetail(username: String) {
        Task {
            do {
                isFetching = true
                let user: User = try await NetworkManager.shared.getResponseObject(url: "\(username)")
                self.user = user
                isFetching = false
            } catch {
                didError = true
                if let gfError = error as? GFError {
                    errorMessage = gfError.rawValue
                } else {
                    errorMessage = "Something went wrong. Please try again"
                }
                isFetching = false
            }
        }
    }
    
}
