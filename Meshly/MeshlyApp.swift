//
//  MeshlyApp.swift
//  Meshly
//
//  Created by Дмитрий Чалов on 20.06.2026.
//

import SwiftUI

@main
struct MeshlyApp: App {

    @AppStorage("didFinishOnboarding") private var didFinishOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if didFinishOnboarding {
                ContentView()
            } else {
                OnboardingView()
            }
        }
    }
}
