//
//  RandomQuoteViewModel.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 14/05/2022.
//

import Foundation

class RandomQuoteViewModel: ObservableObject {

    @Published var stateMachine:ViewState<Quote> = .IDLE
    
    let networkService: NetworkManager
    
    init(networkService: NetworkManager) {
        self.networkService = networkService
        getRandomQuotes()
    }
    
    func getRandomQuotes() {
        let url = "https://api.quotable.io/random"
        
        self.stateMachine = .LOADING
        
        self.networkService.fetchRequest(urlString: url,
                                         httpMethod: .get,
                                         json: nil) {(result: Result<Quote, Error>) in
            switch result {
            case .success(let quoteResponse):
                DispatchQueue.main.async {
                    self.stateMachine = .SUCCESS(response: quoteResponse)
                }
            case .failure(let error):
                self.stateMachine = .FAILURE(error: error.localizedDescription)
            }
        }
    }
}
