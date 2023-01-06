//
//  ViewModel.swift
//  Countdown
//
//  Created by Yurii on 06.01.2023.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var events = [Event]()
    @Published var relation: Relation?
}
