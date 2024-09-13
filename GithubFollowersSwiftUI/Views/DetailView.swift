//
//  DetailView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 22/08/24.
//

import SwiftUI
import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

struct WebView: UIViewRepresentable {
    @State var url: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(url)
    }
}

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: DetailViewModel = DetailViewModel()
    
    @Binding var shouldFetchFollowing: Bool
    @State var presentWebview: Bool = false
    
    var username: String
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if let user = viewModel.user {
                    GFDetailHeaderView(user: user)
                    
                    GFDetailItemView(type: .repo, valueOne: user.publicRepos, valueTwo: user.publicGists, url: user.htmlUrl)
                    
                    GFDetailItemView(type: .info, valueOne: user.followers, valueTwo: user.following, url: "") {
                        shouldFetchFollowing = true
                        dismiss()
                    }
                    
                    Text("Github since \(user.createdAt.convertToMonthYearFormat())")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
            }
            .padding(.top)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        shouldFetchFollowing = false
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
