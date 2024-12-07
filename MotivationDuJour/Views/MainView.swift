import SwiftUI

struct MainView: View {
    @State private var currentQuote: Quote?
    private let quotes = QuoteLoader.loadQuotes()
    
    var body: some View {
        NavigationView { // Ajout du NavigationView
            VStack {
                // Affichage de la citation
                if let quote = currentQuote {
                    Text("“\(quote.quote)”")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Text("- \(quote.author)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                    
                    // Bouton pour ajouter/retirer des favoris
                    Button(action: toggleFavorite) {
                        HStack {
                            Image(systemName: quote.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(quote.isFavorite ? .red : .gray)
                            Text(quote.isFavorite ? "Retirer des Favoris" : "Ajouter aux Favoris")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 10)
                } else {
                    Text("Aucune citation disponible.")
                }
                
                // Bouton pour obtenir une nouvelle citation
                Button(action: showRandomQuote) {
                    Text("Nouvelle citation")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                
                // Navigation vers les favoris
                NavigationLink(destination: FavorisView()) {
                    Text("Voir les Favoris")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
            .onAppear(perform: showRandomQuote)
            .padding()
            .navigationTitle("Motivation du Jour") // Titre pour la barre de navigation
        }
    }
    
    private func showRandomQuote() {
        currentQuote = quotes.randomElement()
    }
    
    private func toggleFavorite() {
        currentQuote?.isFavorite.toggle()
    }
}
