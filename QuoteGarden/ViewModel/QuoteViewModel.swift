//
//  QuoteViewModel.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import Foundation
import Observation

@MainActor
/*
class QuotennnViewModel: Observable {
     var quotes: [Quote] = []
     var alertItem: AlertItem?
     var isLoading = false
    private var pagination: Int?
    let networkService: NetworkManager
    init(networkService: NetworkManager) {
        self.networkService = networkService
        self.isLoading = true
    }
    
    func getQuotes(page: Int, genre: String) {
        delay(seconds: 1) {
            let url = "" //"https://quote-garden.herokuapp.com/api/v3/quotes?page=\(page)&genre=\(genre)"
            self.networkService.fetchRequest(urlString: url,
                                             httpMethod: .get,
                                             json: nil) { (result: Result<QuoteModel, Error>) in
                DispatchQueue.main.async { self.isLoading = false }
                switch result {
                case .success(let quoteResponse):
                    print("CALLED URL: \(url)")
                    DispatchQueue.main.async {
                        self.quotes.append(contentsOf: quoteResponse.results.shuffled())
                        self.pagination = quoteResponse.page
                    }
                case .failure(let error):
                    print("CALLED URL: \(url)")
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: "Ooops!", message: error.localizedDescription)}
                    print(error.localizedDescription)
                }
            }
        }
    }
//    func fetchNextPage(genre: String) {
//        var pageNo = 1
//        if let nextPage =  self.pagination?.nextPage {
//            if self.pagination?.currentPage == self.pagination?.totalPages {
//                return
//            } else {
//                pageNo = nextPage
//            }
//        }
//        print("\n\n\n Fetching Page: \(pageNo)")
//        getQuotes(page: pageNo, genre: genre)
//    }
}
 */

class QuoteViewModel: ObservableObject {
    
    @Published var stateMachine:ViewState<[Quote]> = .IDLE
    
    private var quotes: [Quote] = []
    var totalQuoteCount = 0
    private var pagination: Int = 0
    private var totalPages: Int = 0
    
    let networkService: NetworkManager
    
    init(networkService: NetworkManager) {
        self.networkService = networkService
    }
    
    private func getQuotes(tag: String) {
        
        pagination+=1
        
        delay(seconds: 1) {
            let url = "https://api.quotable.io/quotes?page=\(self.pagination)&tags=\(tag)"
            //let url = "https://newscatcherpi.com/latest_headlines&apikey=wjyhxr-mBQZo23zZoFB_s_fntAkLMJuj93jCwfr8_9k"
            self.networkService.fetchRequest(urlString: url,
                                             httpMethod: .get,
                                             json: nil) {(result: Result<QuoteModel, Error>) in
                switch result {
                case .success(let quoteResponse):
                    DispatchQueue.main.async {
                        self.totalPages = quoteResponse.totalPages
                        self.totalQuoteCount = quoteResponse.totalCount
                        self.quotes.append(contentsOf: quoteResponse.results)
        
                        self.stateMachine = .SUCCESS(response: self.quotes)
                        print("CALLED URL: \(url)")
                    }
                case .failure(let error):
                    self.stateMachine = .FAILURE(error: error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
     func fetchQuotes(tag: String) {
         self.stateMachine = .LOADING
         getQuotes(tag: tag)
    }
    
    
     func fetchNextPageQuotes(tag: String) {
        getQuotes(tag: tag)
    }
    
}

