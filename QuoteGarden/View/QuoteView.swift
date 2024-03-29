//
//  QuoteView.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import SwiftUI

struct QuoteView: View {
    let genres: String
    @StateObject var quoteViewModel = QuoteViewModel(networkService: NetworkService())
    var body: some View {
        ZStack {
            if quoteViewModel.isLoading == true {
                LoadingView()
            } else {
                setupQuoteView()
            }
        }.onAppear {
            quoteViewModel.getQuotes(page: 1, genre: genres)
        }
    }
    func setupQuoteView() -> some View {
        let gridItem = [ GridItem(.flexible(), spacing: 8)]
        return ScrollView {
            LazyVGrid(columns: gridItem, spacing: 10) {
                ForEach(quoteViewModel.quotes, id: \.self) { quote in
                    QuoteCardView(quote: quote).padding([.leading, .trailing], 8)
                }
                if quoteViewModel.quotes.count > 1 {
                    Button(action: loadMoreQuotes) {
                        Text("Load More \(genres.capitalized) Quotes")
                    }
                }
            }
        }
        .navigationTitle("Genre: \(genres.capitalized)")
        .alert(item: $quoteViewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: .default(Text("OK")))
        }
    }
    func loadMoreQuotes() {
        quoteViewModel.fetchNextPage(genre: genres)
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(genres: "")
    }
}
