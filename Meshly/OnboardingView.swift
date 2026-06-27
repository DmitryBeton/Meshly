//
//  OnboardingView.swift
//  Meshly
//
//  Created by Дмитрий Чалов on 21.06.2026.
//

import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let systemImage: String
}

struct OnboardingView: View {

    @State private var isPaused: Bool = false

    @AppStorage(AppStorageKey.didFinishOnboarding) private var didFinishOnboarding: Bool = false
    @State private var activeIndex = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "Сканируйте мир в 3D",
            subtitle: "Используйте LiDAR датчик для создания точных 3D-моделей объектов вокруг вас",
            systemImage: "viewfinder",
        ),
        OnboardingPage(
            title: "Делитесь находками",
            subtitle: "Публикуйте свои сканы и вдохновляйте сообщество на новые открытия",
            systemImage: "square.and.arrow.up",
        ),
        OnboardingPage(
            title: "Исследуйте вместе",
            subtitle: "Открывайте 3D-объекты других пользователей и создавайте общую коллекцию",
            systemImage: "person.3.fill",
        )
    ]

    private var topBar: some View {
        HStack {
            if activeIndex > 0 {
                Button("Назад") {
                    withAnimation(.spring()) {
                        activeIndex -= 1
                    }
                }
            }
            Spacer()

            if activeIndex < pages.count - 1 {
                Button("Пропустить") {
                    withAnimation(.spring()) {
                        activeIndex = pages.count - 1
                    }
                }
            }
        }
        .font(.headline)
        .padding()
    }

    @ViewBuilder
    private func pageView(_ page: OnboardingPage) -> some View {
        VStack(spacing: 18) {
            Spacer()

            Image(systemName: page.systemImage)
                .font(.system(size: 60, weight: .semibold))
                .symbolRenderingMode(.hierarchical)

            Text(page.title)
                .font(.system(size: 34, weight: .bold))

            Text(page.subtitle)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)

            Spacer()
        }
    }

    private var bottomBar: some View {
        VStack(spacing: 14) {
            TimedPagingIndicator(count: pages.count, duration: 5, isPaused: isPaused, selection: $activeIndex)

            Button {
                withAnimation(.spring()) {
                    if activeIndex < pages.count - 1 {
                        activeIndex += 1
                    } else {
                        didFinishOnboarding = true
                    }
                }
            } label: {
                Text(activeIndex < pages.count - 1 ? "Далее" : "Начать")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 16))
        }
        .padding()
    }

    var body: some View {
        VStack {
            topBar

            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(pages.indices, id: \.self) { index in
                        let page = pages[index]
                        pageView(page)
                            .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollPosition(id: .init(get: {
                return activeIndex
            }, set: {newIndex in
                guard let newIndex else { return }
                activeIndex = newIndex
            }), anchor: .center)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
            .onScrollPhaseChange { oldPhase, newPhase in
                isPaused = newPhase != .idle && newPhase != .animating
            }
            .animation(.easeInOut(duration: 0.25), value: activeIndex)

            bottomBar

        }
    }
}
