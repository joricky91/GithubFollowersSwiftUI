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
    private var action: (() -> Void)
    
    init(title: String, systemImage: String, tintColor: Color, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.tintColor = tintColor
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Spacer()
            
            HStack {
                Image(systemName: systemImage)
                
                Text(title)
                    .frame(height: 44)
            }
            .font(.title3)
            
            Spacer()
        }
        .buttonStyle(.bordered)
        .tint(tintColor)
    }
}

#Preview {
    GFButton(title: "Test Button", systemImage: "person.2", tintColor: .red) {}
}
