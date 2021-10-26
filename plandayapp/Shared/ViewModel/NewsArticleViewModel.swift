//
//  NewsArticleViewModel.swift
//  plandayapp (iOS)
//
//  Created by Victor Pedersen on 17/10/2021.
//

import SwiftUI

@MainActor
class NewsArticleViewModel: ObservableObject {
    
    @Published var state = DataStateFetch<[Article]>.empty
    private let newsAPIHandler = NewsAPIHandler.shared
    
    init(articles: [Article]? = nil) {
        if let articles = articles {
            self.state = .success(articles)
        } else {
            self.state = .empty
        }
    }
    
    func loadArticles(from categories: APIFetchOption?, custom: String?) async {
        state = .empty
        do {
            let articles = try await newsAPIHandler.fetch(from: categories, custom: custom).articles!
            state = .success(articles)
        } catch {
            state = .failure(error)
        }
    }
    
}
