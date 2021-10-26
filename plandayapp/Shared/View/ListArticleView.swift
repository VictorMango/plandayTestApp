//
//  ListArticleView.swift
//  plandayapp (iOS)
//
//  Created by Victor Pedersen on 17/10/2021.
//

import SwiftUI

struct ListArticleView: View {
    
    let articles: [Article]
    var title: String!
    @State private var selectedArticle: Article?
    
    init(articles: [Article], title: String) {
        self.articles = articles
        self.title = title
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
           .edgesIgnoringSafeArea(.vertical)
           .overlay(
                List {
                    ForEach(articles) { article in
                        
                        ZStack {
                                
                            RowArticleView(article: article)
                    
                            NavigationLink(destination: SingleArticleView(article: article)) {
                                EmptyView()
                            }.opacity(0)
                                
                        }
                        
                        Divider()
                    }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                    .navigationBarTitle(Text(title))
            )
    }
    
}
