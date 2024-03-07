//
//  QuoteResponse.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import Foundation

struct Pagination: Codable, Hashable {
    var page: Int
    var nextPage: Int?
    var totalPages: Int
}

struct GenreModel: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var slug: String
    var quoteCount: Int
    private enum CodingKeys: String, CodingKey {
        case name, id = "_id", quoteCount, slug
    }
}



