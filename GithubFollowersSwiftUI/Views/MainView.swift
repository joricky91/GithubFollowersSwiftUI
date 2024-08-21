//
//  MainView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            FavoriteListView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
        .tint(.green)
    }
}

#Preview {
    MainView()
}
