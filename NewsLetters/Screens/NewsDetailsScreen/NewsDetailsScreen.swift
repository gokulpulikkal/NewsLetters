//
//  NewsDetailsScreen.swift
//  NewsLetters
//
//  Created by Gokul P on 1/9/25.
//

import SwiftUI

struct NewsDetailsScreen: View {
    
    @State
    var viewModel: ViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            newsDetailsView
            VStack(alignment: .leading) {
                HStack {
                    Text("Realated")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(Color(uiColor: .primaryText))
                    Spacer()
                }
                NewsListView(newsItems: viewModel.getRelatedNewsItems())
            }
            .padding(.horizontal)
        }
    }
}

extension NewsDetailsScreen {
    var newsDetailsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.newsItem.heading)
                .font(.system(size: 25))
                .lineSpacing(5)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color(uiColor: .primaryText))

            HStack {
                Text("\(viewModel.newsItem.timeToRead == 0 ? 1 : viewModel.newsItem.timeToRead) min read")
                    .font(.callout)
                Text("•")
                    .font(.system(size: 25))
                Text(viewModel.newsItem.category)
                    .font(.callout)
            }
            .foregroundColor(Color(uiColor: .primaryText).opacity(0.7))

            Text(viewModel.newsItem.detailedNews)
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
            .padding(.vertical)
        }
        .padding()
    }
}

#Preview {
    NewsDetailsScreen(viewModel: NewsDetailsScreen.ViewModel(newsItem: NewsItem(
        category: "Technology",
        detailedNews: "Wallet drainer malware stole nearly $500 million in cryptocurrency from over 332,000 victims in 2024, a 67% increase from 2023. The highest activity was in Q1 with $187.2 million stolen, though the largest single theft ($55.48 million) occurred in August.",
        heading: "WALLET DRAINER MALWARE USED TO STEAL $500 MILLION IN CRYPTOCURRENCY IN 2024",
        link: "https://www.securityweek.com/wallet-drainer-malware-used-to-steal-500-million-in-cryptocurrency-in-2024/?utm_source=tldrinfosec",
        timeToRead: 2
    ), relatedNewsItems: [
        NewsItem(
            category: "Technology",
            detailedNews: "Wallet drainer malware stole nearly $500 million in cryptocurrency from over 332,000 victims in 2024, a 67% increase from 2023. The highest activity was in Q1 with $187.2 million stolen, though the largest single theft ($55.48 million) occurred in August.",
            heading: "WALLET DRAINER MALWARE USED TO STEAL $500 MILLION IN CRYPTOCURRENCY IN 2024",
            link: "https://www.securityweek.com/wallet-drainer-malware-used-to-steal-500-million-in-cryptocurrency-in-2024/?utm_source=tldrinfosec",
            timeToRead: 2
        ),
        NewsItem(
            category: "Technology",
            detailedNews: "Gokul Is great ksjdfn bklsdjfbnkaejfnbgka",
            heading: "Gokul USED TO STEAL $500 MILLION IN CRYPTOCURRENCY IN 2024",
            link: "https://www.securityweek.com/wallet-drainer-malware-used-to-steal-500-million-in-cryptocurrency-in-2024/?utm_source=tldrinfosec",
            timeToRead: 6
        ),
        NewsItem(
            category: "Technology",
            detailedNews: "sijhfnbglsijdfnbvlsfjngbliwjsrngbilsgjnedblijsfgibjsrigkbjnsikbgjiskgr",
            heading: "onakefjnvksdjfnmvikwsnfkbvjnkidfgjnbkvjdnfgbkvjrndfgkjbnvied",
            link: "https://www.securityweek.com/wallet-drainer-malware-used-to-steal-500-million-in-cryptocurrency-in-2024/?utm_source=tldrinfosec",
            timeToRead: 2
        )
    ]))
}
