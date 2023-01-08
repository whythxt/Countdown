//
//  Thread-Tests.swift
//  RideOrDie
//
//  Created by Yurii on 05.01.2023.
//

import SwiftUI

extension Thread {
    var isRunningXCTest: Bool {
        for key in self.threadDictionary.allKeys {
            guard let keyAsString = key as? String else {
                continue
            }

            if keyAsString.split(separator: ".").contains("xctest") {
                return true
            }
        }
        return false
    }
}
