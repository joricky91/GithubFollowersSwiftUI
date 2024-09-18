//
//  FollowerListView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct FollowerListView: View {
    @State private var page: Int = 1
    
    @State var follower: Follower? = nil
    @State var search: String = ""
    @State var shouldFetchFollowing: Bool = false

    @State var username: String = ""
    @State var newUsername: String = ""
    
    @EnvironmentObject var viewModel: GHViewModel
    
    var body: some View {
        gridView
        .navigationTitle("Followers")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addButtonTapped()
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
            getInitialData()
        }
        .onDisappear {
            viewModel.shouldFetch = true
            viewModel.hasMoreFollowers = true
        }
        .sheet(item: $follower, onDismiss: {
            getSelectedUsersFollowers()
        }, content: { foll in
            DetailView(shouldFetchFollowing: $shouldFetchFollowing, username: foll.login)
        })
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
                                    self.follower = follower
                                    self.newUsername = follower.login
                                }
                                .onAppear {
                                    viewModel.loadMoreContent(follower: follower, username: username)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

extension FollowerListView {
    func getInitialData() {
        if viewModel.shouldFetch {
            if !viewModel.followers.isEmpty {
                viewModel.page = 1
                viewModel.originalFollower.removeAll()
                viewModel.followers.removeAll()
            }
            
            viewModel.getFollowers(username: username)
            viewModel.shouldFetch = false
        }
    }
    
    func getSelectedUsersFollowers() {
        if shouldFetchFollowing {
            viewModel.page = 1
            viewModel.originalFollower.removeAll()
            viewModel.followers.removeAll()
            viewModel.getFollowers(username: newUsername)
        }
    }
    
    func addButtonTapped() {
        viewModel.getUserDetail(username: username) {
            if let user = viewModel.user {
                addUserToFavorites(user: user)
            }
        }
    }
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { error in
            guard let error else {
                DispatchQueue.main.async {
                    self.viewModel.didError = true
                    self.viewModel.errorTitle = "Success!"
                    self.viewModel.errorMessage = "You have successfully favorited this user"
                }
                return
            }
            
            DispatchQueue.main.async {
                self.viewModel.didError = true
                self.viewModel.errorTitle = "Something went wrong"
                self.viewModel.errorMessage = error.rawValue
            }
        }
    }
}

//#Preview {
//    FollowerListView()
//}
