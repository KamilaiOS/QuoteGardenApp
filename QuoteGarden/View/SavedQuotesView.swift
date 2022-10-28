//
//  SavedQuotesView.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 28/10/2022.
//

import SwiftUI

struct SavedQuotesView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    let quotesFetchRequest = QuoteCD.basicFetchRequest()
      var saveQuotes: FetchedResults<QuoteCD> {
          quotesFetchRequest.wrappedValue
      }
    
    var body: some View {
        ScrollView {
        ForEach(saveQuotes, id: \.self) { quote in
            let tempQuote = Quote(quoteText: quote.text ?? "",
                                  quoteAuthor: quote.author ?? "",
                                  quoteGenre: quote.genere ?? "",
                                  id: "00")
            QuoteCardView(quote: tempQuote).padding([.leading, .trailing], 8)
          }
        }
    }
}

struct SavedQuotesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedQuotesView()
    }
}
