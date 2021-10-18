//
//  NewsAPI.swift
//  plandayapp (iOS)
//
//  Created by Victor Pedersen on 18/10/2021.
//

import Foundation

enum DataStateFetch<T> {
    case empty
    case success(T)
    case failure(Error)
}
