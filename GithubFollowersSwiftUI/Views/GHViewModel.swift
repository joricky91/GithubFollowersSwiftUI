//
//  GHViewModel.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import Foundation

class GHViewModel: ObservableObject {
    
    @Published var followers: [Follower] = []
    @Published var originalFollower: [Follower] = []
    @Published var shouldFetch: Bool = true
    @Published var isFetching: Bool = true
    @Published var hasMoreFollowers: Bool = true
    @Published var page: Int = 1
    
    @Published var didError: Bool = false
    @Published var errorMessage: String = ""
    
    func loadMoreContent(follower: Follower, username: String) {
        let thresholdIndex = followers.index(followers.endIndex, offsetBy: -1)
        if followers[thresholdIndex] == follower, hasMoreFollowers {
            page += 1
            Task {
                await getFollowers(username: username)
            }
        }
    }
    
    @MainActor func search(searchText: String) {
        shouldFetch = false
        isFetching = false
        
        if searchText.isEmpty {
            followers.removeAll()
            followers.append(contentsOf: originalFollower)
        } else {
            let filtered = originalFollower.filter { $0.login.lowercased().contains(searchText.lowercased()) }
            followers.removeAll()
            followers.append(contentsOf: filtered)
        }
    }
    
    @MainActor func getFollowers(username: String) {
        Task {
            do {
                isFetching = true
                let url = "\(username)/followers?per_page=100&page=\(page)"
                let follower: [Follower] = try await NetworkManager.shared.getResponseList(url: url)
                originalFollower.append(contentsOf: follower)
                followers.append(contentsOf: follower)
                isFetching = false
                
                if follower.count < 100 {
                    hasMoreFollowers = false
                }
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
