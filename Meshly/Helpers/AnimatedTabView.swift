//
//  AnimatedTabView.swift
//  Meshly
//
//  Created by Дмитрий Чалов on 24.06.2026.
//

import SwiftUI

// Selection Protocol
protocol AnimatedTabSelectionProtocol: CaseIterable, Hashable {
    var title: LocalizedStringKey { get }
    var symbolImage: String { get }
}

struct AnimatedTabView<Selection: AnimatedTabSelectionProtocol, Content: TabContent<Selection>>:
    View {
    @Binding var selection: Selection
    @TabContentBuilder<Selection> var content: () -> Content
    var effects: (Selection) -> [any DiscreteSymbolEffect & SymbolEffect]
    // View Properties
    @State private var imageViews: [Selection: UIImageView] = [:]
    var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(.tabBarOnly)
        .background(ExtractImageViewsFromTabView {
            imageViews = $0
        })
        .compositingGroup()
        // Now we can animate the image view when the tab changes!
        .onChange(of: selection) { oldValue, newValue in
            let symbolEffects = effects(newValue)
            guard let imageView = imageViews[newValue] else { return }

            for effect in symbolEffects {
                imageView.addSymbolEffect(effect, options: .nonRepeating)
            }
        }
    }
}

fileprivate struct ExtractImageViewsFromTabView<Value: AnimatedTabSelectionProtocol>: UIViewRepresentable {
    var result: ([Value: UIImageView]) -> ()
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false

        DispatchQueue.main.async {
            if let compostingGroup = view.superview?.superview {
                guard let tabHostingController = compostingGroup.subviews.last else { return }
                guard let tabController = tabHostingController.subviews.first?.next as? UITabBarController else { return }

                extractImageViews(tabController.tabBar)
            }
        }

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    private func extractImageViews(_ tabBar: UITabBar) {
        let imageViews = tabBar.subviews(type: UIImageView.self)
        // Filtering out non Symbol Images!
            .filter({ $0.image?.isSymbolImage ?? false })
        // Filtering out active tinted images for iOS 26 Only!
            .filter({ isiOS26 ? ($0.tintColor == tabBar.tintColor) : true})

        var dict: [Value: UIImageView] = [:]

        for tab in Value.allCases {
            if let imageView = imageViews.first(where: {
                // Finding the associated image using the symbol name
                $0.description.contains(tab.symbolImage)
            }) {
                dict[tab] = imageView
            }
        }
        result(dict)
    }

    private var isiOS26: Bool {
        if #available(iOS 26, *) {
            return true
        }
        return false
    }
}

// Extracting All subview with the given type!
fileprivate extension UIView {
    func subviews<T: UIView>(type: T.Type) -> [T] {
        subviews.compactMap { $0 as? T } +
        subviews.flatMap { $0.subviews(type: type )}
    }
}

#Preview {
    ContentView()
}
