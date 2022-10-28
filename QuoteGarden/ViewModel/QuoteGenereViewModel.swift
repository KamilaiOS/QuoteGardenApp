//
//  QuoteGenereViewModel.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import Foundation
import SwiftUI

class QuoteGenreViewModel: ObservableObject {
    @Published var quoteGenres: [String] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    private var networkService: NetworkManager
    init(networkService: NetworkManager) {
        self.networkService = networkService
        isLoading = true
        delay(seconds: 2) {
            self.getGenre()
        }
    }
    
    func getGenre() {
        let url = "https://quote-garden.herokuapp.com/api/v3/genres"
        networkService.fetchRequest(urlString: url,
                                    httpMethod: .get,
                                    json: nil) { (result: Result<GenreModel, Error>) in
            DispatchQueue.main.async {  self.isLoading = false }
            switch result {
            case .success(let genreResponse):
                DispatchQueue.main.async {
                    self.quoteGenres = genreResponse.data
                    print(self.quoteGenres.count)
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.alertItem = AlertItem(title: "Oops!", message: error.localizedDescription)
                }
            }
        }
    }
}
