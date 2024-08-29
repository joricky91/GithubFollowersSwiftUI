//
//  DetailView.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 22/08/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Text("Test")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
                }
        }
    }
}

#Preview {
    DetailView()
}
