//
//  GHViewModel.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import Foundation

class GHViewModel: ObservableObject {
    
    @Published var followers: [Follower] = []
    @Published var shouldFetch: Bool = true
    @Published var isFetching: Bool = true
    @Published var hasMoreFollowers: Bool = true
    @Published var page: Int = 1
    
    func loadMoreContent(follower: Follower, username: String) {
        let thresholdIndex = followers.index(followers.endIndex, offsetBy: -1)
        if followers[thresholdIndex] == follower, hasMoreFollowers {
            page += 1
            Task {
                await getFollowers(username: username, gfErrorAction: {}, defaultErrorAction: {})
            }
        }
    }
    
    @MainActor func getFollowers(username: String,
                                 gfErrorAction: (() -> Void)? = nil,
                                 defaultErrorAction: (() -> Void)? = nil) {
        Task {
            do {
                isFetching = true
                let url = "\(username)/followers?per_page=100&page=\(page)"
                let follower: [Follower] = try await NetworkManager.shared.getResponseList(url: url)
                followers.append(contentsOf: follower)
                isFetching = false
                
                if follower.count < 100 {
                    hasMoreFollowers = false
                }
            } catch {
                if let gfError = error as? GFError {
                    gfErrorAction?()
//                    presentGFAlert(title: "Bad Stuff Happened", message: gfError.rawValue, buttonTitle: "Ok")
                    print("Error found \(gfError)")
                } else {
                    defaultErrorAction?()
//                    presentDefaultError()
                    print("Error found \(error.localizedDescription)")
                }
                isFetching = false
            }
        }
    }
    
}
