//
//  GithubFollowersSwiftUIApp.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI
import Atlantis

@main
struct GithubFollowersSwiftUIApp: App {
    @StateObject var viewModel: GHViewModel = GHViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .onAppear {
                    Atlantis.start()
                }
        }
    }
}
