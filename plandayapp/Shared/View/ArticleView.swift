//
//  ArticleView.swift
//  plandayapp
//
//  Created by Victor Pedersen on 16/10/2021.
//

import SwiftUI

struct ArticleView: View {
    
    @StateObject var newsArticlesVM = NewsArticleViewModel()
    
    var body: some View {
        NavigationView {
            ListArticleView(articles: articles)
            
            .refreshable {
                loadArticles()
            }
            
            .onAppear {
                loadArticles()
            }
        }
    }
                            
    private var articles: [Article] {
        if case let .success(articles) =
            newsArticlesVM.state {
            return articles
        } else {
            return []
        }
    }
    
    private func loadArticles() {
        async {
            await newsArticlesVM.loadArticles()
        }
    }
                
}
