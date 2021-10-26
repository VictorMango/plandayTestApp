//
//  NewsAPIHandler.swift
//  plandayapp (iOS)
//
//  Created by Victor Pedersen on 17/10/2021.
//

import Foundation

enum APIFetchOption: String {
    case general = "Top Headlines"
    case sport = "Sports"
    case entertainment = "Entertainment"
    case technology = "Technology"
}

struct NewsAPIHandler {
    
    static let shared = NewsAPIHandler()
    private init() {}
    
    private let domain = "NewsAPI"
    private let apiKey = "1c32f6c84ea143288f2331fbbbbfa9f5"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from option: APIFetchOption?, custom: String?) async throws -> NewsAPIResponse {
        
        let url = generateURL(from: option, custom: custom)
        
        let (data, response) = try await session.data(from: url)
        
        #if DEBUG
        print("Data: \(data)")
        print("URL: \(url)")
        #endif
         
        guard let response = response as? HTTPURLResponse else {
            throw NSError(domain: domain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Bad Response"])
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
            
            #if DEBUG
            print("Status: \(String(describing: apiResponse.status))")
            #endif
            
            if apiResponse.status == "ok" {
                return apiResponse
            } else {
                throw generateError(description: apiResponse.message ?? "Bad Response")
            }
            
        default:
            throw generateError(description: "A server error occured")
        }
        
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateURL(from option: APIFetchOption?, custom: String?) -> URL {
        
        // Generating the URL from option if not nil else custom.
        var url: String!
        url = "https://newsapi.org/v2/"
        
        if let option = option {
            url += "top-headlines?country=us"
            switch option {
            case .general:
                break
            default:
                url += "&category=\(option.rawValue.lowercased())"
            }
            
        } else {
            if let custom = custom {
                url += "everything?qInTitle=\(String(custom.lowercased().removeAllWhitespaces()))"
            }
        }
        
        url += "&apiKey=\(apiKey)"

        return URL(string: url)!
        
    }
}
