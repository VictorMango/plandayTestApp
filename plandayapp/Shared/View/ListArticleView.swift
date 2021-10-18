//
//  ListArticleView.swift
//  plandayapp (iOS)
//
//  Created by Victor Pedersen on 17/10/2021.
//

import SwiftUI

struct ListArticleView: View {
    
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    init(articles: [Article]) {
        self.articles = articles
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
                    .navigationBarTitle(Text("Newest News"))
            )
    }
    
}
