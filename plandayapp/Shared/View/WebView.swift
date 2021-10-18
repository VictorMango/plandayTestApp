//
//  WebView.swift
//  plandayapp (iOS)
//
//  Created by Victor Pedersen on 18/10/2021.
//

import SwiftUI
import SafariServices

struct WebView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
     
}
