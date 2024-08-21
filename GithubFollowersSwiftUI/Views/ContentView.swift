//
//  ContentView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    
    var body: some View {
        VStack {
            Image(.ghLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.bottom, 20)
            
            GFTextField(username: $username, promptText: "Enter a username")
            
            Spacer()
            
            GFButton(title: "Get Followers", systemImage: "person.3", tintColor: .green) {
                print(username)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding()
        .padding(.top, 40)
    }
}

#Preview {
    ContentView()
}
