//
//  OnboardingView.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 20/05/2022.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            PageOne()
            PageTwo()
        }
        .background(makeGredient())
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .ignoresSafeArea()
        .foregroundColor(.white)
    }
    private func makeGredient() -> some View {
        return HelperFunc().makeGredient(color1: "#ee0979", color2: "#ff6a00" )
    }
}

struct PageOne: View {
    @State private var showingSheet = false
    var body: some View {
        VStack {
            Text("Welcome to Quote Garden! \n I hope you will find joy!" )
                .fontWeight(.semibold)
                .font(.title)
                .padding(.horizontal)
            LottieView(name: "books", loopMode: .loop)
                .scaledToFit()
        }
    }
}

struct PageTwo: View {
    @State private var showingQuoteGenresView = false
    var body: some View {
        VStack {
            Spacer()
            Text("We give you Quote of the day to make you cheerful!" )
                .fontWeight(.semibold)
                .font(.title)
                .padding(.horizontal)
            LottieView(name: "bookmark", loopMode: .loop)
                .scaledToFit()
            Spacer()
            HStack {
                Spacer()
                Button("Done") {
                    UserDefaults.standard.set(true, forKey: "isOnBoardingCompleted")
                    showingQuoteGenresView.toggle()
                } .padding()
            }
        }.fullScreenCover(isPresented: $showingQuoteGenresView) {
            QuoteGenresView()
        }
    }
}
