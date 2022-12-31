//
//  Text-HeaderStyle.swift
//  Countdown
//
//  Created by Yurii on 29.12.2022.
//

import SwiftUI

extension Text {
    func headerStyle() -> some View {
        self
            .font(.title3)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
    }
}
