import SwiftUI

struct FavorisView: View {
    @Binding var favoriteQuotes: [Quote] // Liste des citations favorites passée depuis MainView
    
    var body: some View {
        VStack {
            Text("Citations Favoris")
                .font(.largeTitle)
                .padding()

            if favoriteQuotes.isEmpty {
                Text("Aucune citation favorite")
                    .font(.headline)
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(favoriteQuotes, id: \.quote) { quote in
                        VStack(alignment: .leading) {
                            Text("“\(quote.quote)”")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom, 4)
                            
                            Text("- \(quote.author)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    .onDelete(perform: deleteFavorite) // Ajoute l'action de suppression
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Favoris")
        Spacer()
    }

    private func deleteFavorite(at offsets: IndexSet) {
        favoriteQuotes.remove(atOffsets: offsets) // Supprime les citations à l'index donné
    }
}

struct FavorisView_Previews: PreviewProvider {
    static var previews: some View {
        FavorisView(favoriteQuotes: .constant([
            Quote(quote: "C'est la vie", author: "Auteur 1"),
            Quote(quote: "La liberté est précieuse", author: "Auteur 2")
        ]))
    }
}
