//
//  L10n.swift
//  Meshly
//
//  Created by Дмитрий Чалов on 28.06.2026.
//

import SwiftUI

enum L10n {
    enum Onboarding {
        static let titlePageOne: LocalizedStringKey = "onboarding.page1.title"
        static let subtitlePageOne: LocalizedStringKey = "onboarding.page1.subtitle"

        static let titlePageTwo: LocalizedStringKey = "onboarding.page2.title"
        static let subtitlePageTwo: LocalizedStringKey = "onboarding.page2.subtitle"

        static let titlePageThree: LocalizedStringKey = "onboarding.page3.title"
        static let subtitlePageThree: LocalizedStringKey = "onboarding.page3.subtitle"

        static let back: LocalizedStringKey = "onboarding.back"
        static let skip: LocalizedStringKey = "onboarding.skip"
        static let next: LocalizedStringKey = "onboarding.next"
        static let start: LocalizedStringKey = "onboarding.start"
    }

    enum TabBar {
        static let call: LocalizedStringKey = "tabbar.call"
        static let notifications: LocalizedStringKey = "tabbar.notifications"
        static let settings: LocalizedStringKey = "tabbar.settings"
    }

    enum Settings {
        static let language: LocalizedStringKey = "settings.language"
    }
}
