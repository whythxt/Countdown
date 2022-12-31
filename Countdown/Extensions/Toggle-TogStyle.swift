//
//  Toggle-TogStyle.swift
//  Countdown
//
//  Created by Yurii on 29.12.2022.
//

import SwiftUI

extension Toggle {
    func togStyle() -> some View {
        self
            .font(.headline)
            .padding()
            .tint(.blue)
            .background {
                Rectangle()
                    .frame(height: 50)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .shadow(radius: 1)
            }
            .padding(.horizontal, 1)
    }
}
