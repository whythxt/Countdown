//
//  View-DismissKey.swift
//  ReTrack
//
//  Created by Yurii on 06.12.2022.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
