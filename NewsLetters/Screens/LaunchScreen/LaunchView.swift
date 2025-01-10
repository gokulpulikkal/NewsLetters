//
//  LaunchView.swift
//  NewsLetters
//
//  Created by Gokul P on 1/9/25.
//

import SwiftUI

struct LaunchView: View {

    @State private var viewModel = ViewModel()

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                splashScreen
                    .transition(.opacity)
                    .task {
                        await viewModel.cacheLatestNewsItems()
                    }
            } else {
                HomeScreen()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: viewModel.isLoading)
    }
}

extension LaunchView {

    var splashScreen: some View {
        VStack {
            Image(systemName: "newspaper.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .symbolEffect(.breathe, options: .repeat(.continuous))

            Text("Loading Newsletters...")
                .font(.system(size: 25, weight: .heavy))
                .foregroundColor(.gray)
                .padding(.top)
        }
    }
}

#Preview {
    LaunchView()
}
