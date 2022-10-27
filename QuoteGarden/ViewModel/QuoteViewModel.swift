//
//  QuoteViewModel.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import Foundation

class QuoteViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    private var pagination: Pagination?
    let networkService: NetworkManager
    init(networkService: NetworkManager) {
        self.networkService = networkService
        self.isLoading = true
    }
    func getQuotes(page: Int, genre: String) {
        delay(seconds: 1) {
            let url = "https://quote-garden.herokuapp.com/api/v3/quotes?page=\(page)&genre=\(genre)"
            self.networkService.fetchRequest(urlString: url,
                                             httpMethod: .get,
                                             json: nil) { (result: Result<QuoteModel, Error>) in
                DispatchQueue.main.async { self.isLoading = false }
                switch result {
                case .success(let quoteResponse):
                    DispatchQueue.main.async {
                        self.quotes.append(contentsOf: quoteResponse.data.shuffled())
                        self.pagination = quoteResponse.pagination
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: "Ooops!", message: error.localizedDescription)}
                    print(error.localizedDescription)
                }
            }
        }
    }
    func fetchNextPage(genre: String) {
        var pageNo = 1
        if let nextPage =  self.pagination?.nextPage {
            if self.pagination?.currentPage == self.pagination?.totalPages {
                return
            } else {
                pageNo = nextPage
            }
        }
        print("\n\n\n Fetching Page: \(pageNo)")
        getQuotes(page: pageNo, genre: genre)
    }
}
