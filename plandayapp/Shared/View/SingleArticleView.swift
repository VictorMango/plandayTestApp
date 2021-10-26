//
//  SingleArticleView.swift
//  plandayapp (iOS)
//
//  Created by Victor Pedersen on 18/10/2021.
//

import SwiftUI

struct SingleArticleView: View {
    
    @State var showingSheet = false
    let article: Article
    var body: some View {
            List {
                VStack(alignment: .leading, spacing: 0) {
                    AsyncImage(url: article.imageURL) { (state) in
                        switch state {
                        case .empty:
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure(let error):
                            HStack {
                                Spacer()
                                Text("\(error.localizedDescription)")
                                Spacer()
                            }
                            
                        @unknown default:
                            fatalError()
                        }
                    }
                    .frame(minHeight: 300, maxHeight: 300)
                    .background(.gray.opacity(0.1))
                    .clipped()
                    
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    Text("Written by: \(article.authorText)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("single-article-written-by-text")
                    Spacer()
                    Text(article.title ?? "No title")
                        .font(.headline)
                    Text(article.descriptionText)
                        .font(.subheadline)
                    Spacer()
                    
                }
                .padding([.horizontal, .bottom])
                .listRowSeparator(.hidden)
                
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "safari")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .sheet(isPresented: $showingSheet) {
                        WebView(url: article.articleURL)
                    }
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.horizontal, -20)
            
            .navigationTitle("\(Text(article.source.name)) | \(Text(article.publishedTimeSinceNow))")
            .navigationBarTitleDisplayMode(.inline)
    }
}
