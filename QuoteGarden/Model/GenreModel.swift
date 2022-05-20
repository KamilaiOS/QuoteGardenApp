//
//  QuoteResponse.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import Foundation

struct GenreModel: Codable, Hashable {
    var statusCode: Int
    var message: String
    var data: [String]
}

struct Pagination: Codable, Hashable {
    var currentPage: Int
    var nextPage: Int?
    var totalPages: Int
}
