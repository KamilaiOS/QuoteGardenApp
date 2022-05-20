//
//  QuoteModel.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import Foundation
import SwiftUI

struct QuoteModel: Codable, Hashable {
    var statusCode: Int
    var message: String
    var pagination: Pagination
    var totalQuotes: Int
    var data: [Quote]
}

struct Quote: Codable, Hashable {
    var quoteText: String
    var quoteAuthor: String
    var quoteGenre: String
    var id: String
    private enum CodingKeys: String, CodingKey {
        case quoteText, id = "_id", quoteAuthor, quoteGenre
    }
}
