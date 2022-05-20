//
//  RandomQuoteViewModel.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 14/05/2022.
//

import Foundation

class RandomQuoteViewModel: ObservableObject {
    @Published var randomQuote: Quote?
    private var pagination: Pagination?
    let networkService: NetworkManager
    init(networkService: NetworkManager) {
        self.networkService = networkService
        getRandomQuotes()
    }
    func getRandomQuotes() {
        let url = "https://quote-garden.herokuapp.com/api/v3/quotes/random"
        self.networkService.fetchRequest(urlString: url,
                                         httpMethod: .get,
                                         json: nil) {(result: Result<QuoteModel, Error>) in
            switch result {
            case .success(let quoteResponse):
                DispatchQueue.main.async {
                    self.randomQuote = quoteResponse.data.first
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
