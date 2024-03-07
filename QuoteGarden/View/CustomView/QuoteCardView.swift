//
//  QuoteCardView.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import SwiftUI

struct QuoteCardView: View {
    let quote: Quote
    var body: some View {
        VStack {
            Text("\"\(quote.quoteText)\"")

                .padding(8)
            HStack {
                Spacer()
                Text("by " + quote.quoteAuthor)
                  
                    .padding(5)
                   
            }.background(.gray.opacity(0.3))
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
        }
       // .font(.custom("BeautifulPeoplePersonalUse", size: 20))
        .font(.custom("Rustic Market", size: 20))
        .foregroundColor(.white)
        .padding(0)
        //.background(makeGredient())
        .clipped()
    }
    func makeGredient() -> some View {
        return HelperFunc().makeGredient(color1: "#ee0979", color2: "#ff6a00" )
    }
    
//    func getImage() -> some View {
//        
//    }
}

struct QuoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyQuote = Quote(quoteText: "", quoteAuthor: "Leon Edel", quoteGenre: [], id: "")
        QuoteCardView(quote: dummyQuote).padding()
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
