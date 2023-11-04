//
//  HelperFunc.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 20/05/2022.
//

import Foundation
import SwiftUI

// A delay function
func delay(seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

enum ViewState <T> {
    case IDLE
    case LOADING
    case SUCCESS (response: T)
    case FAILURE (error: String)
}

/*
switch .stateMachine {
case .IDLE:
  

case .LOADING:
  
    
case .SUCCESS(let response):
  
    
case .FAILURE(let errorStr):
    
   
}
*/

struct HelperFunc {
    func makeGredient(color1: String, color2: String) -> some View {
        let color1 = Color( UIColor.hexStringToUIColor(hex: color1))
        let color2 = Color( UIColor.hexStringToUIColor(hex: color2))
        let gradient = Gradient(colors: [color1, color2])
        return LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
            .cornerRadius(10)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
