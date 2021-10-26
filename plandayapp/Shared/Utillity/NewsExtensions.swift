//
//  NewsExtensions.swift
//  plandayapp (iOS)
//
//  Created by Victor Pedersen on 26/10/2021.
//

import SwiftUI

extension String {
    func removeAllWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
