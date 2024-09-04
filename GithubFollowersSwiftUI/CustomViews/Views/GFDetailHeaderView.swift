//
//  GFDetailHeaderView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 22/08/24.
//

import SwiftUI

struct GFDetailHeaderView: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                AsyncImage(url: URL(string: user.avatarUrl)) { image in
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 90, height: 90)
                } placeholder: {
                    Image(.avatarPlaceholder)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .padding(.trailing, 12)
                
                VStack(alignment: .leading) {
                    Text(user.login)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(user.name ?? "")
                        .foregroundStyle(.secondary)
                    
                    Label(user.location ?? "No location available", systemImage: "mappin.and.ellipse")
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            
            Text(user.bio ?? "No bio available")
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
}

#Preview {
    GFDetailHeaderView(user: User(login: "SAllen0400", avatarUrl: "https://avatars.githubusercontent.com/u/10645516?v=4", name: "Sean Allen", location: nil, bio: "iOS Developer lorem ipsum dolor sit amet", publicRepos: 4, publicGists: 14, htmlUrl: "https://github.com/SAllen0400", following: 0, followers: 2117, createdAt: Date()))
}
