//
//  FollowerListView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct FollowerListView: View {
    @State private var page: Int = 1
    @StateObject var viewModel: GHViewModel = GHViewModel()
    @State var search: String = ""
    
    var username: String = ""
    
    var body: some View {
        List {
            ForEach(viewModel.followers, id: \.self) { follower in
                Text(follower.login)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Followers")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $search, placement: .navigationBarDrawer, prompt: "Search followers")
        .onAppear {
            if viewModel.shouldFetch {
                viewModel.getFollowers(username: username, page: page) {
                    
                } defaultErrorAction: {
                    
                }

                viewModel.shouldFetch = false
            }
        }
    }
}

#Preview {
    FollowerListView()
}
