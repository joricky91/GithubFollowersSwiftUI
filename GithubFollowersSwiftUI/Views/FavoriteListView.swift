//
//  FavoriteListView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct FavoriteListView: View {
    @State var favorites: [Follower] = []
    @State var showDetail: Bool = false
    @State var username: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if favorites.isEmpty {
                    ContentUnavailableView("No Favorites", systemImage: "star", description: Text("Add a favorite on the follower list screen"))
                } else {
                    List {
                        ForEach(favorites, id: \.self) { favorite in
                            HStack {
                                AsyncImage(url: URL(string: favorite.avatarUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .clipShape(.rect(cornerRadius: 6))
                                } placeholder: {
                                    Image(.avatarPlaceholder)
                                }
                                .frame(width: 60, height: 60)
                                
                                Text(favorite.login)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .onTapGesture {
                                username = favorite.login
                                showDetail = true
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $showDetail) {
                FollowerListView(shouldFetchFollowing: true, username: username)
            }
        }
        .onAppear {
            getFavorites()
        }
    }
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case .failure(let error):
                DispatchQueue.main.async {
//                    self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
}

#Preview {
    FavoriteListView()
}
