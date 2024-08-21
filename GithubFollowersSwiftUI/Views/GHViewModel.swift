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
    
    @MainActor func getFollowers(username: String, page: Int,
                                 gfErrorAction: (() -> Void)? = nil,
                                 defaultErrorAction: (() -> Void)? = nil) {
        Task {
            do {
                let url = "\(username)/followers?per_page=100&page=\(page)"
                let follower: [Follower] = try await NetworkManager.shared.getResponseList(url: url)
                followers = follower
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
            }
        }
    }
    
}
