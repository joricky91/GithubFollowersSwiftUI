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
    
    let gridColumns: [GridItem] = Array.init(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    
    var body: some View {
        gridView
        .navigationTitle("Followers")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $search, placement: .navigationBarDrawer, prompt: "Search followers")
        .onAppear {
            if viewModel.shouldFetch {
                
                viewModel.getFollowers(username: username) {
                    
                } defaultErrorAction: {
                    
                }

                viewModel.shouldFetch = false
            }
        }
    }
    
    @ViewBuilder
    var gridView: some View {
        ZStack {
            if viewModel.followers.isEmpty, !viewModel.isFetching {
                ContentUnavailableView("No Followers", systemImage: "person.slash", description: Text("This user has no followers. Go follow them!"))
            } else {
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 20) {
                        ForEach(viewModel.followers, id: \.self) { follower in
                            FollowerView(follower: follower)
                                .onAppear {
                                    viewModel.loadMoreContent(follower: follower, username: username)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            if viewModel.isFetching {
                LoadingView()
            }
        }
    }
}

#Preview {
    FollowerListView()
}
