//
//  AutoHidingHeaderView.swift
//  NewsLetters
//
//  Created by Gokul P on 1/6/25.
//

import SwiftUI

struct AutoHidingHeaderView<Content: View, Header: View>: View {

    @ViewBuilder let content: Content
    @ViewBuilder let header: Header

    @State var headerHeight: CGFloat = 0
    @State var headerOffset: CGFloat = 0
    @State var lastHeaderOffset: CGFloat = 0
    @State var direction: SwipeDirections = .none
    @State var shiftOffset: CGFloat = 0
    @State var contentOffset: CGFloat = 0

    /// Add new state for tracking scroll gesture
    @GestureState private var isScrolling = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            content
                .padding(.top, headerHeight)
                .offsetY { previous, current in
                    contentOffset = current
                    if previous > current {
                        // UP
                        if direction != .up, current < 0 {
                            shiftOffset = current - headerOffset
                            direction = .up
                            lastHeaderOffset = headerOffset
                        }
                        let offset = current < 0 ? (current - shiftOffset) : 0
                        headerOffset = (-offset < headerHeight ? (offset < 0 ? offset : 0) : -headerHeight)
                    } else {
                        // Down
                        if direction != .down {
                            shiftOffset = current
                            direction = .down
                            lastHeaderOffset = headerOffset
                        }
                        let offset = lastHeaderOffset + (current - shiftOffset)
                        headerOffset = (offset > 0 ? 0 : offset)
                    }
                }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isScrolling) { _, state, _ in
                    state = true
                }
        )
        .onChange(of: isScrolling) { _, scrolling in
            if !scrolling && direction == .down {
                // When scrolling stops, check if header is partially visible
                if contentOffset + headerHeight <= 0 {
                    if headerOffset < 0, headerOffset > -headerHeight {
                        withAnimation(.easeOut(duration: 0.2)) {
                            // Hide the header if it's partially visible
                            headerOffset = -headerHeight
                            direction = .none
                        }
                    }
                }
            }
        }
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .top) {
            header
                .anchorPreference(key: HeaderBoundsKey.self, value: .bounds) { $0 }
                .overlayPreferenceValue(HeaderBoundsKey.self) { value in
                    GeometryReader { proxy in
                        if let anchor = value {
                            Color.clear
                                .onChange(of: proxy[anchor].height) { _, newHeight in
                                    // Update header height whenever the content size changes
                                    withAnimation(.easeInOut) {
                                        headerHeight = newHeight
                                    }
                                }
                                .onAppear {
                                    headerHeight = proxy[anchor].height
                                }
                        }
                    }
                }
                .offset(y: -headerOffset < headerHeight ? headerOffset : (headerOffset < 0 ? headerOffset : 0))
        }
        .ignoresSafeArea(.all, edges: .top)
    }

    @ViewBuilder
    func customHeader() -> some View {
        HStack {
            Image(systemName: "tv")
            Text("YouTube")
                .bold()
            Spacer()
            Image(systemName: "bell")
            Image(systemName: "magnifyingglass")
        }
        .frame(height: 50)
        .padding(.top, safeArea().top)
        .background {
            Color.red
                .ignoresSafeArea()
        }
        .padding(.top, -15)
        .padding(.horizontal)
    }

    @ViewBuilder
    func dummyThumbnails() -> some View {
        VStack {
            ForEach(1...10, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 250)
            }
        }
        .padding()
    }

}

#Preview {
    AutoHidingHeaderView(content: {
        VStack {
            ForEach(1...10, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 250)
            }
        }
        .padding()
    }, header: {
        HStack {
            Image(systemName: "tv")
            Text("YouTube")
                .bold()
            Spacer()
            Image(systemName: "bell")
            Image(systemName: "magnifyingglass")
        }
        .frame(height: 50)
        .padding(.top, 49)
        .background {
            Color.red
                .ignoresSafeArea()
        }
        .padding(.top, -15)
        .padding(.horizontal)
    })
}
