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
        gridView
        .navigationTitle("Followers")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $search, placement: .navigationBarDrawer, prompt: "Search followers")
        .onChange(of: search, { oldValue, newValue in
            viewModel.search(searchText: search)
        })
        .onAppear {
            if viewModel.shouldFetch {
                viewModel.getFollowers(username: username)
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
                    LazyVGrid(columns: GridItem().makeThreeColumn(), spacing: 20) {
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
            
            if viewModel.didError {
                AlertView(presentAlert: $viewModel.didError, title: "Bad stuff happened", description: viewModel.errorMessage, buttonTitle: "Ok")
            }
        }
    }
}

#Preview {
    FollowerListView()
}
