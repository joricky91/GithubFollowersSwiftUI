//
//  MainView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: GHViewModel
    
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
        .overlay {
            if viewModel.isFetching {
                LoadingView()
            }
            
            if viewModel.didError {
                AlertView(presentAlert: $viewModel.didError, title: viewModel.errorTitle, description: viewModel.errorMessage, buttonTitle: "Ok")
            }
        }
    }
}

#Preview {
    MainView()
}
