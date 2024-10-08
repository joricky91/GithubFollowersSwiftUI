//
//  Webview.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 18/09/24.
//

import SwiftUI
import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

struct WebView: UIViewRepresentable {
    @State var url: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(url)
    }
}

//#Preview {
//    WebView()
//}
