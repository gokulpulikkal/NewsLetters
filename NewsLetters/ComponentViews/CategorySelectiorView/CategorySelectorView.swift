//
//  CategorySelectorView.swift
//  NewsLetters
//
//  Created by Gokul P on 1/7/25.
//

import SwiftUI

struct CategorySelectorView<T: Hashable>: View {
    // Properties
    let items: [T]
    @Binding var selectedItem: T
    let itemTitle: (T) -> String

    /// Namespace for matched geometry
    @Namespace private var animation

    init(
        items: [T],
        selectedItem: Binding<T>,
        itemTitle: @escaping (T) -> String
    ) {
        self.items = items
        self._selectedItem = selectedItem
        self.itemTitle = itemTitle
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        withAnimation(.spring(duration: 0.15)) {
                            selectedItem = item
                        }
                    }, label: {
                        Text(itemTitle(item))
                            .font(.callout)
                            .foregroundStyle(item == selectedItem ? Color(uiColor: .textColorBW) : Color(UIColor.label))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background {
                                if item == selectedItem {
                                    Capsule()
                                        .fill(Color(uiColor: .fillColorWB))
                                        .matchedGeometryEffect(id: "CATEGORY", in: animation)
                                }
                            }
                            .background {
                                Capsule()
                                    .stroke(Color(UIColor.label))
                            }
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    CategorySelectorView(
        items: ["All", "Fiction", "Science", "LifeStyle"],
        selectedItem: .constant("All"),
        itemTitle: { $0 }
    )
}
