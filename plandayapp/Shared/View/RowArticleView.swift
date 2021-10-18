//
//  RowArticleView.swift
//  plandayapp (iOS)
//
//  Created by Victor Pedersen on 17/10/2021.
//

import SwiftUI

struct RowArticleView: View {
    
    let article: Article
    var body: some View {
        VStack(alignment: .leading) {
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
                .frame(minHeight: 150, maxHeight: 150)
                .background(.gray.opacity(0.05))
                .clipped()
            
            Spacer()
            VStack (alignment: .leading) {
                Text("Published \(article.publishedTimeSinceNow) by: \(article.source.name)")
                    .font(.footnote)
                    .lineLimit(1)
                Spacer()
                Text(article.title!)
                    .font(.headline)
                    .lineLimit(2)
                Spacer()
            }
                .padding([.horizontal, .bottom])

        }
        
        .background(Color.black.opacity(0.1))
        .cornerRadius(radius: 15, corners: [.allCorners])

    }
}
