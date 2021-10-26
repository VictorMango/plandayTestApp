//
//  ArticleView.swift
//  plandayapp
//
//  Created by Victor Pedersen on 16/10/2021.
//

import SwiftUI

struct ArticleView: View {
    
    @State var currentCategory: APIFetchOption = .general
    @State var searchString: String = ""
    @StateObject var newsArticlesVM = NewsArticleViewModel()
        
    var body: some View {
        NavigationView {
            
            ListArticleView(articles: articles, title: currentCategory.rawValue)
            
            .refreshable {
                loadOfArticlesFromCategory(category: currentCategory, custom: nil)
            }
            
            .onAppear {
                loadOfArticlesFromCategory(category: currentCategory, custom: nil)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                         Menu(content: {
                             
                             Button {
                                 currentCategory = .general
                                 loadOfArticlesFromCategory(category: currentCategory, custom: nil)

                             } label: {
                                 Text("Top Headlines")
                             }
                             
                             Button {
                                 
                                 currentCategory = .sport
                                 loadOfArticlesFromCategory(category: currentCategory, custom: nil)

                             } label: {
                                 Text(APIFetchOption.sport.rawValue)
                             }
                             
                             Button {
                                 
                                 currentCategory = .technology
                                 loadOfArticlesFromCategory(category: currentCategory, custom: nil)

                             } label: {
                                 Text(APIFetchOption.technology.rawValue)
                             }
                             
                             Button {
                                 
                                 currentCategory = .entertainment
                                 loadOfArticlesFromCategory(category: currentCategory, custom: nil)

                             } label: {
                                 Text(APIFetchOption.entertainment.rawValue)
                             }
                            
                         }, label: {
                             
                             Image(systemName: "line.3.horizontal")
                                 .foregroundColor(.black)
                             
                         })
                }
            }
            .searchable(text: $searchString).accessibilityIdentifier("searchBar")
            .onChange(of: searchString) { value in
                if !value.isEmpty && value.count > 3 {
                    loadOfArticlesFromCategory(category: nil, custom: value)
                } else if value.isEmpty {
                    loadOfArticlesFromCategory(category: currentCategory, custom: nil)
                }
            }
        }
    }
                            
    private var articles: [Article] {
        if case let .success(articles) = newsArticlesVM.state {
            return articles
        } else {
            return []
        }
    }
    
    private func loadOfArticlesFromCategory(category: APIFetchOption?, custom: String?) {
        async {
            await newsArticlesVM.loadArticles(from: category, custom: custom	)
        }
    }
}
