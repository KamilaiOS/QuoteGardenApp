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
                .font(.body)
                .padding(8)
            HStack {
                Spacer()
                Text("by " + quote.quoteAuthor)
                    .font(.system(size: 15, weight: .light, design: .serif))
                    .padding(5)
            }.background(.gray.opacity(0.3))
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
        }
        .foregroundColor(.white)
        .padding(0)
        .background(makeGredient())
        .clipped()
    }
    func makeGredient() -> some View {
        return HelperFunc().makeGredient(color1: "#ee0979", color2: "#ff6a00" )
    }
}

struct QuoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyQuote = Quote(quoteText: "", quoteAuthor: "Leon Edel", quoteGenre: [], id: "")
        QuoteCardView(quote: dummyQuote).padding()
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
