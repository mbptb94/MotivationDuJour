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

extension Quote {
    // Propriété calculée pour vérifier si la citation est un favori
    var isFavorite: Bool {
        get {
            let favoriteQuotes = UserDefaults.standard.stringArray(forKey: "favoriteQuotes") ?? []
            return favoriteQuotes.contains(quote)
        }
        set {
            var favoriteQuotes = UserDefaults.standard.stringArray(forKey: "favoriteQuotes") ?? []
            if newValue {
                if !favoriteQuotes.contains(quote) {
                    favoriteQuotes.append(quote)
                }
            } else {
                favoriteQuotes.removeAll { $0 == quote }
            }
            UserDefaults.standard.set(favoriteQuotes, forKey: "favoriteQuotes")
        }
    }
}
