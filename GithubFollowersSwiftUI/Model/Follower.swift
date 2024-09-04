//
//  Follower.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import Foundation

struct Follower: Codable, Hashable, Identifiable {
    var id: Int
    var login: String
    var avatarUrl: String
}
