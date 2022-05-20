//
//  EmptyStateView.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 20/05/2022.
//

import Foundation
import SwiftUI

struct EmptyStateView: View {
    let title: String
    let dec: String
    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            VStack {
                LottieView(name: "empty-box", loopMode: .loop)
                    .frame(width: 250, height: 250)
                Text(title)
                    .foregroundColor(.gray.opacity(0.8))
                    .fontWeight(.semibold)
                Text(dec)
                    .foregroundColor(.gray.opacity(0.6))
                    .fontWeight(.light)
            }
        }
    }
}
