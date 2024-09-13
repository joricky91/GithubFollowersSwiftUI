//
//  GFButton.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct GFButton: View {
    private var title: String
    private var systemImage: String
    private var tintColor: Color
    
    init(title: String, systemImage: String, tintColor: Color) {
        self.title = title
        self.systemImage = systemImage
        self.tintColor = tintColor
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            HStack {
                Image(systemName: systemImage)
                
                Text(title)
                    .frame(height: 48)
            }
            .font(.title3)
            .foregroundStyle(tintColor)
            
            Spacer()
        }
        .background(tintColor.opacity(0.2))
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    GFButton(title: "Test Button", systemImage: "person.2", tintColor: .red)
}
