//
//  News.swift
//  Planday App Interview
//
//  Created by Victor Pedersen on 16/10/2021.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct NewsAPIResponse: Decodable {
    let articles: [Article]?
    let status: String?
    let totalResults: Int?
    
    let code: String?
    let message: String?
}

struct Article {
    let author: String?
    let content: String?
    let description: String?
    let publishedAt: Date
    let source: Source
    let title: String?
    let url: String?
    let urlToImage: String?
    
    var authorText: String {
        author ?? ""
    }
    
    var publishedTimeSinceNow: String {
        "\(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var articleURL: URL {
        URL(string: url!)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

struct Source {
    let id: String?
    let name: String
}

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable {
    var id: String { url! }
}

extension Source: Codable {}
extension Source: Equatable {}
