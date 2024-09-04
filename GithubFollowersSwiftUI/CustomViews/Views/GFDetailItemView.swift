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
    var action: (() -> Void)
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                GFItemInfoView(type: self.type == .repo ? .repos : .followers,
                               value: valueOne)
                
                Spacer()
                
                GFItemInfoView(type: self.type == .repo ? .gists : .following,
                               value: valueTwo)
            }
            
            GFButton(title: self.type == .repo ? "Github Profile" : "Get Followers",
                     systemImage: self.type == .repo ? "person" : "person.3",
                     tintColor: self.type == .repo ? .purple : .green,
                     action: action)
        }
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(.rect(cornerRadius: 12))
        .padding(.horizontal)
    }
}

#Preview {
    GFDetailItemView(type: .repo, valueOne: 30, valueTwo: 20) {}
}
