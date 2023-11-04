//
//  QuoteGardenApp.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 13/05/2022.
//

import SwiftUI

@main
struct QuoteGardenApp: App {
    
    let isOnBoardingCompleted: Bool = UserDefaults.standard.bool(forKey: "isOnBoardingCompleted")
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            checkIfOnboarded()
            //QuoteView(tag: "famous-quotes")
        }
    }
    
    func checkIfOnboarded() -> some View {
        if isOnBoardingCompleted == false {
            print("false")
            return AnyView(OnboardingView())
        } else {
            print("true")
            return AnyView(QuoteGenresView().environment(\.managedObjectContext, persistenceController.container.viewContext))
            
            //return AnyView(QuotesBookmarkView().environment(\.managedObjectContext, persistenceController.container.viewContext))
            
        }
     }
    }

