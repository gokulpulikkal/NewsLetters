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
        if viewModel.isLoading {
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
            .task {
               await viewModel.cacheLatestNewsItems()
            }
        } else {
            HomeScreen()
        }
    }
}

#Preview {
    LaunchView()
}
