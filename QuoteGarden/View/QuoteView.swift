//
//  QuoteView.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import SwiftUI

struct QuoteView: View {
    
   @Environment(\.managedObjectContext) var viewContext
    
//    let quotesFetchRequest = QuoteCD.basicFetchRequest()
//      var saveQuotes: FetchedResults<QuoteCD> {
//          quotesFetchRequest.wrappedValue
//      }
    
    let tag: String
   
    @StateObject var quoteViewModel = QuoteViewModel(networkService: NetworkService())
    
    var body: some View {
        
        
        switch quoteViewModel.stateMachine {
        case .IDLE:
            LoadingView()
                .onAppear {
                    quoteViewModel.fetchQuotes(tag: tag)
                    
                }
                
            .ignoresSafeArea()

        case .LOADING:
             LoadingView()
                
                .ignoresSafeArea()
                
            
        case .SUCCESS(let quotes):
            setupQuoteView(quotes: quotes)
                
            
        case .FAILURE(let errorStr):
            EmptyStateView(title: "Oops!!", dec: errorStr)
               
              .ignoresSafeArea()
           
        }
        
        
        
        
        /*
        
        ZStack {
            if quoteViewModel.isLoading == true {
                LoadingView()
            } else {
                setupQuoteView()
            }
        }.onAppear {
            quoteViewModel.getQuotes(page: 1, genre: genres)
        }
        */
        
    }
    func setupQuoteView(quotes: [Quote]) -> some View {
        let gridItem = [ GridItem(.flexible(), spacing: 8)]
        return ScrollView {
            LazyVGrid(columns: gridItem, spacing: 10) {
                ForEach(quotes, id: \.self) { quote in
                    QuoteCardView(quote: quote).padding([.leading, .trailing], 8)
                        .onTapGesture {
                           saveQuote(quote: quote)
                            //fetchQuoteCD()
                        }
                }
                if quotes.count > 1 && quoteViewModel.totalQuoteCount != quotes.count {
                    Button (action: {
                        loadMoreQuotes()
                    }, label: {
                        Text("Load More \(tag.capitalized) Quotes")
                    })
                }
            }
        }
        .navigationTitle("Genre: \(tag.capitalized)")
    }
    
    func loadMoreQuotes() {
        quoteViewModel.fetchNextPageQuotes(tag: tag)
    }
    
    func saveQuote(quote: Quote) {
        
    QuoteCD.saveQuote(text: quote.quoteText,
                      author: quote.quoteAuthor,
                      genere: tag,
                      using: self.viewContext)
    }
    
    func fetchQuoteCD() {
       
//        for quote in saveQuotes {
//            print(quote.text ?? "")
//        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(tag: "")
    }
}
