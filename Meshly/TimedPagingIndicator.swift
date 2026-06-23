//
//  TimedPagingIndicator.swift
//  Meshly
//
//  Created by Дмитрий Чалов on 24.06.2026.
//

import SwiftUI

struct TimedPagingIndicator: View {
    var count: Int
    var duration: CGFloat
    var isPaused: Bool
    var activeTint: Color = .primary
    var inActiveTint: Color = .gray
    @Binding var selection: Int
    /// View Properties
    @State var startDate: Date = .now
    @State private var isTimelinePaused: Bool?
    var body: some View {
        TimelineView(.animation(paused: isTimelinePaused ?? isPaused)) { ctx in
            let diff = startDate.distance(to: ctx.date)
            let progress = max(min(diff / duration, 1), 0)
            let progressIndex: Int = Int(progress)

            HStack(spacing: 5) {
                ForEach(0..<count, id: \.self) { index in
                    let isActive = selection == index

                    Rectangle()
                        .fill(inActiveTint)
                        .overlay(alignment: .leading) {
                            if isActive {
                                Rectangle()
                                    .fill(activeTint)
                                    .scaleEffect(x: isPaused ? 1 : progress, anchor: .leading)
                            }
                        }
                        .frame(
                            width: isActive ? (isPaused ? 5 : 20) : 5,
                            height: 5
                        )
                        .clipShape(.capsule)
                }
            }
            .frame(maxHeight: .infinity)
            .onChange(of: progressIndex) { oldValue, newValue in
                if newValue == 1 {
                    updateIndex()
                }
            }
        }
        .frame(height: 10)
        .onChange(of: isPaused) {oldValue, newValue in
            startDate = .now
            isTimelinePaused = newValue
        }
        .onChange(of: selection) {oldValue, newValue in
            startDate = .now
        }
        .onAppear {
            isTimelinePaused = isPaused
        }
        .animation(animation, value: selection)
        .animation(animation, value: isPaused)

    }

    func updateIndex() {
        if selection == (count - 1) {
            selection = 0
        } else {
            let nextIndex = min(selection + 1, count - 1)
            selection = nextIndex
        }
    }

    var animation: Animation {
        .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
    }
}
