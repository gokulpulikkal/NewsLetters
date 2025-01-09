//
//  DarkModeToggleStyle.swift
//  NewsLetters
//
//  Created by Gokul P on 1/9/25.
//

import Foundation
import SwiftUI

struct DarkModeToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Capsule()
                .fill(Color(UIColor.fillColorWB))
                .frame(width: 60, height: 32)

            Circle()
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(radius: 1)
                .frame(width: 28, height: 28)
                .overlay {
                    ZStack {
                        Image(systemName: "sun.max.fill")
                            .font(.system(size: 14))
                            .opacity(configuration.isOn ? 0 : 1)

                        Image(systemName: "moon.fill")
                            .font(.system(size: 14))
                            .opacity(configuration.isOn ? 1 : 0)
                    }
                }
                .offset(x: configuration.isOn ? 14 : -14)
                .animation(.spring(), value: configuration.isOn)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                configuration.isOn.toggle()
            }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
}
