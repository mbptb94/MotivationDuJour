//
//  Quote.swift
//  MotivationDuJour
//
//  Created by Yoann TOURTELLIER on 06/12/2024.
//

import Foundation

struct Quote: Decodable {
    let quote: String
    let author: String
}

class QuoteLoader {
    static func loadQuotes() -> [Quote] {
        guard let url = Bundle.main.url(forResource: "Citations", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let quotes = try? JSONDecoder().decode([Quote].self, from: data) else {
            return []
        }
        return quotes
    }
}
