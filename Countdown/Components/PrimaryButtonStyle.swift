//
//  PrimaryButtonStyle.swift
//  Countdown
//
//  Created by Yurii on 29.12.2022.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .bold()
            .foregroundColor(.blue)
            .frame(width: 40, height: 40)
            .background(.regularMaterial)
            .cornerRadius(50)
    }
}
