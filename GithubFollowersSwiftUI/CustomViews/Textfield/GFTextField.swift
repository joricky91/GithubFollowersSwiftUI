//
//  GFTextField.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 21/08/24.
//

import SwiftUI

struct GFTextField: View {
    @Binding var username: String
    var promptText: String
    
    @State private var isEditing: Bool = false
    private var isClear: Bool {
        return isEditing && !username.isEmpty
    }
    
    var body: some View {
        HStack {
            TextField("", text: $username, prompt: Text(promptText))
                .font(.title2)
                .multilineTextAlignment(.center)
                .autocorrectionDisabled()
                .onChange(of: username) {
                    isEditing = true
                }
                .padding(.trailing, isClear ? 16 : 0)
            
            if isClear {
                Button {
                    username = ""
                } label: {
                    Image(systemName: "multiply.circle.fill").foregroundColor(.secondary)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(alignment: .trailing)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.secondary, lineWidth: 2)
        }
        .padding()
    }
}

//#Preview {
//    GFTextField(username: <#Binding<String>#>, promptText: <#String#>)
//}
