//
//  QuoteGenereViewModel.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import Foundation
import SwiftUI
import Observation

@Observable
class QuoteGenreViewModel: ObservableObject {

    var stateMachine:ViewState<[GenreModel]> = .IDLE
    
    var randomQuote:Quote = Quote(quoteText: "", quoteAuthor: "", quoteGenre: [""], id: "")
    
    let networkService: NetworkManager
    
    init(networkService: NetworkManager) {
        self.networkService = networkService
        getQuotesTags()
        getRandomQuotes()
    }
    
    func getQuotesTags() {
        let url = "https://api.quotable.io/tags"
        
        self.stateMachine = .LOADING
        
        self.networkService.fetchRequest(urlString: url,
                                         httpMethod: .get,
                                         json: nil) {(result: Result<[GenreModel], Error>) in
            switch result {
            case .success(let tagsResponse):
                
                let sortedArray = tagsResponse.sorted{$0.quoteCount > $1.quoteCount}
                DispatchQueue.main.async {
                    self.stateMachine = .SUCCESS(response:sortedArray)
                }
            case .failure(let error):
                self.stateMachine = .FAILURE(error: error.localizedDescription)
            }
        }
    }
    
    
    func getRandomQuotes() {
        let url = "https://api.quotable.io/random"
        
        
        
        self.networkService.fetchRequest(urlString: url,
                                         httpMethod: .get,
                                         json: nil) {(result: Result<Quote, Error>) in
            switch result {
            case .success(let quoteResponse):
                DispatchQueue.main.async {
                    self.randomQuote = quoteResponse
                }
            case .failure(let error):
                print(error.localizedDescription)
                //self.stateMachine = .FAILURE(error: error.localizedDescription)
            }
        }
        
    }
}

