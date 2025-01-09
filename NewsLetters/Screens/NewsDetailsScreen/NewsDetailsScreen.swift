//
//  NewsDetailsScreen.swift
//  NewsLetters
//
//  Created by Gokul P on 1/9/25.
//

import SwiftUI

struct NewsDetailsScreen: View {
    let newsItem: NewsItem
    var body: some View {
        ScrollView {
            newsDetailsView
        }
    }
}

extension NewsDetailsScreen {
    var newsDetailsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(newsItem.heading)
                .font(.system(size: 25))
                .lineSpacing(5)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color(uiColor: .primaryText))

            HStack {
                Text("\(newsItem.timeToRead == 0 ? 1 : newsItem.timeToRead) min read")
                    .font(.callout)
                Text("•")
                    .font(.system(size: 25))
                Text(newsItem.category)
                    .font(.callout)
            }
            .foregroundColor(Color(uiColor: .primaryText).opacity(0.7))

            Text(newsItem.detailedNews)
                .font(.system(size: 19))
                .lineSpacing(5)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color(uiColor: .primaryText))

            Button(action: {}, label: {
                HStack {
                    Text("Read more >")
                        .font(.callout)
                        .foregroundStyle(Color(uiColor: .textColorBW))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background {
                            Capsule()
                                .fill(Color(uiColor: .fillColorWB))
                        }
                }
            })
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        NewsDetailsScreen(newsItem: NewsItem(
            category: "Technology",
            detailedNews: "Wallet drainer malware stole nearly $500 million in cryptocurrency from over 332,000 victims in 2024, a 67% increase from 2023. The highest activity was in Q1 with $187.2 million stolen, though the largest single theft ($55.48 million) occurred in August.",
            heading: "WALLET DRAINER MALWARE USED TO STEAL $500 MILLION IN CRYPTOCURRENCY IN 2024",
            link: "https://www.securityweek.com/wallet-drainer-malware-used-to-steal-500-million-in-cryptocurrency-in-2024/?utm_source=tldrinfosec",
            timeToRead: 2
        ))
    }
}
