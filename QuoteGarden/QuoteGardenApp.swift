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
    var body: some Scene {
        WindowGroup {
            checkIfOnboarded()
        }
    }
    func checkIfOnboarded() -> some View {
        if isOnBoardingCompleted == false {
            print("false")
            return AnyView(OnboardingView())
        } else {
            print("true")
            return AnyView(QuoteGenresView())
        }
     }
    }
