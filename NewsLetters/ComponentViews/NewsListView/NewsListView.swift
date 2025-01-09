//
//  NewsListView.swift
//  NewsLetters
//
//  Created by Gokul P on 1/9/25.
//

import SwiftUI

struct NewsListView: View {
    let newsItems: [NewsItem]
    var body: some View {
        LazyVStack(spacing: 18) {
            ForEach(newsItems) { item in
                NavigationLink(value: item, label: {
                    ZStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.heading)
                                .font(.headline)
                                .foregroundColor(Color(uiColor: .primaryText))
                                .lineLimit(2)

                            Text(item.detailedNews)
                                .font(.subheadline)
                                .foregroundColor(Color(uiColor: .primaryText).opacity(0.8))
                                .lineLimit(3)

                            HStack {
                                Text(item.category)
                                    .font(.caption)
                                    .foregroundColor(Color(uiColor: .primaryText).opacity(0.7))

                                Spacer()

                                Text("\(item.timeToRead == 0 ? 1 : item.timeToRead) min read")
                                    .font(.caption)
                                    .foregroundColor(Color(uiColor: .primaryText).opacity(0.7))
                            }
                        }
                        .padding()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(uiColor: .primaryAccent), lineWidth: 2)
                    )
                })
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewsListView(newsItems: [NewsItem(
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
        )])
    }
}
