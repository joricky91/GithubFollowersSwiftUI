//
//  FavoriteListView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct FavoriteListView: View {
    var body: some View {
        NavigationStack {
            Text("Favorites List View")
                .navigationTitle("Favorites")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    FavoriteListView()
}
