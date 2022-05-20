//
//  AlertItem.swift
//  SwiftUI-MVVM
//
//  Created by Sean Allen on 5/24/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID().uuidString
    var title: String
    var message: String
}
