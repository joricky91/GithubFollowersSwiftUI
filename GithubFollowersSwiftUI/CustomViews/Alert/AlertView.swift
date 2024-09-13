//
//  AlertView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct AlertView: View {
    @Binding var presentAlert: Bool
    var title: String
    var description: String
    var buttonTitle: String
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                
                Text(description)
                    .multilineTextAlignment(.center)
                
                GFButton(title: buttonTitle, systemImage: "checkmark.circle", tintColor: .red)
                .padding(.top)
                .onTapGesture {
                    presentAlert = false
                }
            }
            .padding()
            .background(.background)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white, lineWidth: 2))
            .padding()
            .padding(.horizontal)
        }
    }
}

#Preview {
    @State var presentAlert: Bool = true
    return AlertView(presentAlert: $presentAlert, title: "Test", description: "Lorem ipsum dolor sit amet", buttonTitle: "Ok")
}
