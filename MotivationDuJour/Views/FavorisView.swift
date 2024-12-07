import SwiftUI
import Foundation

struct FavorisView: View {
    @State private var favoriteQuotes: [Quote] = []

    var body: some View {
        List {
            ForEach(favoriteQuotes, id: \.quote) { quote in
                VStack(alignment: .leading) {
                    Text("“\(quote.quote)”")
                        .font(.headline)
                    Text("- \(quote.author)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .onDelete(perform: deleteQuote) // Appel à la méthode deleteQuote
        }
        .navigationTitle("Favoris")
        .onAppear(perform: loadFavorites)
    }

    private func loadFavorites() {
        let allQuotes = QuoteLoader.loadQuotes()
        let favoriteIDs = UserDefaults.standard.stringArray(forKey: "favoriteQuotes") ?? []
        favoriteQuotes = allQuotes.filter { favoriteIDs.contains($0.quote) }
    }

    private func deleteQuote(at offsets: IndexSet) {
        // Récupérer les indices des citations à supprimer
        for index in offsets {
            let quoteToDelete = favoriteQuotes[index]
            
            // Retirer la citation des favoris dans UserDefaults
            var favoriteQuotes = UserDefaults.standard.stringArray(forKey: "favoriteQuotes") ?? []
            if let index = favoriteQuotes.firstIndex(of: quoteToDelete.quote) {
                favoriteQuotes.remove(at: index)
            }
            UserDefaults.standard.set(favoriteQuotes, forKey: "favoriteQuotes")
            
            // Mettre à jour la liste affichée sans provoquer de "Index out of range"
            self.favoriteQuotes.remove(at: index)
        }
    }
}
