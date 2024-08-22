//
//  LoadingView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 22/08/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
            
            ProgressView()
                .tint(.white)
                .controlSize(.large)
        }
    }
}

#Preview {
    LoadingView()
}
