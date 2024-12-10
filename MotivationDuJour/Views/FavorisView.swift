import SwiftUI

struct FavorisView: View {
    let favoriteQuotes: [Quote] // Liste des citations favorites

    var body: some View {
        VStack {
            if favoriteQuotes.isEmpty {
                Text("Aucune citation en favoris.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(favoriteQuotes, id: \.quote) { quote in
                    VStack(alignment: .leading) {
                        Text("“\(quote.quote)”")
                            .font(.body)
                            .padding(.bottom, 2)
                        
                        Text("- \(quote.author)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("Favoris")
        .padding()
    }
}
