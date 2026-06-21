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

    @AppStorage("didFinishOnboarding") private var didFinishOnboarding: Bool = false
    @State private var index = 0

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
            if index > 0 {
                Button("Назад") {
                    withAnimation(.spring()) {
                        index -= 1
                    }
                }
            }
            Spacer()

            if index < pages.count - 1 {
                Button("Пропустить") {
                    withAnimation(.spring()) {
                        index = pages.count - 1
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

    private var progressPills: some View {
        HStack(spacing: 8) {
            ForEach(pages.indices, id: \.self) { i in
                Capsule()
                    .frame(width: i == index ? 22: 8, height: 8)
                    .animation(.spring(), value: index)
                    .foregroundStyle(.secondary.opacity(i == index ? 1 : 0.35))
            }
        }
        .padding(.top, 4)
    }

    private var bottomBar: some View {
        VStack(spacing: 14) {
            progressPills

            Button {
                withAnimation(.spring()) {
                    if index < pages.count - 1 {
                        index += 1
                    } else {
                        didFinishOnboarding = true
                    }
                }
            } label: {
                Text(index < pages.count - 1 ? "Далее" : "Начать")
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

            TabView(selection: $index) {
                ForEach(pages.indices, id: \.self) { i in
                    pageView(pages[i])
                        .tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            bottomBar

        }
    }
}
