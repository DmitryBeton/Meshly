//
//  SettingsView.swift
//  Meshly
//

import SwiftUI
import UIKit

struct SettingsView: View {
    private let appSettingsURL = URL(string: UIApplication.openSettingsURLString)!

    var body: some View {
        NavigationStack {
            Form {
                Link(destination: appSettingsURL) {
                    HStack {
                        Label {
                            Text(L10n.Settings.language)
                        } icon: {
                            Image(systemName: "globe")
                        }

                        Spacer()

                        Image(systemName: "arrow.up.right.square")
                            .foregroundStyle(.secondary)
                    }
                }
                .foregroundStyle(.primary)
            }
            .navigationTitle(L10n.TabBar.settings)
        }
    }
}

#Preview {
    SettingsView()
}
