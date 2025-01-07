//
//  ContentView.swift
//  NewsLetters
//
//  Created by Gokul P on 1/6/25.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        AutoHidingHeaderView(content: {
            dummyThumbnails()
        }, header: {
            customHeader()
        })
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
//        .frame(height: 50)
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
    ContentView()
}
