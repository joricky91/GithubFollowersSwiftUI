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
    
    @State var presentDetail: Bool = false
    @State var search: String = ""
    var username: String = ""
    
    var body: some View {
        gridView
        .navigationTitle("Followers")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.getUserDetail(username: username)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search followers")
        .onChange(of: search) { _, _ in
            viewModel.search(searchText: search)
        }
        .onAppear {
            if viewModel.shouldFetch {
                viewModel.getFollowers(username: username)
                viewModel.shouldFetch = false
            }
        }
        .sheet(isPresented: $presentDetail) {
            DetailView()
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
                                .onTapGesture {
                                    presentDetail = true
                                }
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
