//
//  L10n.swift
//  Meshly
//
//  Created by Дмитрий Чалов on 28.06.2026.
//


import Foundation

enum L10n {
    enum Onboarding {
        static let titlePageOne = String(localized: "onboarding.page1.title")
        static let subtitlePageOne = String(localized: "onboarding.page1.subtitle")

        static let titlePageTwo = String(localized: "onboarding.page2.title")
        static let subtitlePageTwo = String(localized: "onboarding.page2.subtitle")

        static let titlePageThree = String(localized: "onboarding.page3.title")
        static let subtitlePageThree = String(localized: "onboarding.page3.subtitle")
    }

    enum TabBar {
        static let call = String(localized: "tabbar.call")
        static let notifications = String(localized: "tabbar.notifications")
        static let settings = String(localized: "tabbar.settings")
    }
}
