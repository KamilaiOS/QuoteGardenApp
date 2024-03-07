//
//  QuoteModel.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import Foundation
import SwiftUI

struct QuoteModel: Codable, Hashable {
    var count: Int
    var page: Int
    var totalCount: Int
    var totalPages: Int
    var results: [Quote]
}

struct Quote: Codable, Hashable {
    var quoteText: String
    var quoteAuthor: String
    var quoteGenre: [String]
    var id: String
    private enum CodingKeys: String, CodingKey {
        case quoteText = "content", id = "_id", quoteAuthor = "author", quoteGenre = "tags"
    }
}
