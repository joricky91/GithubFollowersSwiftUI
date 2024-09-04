//
//  DetailView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 22/08/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: DetailViewModel = DetailViewModel()
    
    private var username: String
    
    init(username: String) {
        self.username = username
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if let user = viewModel.user {
                    GFDetailHeaderView(user: user)
                    
                    GFDetailItemView(type: .repo, valueOne: user.publicRepos, valueTwo: user.publicGists) {
                        
                    }
                    
                    GFDetailItemView(type: .info, valueOne: user.followers, valueTwo: user.following) {
                        
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
        .onAppear {
            viewModel.getUserDetail(username: username)
        }
    }
}

//#Preview {
//    @StateObject var viewModel: GHViewModel = GHViewModel()
//    return DetailView(viewModel: viewModel)
//}
