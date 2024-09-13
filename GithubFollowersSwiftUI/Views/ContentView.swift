//
//  ContentView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var isPresented: Bool = false
    @State private var presentAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                TopView
                .padding()
                .padding(.top, 40)
                .toolbar(.hidden, for: .navigationBar)
                .navigationDestination(isPresented: $isPresented) {
                    FollowerListView(username: username)
                }
                
                if presentAlert {
                    AlertView(presentAlert: $presentAlert, title: "Empty Username", description: "Please enter a username, we need to know who to look for 😀!", buttonTitle: "Ok")
                }
            }
        }
    }
    
    @ViewBuilder
    private var TopView: some View {
        VStack {
            Image(.ghLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.bottom, 20)
            
            GFTextField(username: $username, promptText: "Enter a username")
            
            Spacer()
            
            GFButton(title: "Get Followers", systemImage: "person.3", tintColor: .green)
                .onTapGesture {
                    if !username.isEmpty {
                        isPresented.toggle()
                    } else {
                        presentAlert = true
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
        }
    }
}

//#Preview {
//    ContentView()
//}
