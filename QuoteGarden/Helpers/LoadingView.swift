//
//  LoadingStateCrimeInputView.swift
//  CrimeMapper
//
//  Created by Kamila Lech on 04/12/2022.
//

import SwiftUI

struct LoadingView: View {
   
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                //.stroke()
                 .frame(width: 150, height: 150)
                 .foregroundColor(.gray.opacity(0.3))
                 .shadow(radius: 15, x: 10, y: 15)
            ProgressView("Searching")
                .frame(width: 100, height: 100)
                 .padding(16)
                
            
        }
        

    }
}

struct LoadingStateCrimeInputView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}


    
