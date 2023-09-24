//
//  SlapApp.swift
//  Slap
//
//  Created by Gilles Wittenberg on 22/08/2023.
//

import SwiftUI

@main
struct SlapApp: App {
    
    @AppStorage("DISPLAY_SETTINGS") private var displaySettings = true
    @AppStorage("AVERAGING_ALGORITHM") private var averagingAlgorithm = AverageAlgorithm.default
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                displaySettings: displaySettings,
                averagingAlgorithm: averagingAlgorithm
            )
        }
    }
}
