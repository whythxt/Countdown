//
//  EnvironmentValues-Preview.swift
//  RideOrDie
//
//  Created by Yurii on 05.01.2023.
//

import SwiftUI

extension EnvironmentValues {
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment ["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
