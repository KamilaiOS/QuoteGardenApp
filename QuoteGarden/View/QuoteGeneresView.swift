//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import SwiftUI

struct QuoteGenresView: View {
    @ObservedObject var genreViewModel = QuoteGenreViewModel(networkService: NetworkService())
    @ObservedObject var randomQuoteViewModel = RandomQuoteViewModel(networkService: NetworkService())
    var body: some View {
        if genreViewModel.isLoading == true {
            LoadingView()
        } else {
            NavigationView {
                let alert = $genreViewModel.alertItem
                if genreViewModel.quoteGenres.count == 0 {
                    EmptyStateView(title: "Oops!!", dec: "Nothing to show here...")
                        .ignoresSafeArea()
                        .alert(item: alert) { aItem in
                            Alert(title: Text(aItem.title),
                                  message: Text(aItem.message),
                                  dismissButton: .default(Text("OK")))
                        }
                } else {
                    createQuoteGenresView()
                        .listStyle(.automatic)
                        .navigationTitle("Quote Generes")
                }
            }
        }
    }
    func createQuoteOfTheDayView() -> some View {
        // QuoteOfTheDay
        VStack {
            if let quote = randomQuoteViewModel.randomQuote {
                QuoteCardView(quote: quote)
                    .clipped()
                    .onTapGesture(count: 2) {
                        randomQuoteViewModel.getRandomQuotes()
                    }
            }
        }
    }
    func createQuoteGenresCell() -> some View {
        ForEach(genreViewModel.quoteGenres, id: \.self) { genre in
            NavigationLink(destination: QuoteView(genres: genre)) {
                HStack {
                    Text(genre.capitalized)
                        .fontWeight(.light)
                    Spacer()
                    Text("➡︎")
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.5)))
                .foregroundColor(.black)
            }
        }
    }
    func createQuoteGenresView() -> some View {
        ScrollView {
            createQuoteOfTheDayView().padding(8)
            ListHeader()
            createQuoteGenresCell()
            ListFooter()
            /*
             List {
             Section {
             createQuoteGenresCell()
             } header: {
             ListHeader()
             } footer: {
             ListFooter()
             }
             }
             */
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteGenresView()
    }
}

struct ListHeader: View {
    var body: some View {
        HStack {
            Text("Quote Genres").fontWeight(.medium)
            Spacer()
        }
    }
}

struct ListFooter: View {
    var body: some View {
        Text("Made By Kamila Anna Lech")
            .foregroundColor(.gray)
            .font(.footnote)
    }
}
