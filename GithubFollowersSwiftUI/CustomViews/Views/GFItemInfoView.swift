//
//  GFItemInfoView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 03/09/24.
//

import SwiftUI

enum ItemInfoType {
    case repos, gists, followers, following
}

struct GFItemInfoView: View {
    var type: ItemInfoType
    var value: Int
    
    var body: some View {
        VStack {
            Labels()
            Text("\(value)")
        }
        .fontWeight(.semibold)
    }
    
    func Labels() -> some View {
        switch type {
        case .repos:
            return Label("Public Repos", systemImage: "folder")
        case .gists:
            return Label("Public Gists", systemImage: "text.alignleft")
        case .followers:
            return Label("Followers", systemImage: "heart")
        case .following:
            return Label("Following", systemImage: "person.2")
        }
    }
}

#Preview {
    GFItemInfoView(type: .gists, value: 30)
}
