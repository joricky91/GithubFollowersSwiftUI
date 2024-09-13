//
//  GFDetailItemView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 03/09/24.
//

import SwiftUI

enum GFDetailItemViewType {
    case repo
    case info
}

struct GFDetailItemView: View {
    var type: GFDetailItemViewType
    var valueOne: Int
    var valueTwo: Int
    var url: String
    var action: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                GFItemInfoView(type: self.type == .repo ? .repos : .followers,
                               value: valueOne)
                
                Spacer()
                
                GFItemInfoView(type: self.type == .repo ? .gists : .following,
                               value: valueTwo)
            }
            
            if type == .repo {
                NavigationLink {
                    WebView(url: url)
                } label: {
                    GFButton(title: "Github Profile",
                             systemImage: "person",
                             tintColor: .purple)
                }
            } else {
                GFButton(title: "Get Followers",
                         systemImage: "person.3",
                         tintColor: .green)
                .onTapGesture {
                    action?()
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(.rect(cornerRadius: 12))
        .padding(.horizontal)
    }
}
//
//#Preview {
//    GFDetailItemView(type: .repo, valueOne: 30, valueTwo: 20) {}
//}
