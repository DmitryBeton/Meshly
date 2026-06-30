//
//  ContentView.swift
//  Meshly
//
//  Created by Дмитрий Чалов on 20.06.2026.
//

import SwiftUI

// Tab Items
enum AppTab: AnimatedTabSelectionProtocol {
    case call
    case notifications
    case settings

    var symbolImage: String {
        switch self {
        case .call: return "phone.down.waves.left.and.right"
        case .notifications: return "bell.badge"
        case .settings: return "gearshape.fill"
        }
    }

    var title: LocalizedStringKey {
        switch self {
        case .call: return L10n.TabBar.call
        case .notifications: return L10n.TabBar.notifications
        case .settings: return L10n.TabBar.settings
        }
    }
}

struct ContentView: View {
    @State private var activeTab: AppTab = .call
    var body: some View {
        AnimatedTabView(selection: $activeTab) {
            // can use the Native Tab just like the normal TabView
            Tab.init(AppTab.call.title, systemImage: AppTab.call.symbolImage, value: .call) {
                Text(L10n.TabBar.call)
            }

            Tab.init(AppTab.notifications.title, systemImage: AppTab.notifications.symbolImage, value: .notifications) {
                Text(L10n.TabBar.notifications)
            }

            Tab.init(AppTab.settings.title, systemImage: AppTab.settings.symbolImage, value: .settings) {
                SettingsView()
            }
        } effects: { tab in
            switch tab {
            case .call: [.bounce.up]
            case .notifications: [.wiggle]
            case .settings: [.rotate]
            }
        }
    }
}

#Preview {
    ContentView()
}
