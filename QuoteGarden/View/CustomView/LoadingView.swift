//
//  LoadingView.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 20/05/2022.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            LottieView(name: "loading", loopMode: .loop)
                .frame(width: 250, height: 250)
        }
    }
}
