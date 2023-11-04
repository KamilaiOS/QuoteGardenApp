//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import SwiftUI
import CoreData

struct QuoteGenresView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @StateObject var genreViewModel = QuoteGenreViewModel(networkService: NetworkService())
   
    var body: some View {
       
        switch genreViewModel.stateMachine {
            
        case .IDLE:
              EmptyStateView(title: "Oops!!", dec: "Nothing to show here...")
              .ignoresSafeArea()

        case .LOADING:
              LoadingView()
            
        case .SUCCESS(let quoteRes):
            
            NavigationStack {
                ScrollView {
                    RandomQuoteView(quoteVM: genreViewModel)
                    ListHeader()
                    QuoteGenresCellView(tags: quoteRes, viewContext: viewContext)
                    .navigationDestination(for: GenreModel.self, destination: { tag in
                        QuoteView(tag: tag.slug).environment(\.managedObjectContext,viewContext)
                    })
                    ListFooter()
                }.padding()
            }
            
        case .FAILURE(let errorStr):
              EmptyStateView(title: "Oops!!", dec: errorStr)
                .ignoresSafeArea()
           
        }
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


struct QuoteGenresCellView: View {
    
    var tags:[GenreModel]
    
    var viewContext: NSManagedObjectContext
    
    var body: some View {
        
        
       
            
            ForEach(tags, id: \.self) { tag in
                NavigationLink(value: tag, label: {
                    HStack {
                        Text(tag.name.capitalized)
                            .fontWeight(.light)
                        Spacer()
                        Text("Count: \(tag.quoteCount)")
                        
                        Text("➡︎")
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.5)))
                    .foregroundColor(.black)
                })
                
              }
            
            
            
        
        
        /*
        
        ForEach(tagModel, id: \.self) {  genre in
            NavigationLink(destination: QuoteView(tag: genre.name).environment(\.managedObjectContext,viewContext)) {
                HStack {
                    Text(genre.name.capitalized)
                        .fontWeight(.light)
                    Spacer()
                    Text("➡︎")
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.5)))
                .foregroundColor(.black)
            }
        }
        */

    }
}

struct RandomQuoteView: View {
    
   @ObservedObject var quoteVM: QuoteGenreViewModel
    
    var body: some View {
        VStack {
           
            QuoteCardView(quote: quoteVM.randomQuote)
                    .clipped()
                    .onTapGesture(count: 2) {
                        quoteVM.getRandomQuotes()
                    }
            
        }
    }
    
}
