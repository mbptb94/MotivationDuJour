import SwiftUI

struct MainView: View {
    @State private var currentQuote: Quote?
    private let quotes = QuoteLoader.loadQuotes()

    var body: some View {
        NavigationView {
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
                                .scaleEffect(1.3) // Effet d'agrandissement pour l'icône
                                .animation(.easeInOut(duration: 0.3), value: quote.isFavorite) // Animation

                            Text(quote.isFavorite ? "Retirer des Favoris" : "Ajouter aux Favoris")
                                .foregroundColor(quote.isFavorite ? .red : .blue)
                                .font(.headline) // Police plus grosse
                                .padding(.leading, 8)
                        }
                        .padding()
                        .background(quote.isFavorite ? Color.red.opacity(0.2) : Color.white) // Fond coloré si favori
                        .cornerRadius(12)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5) // Ombre pour l'effet 3D
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)
                } else {
                    Text("Aucune citation disponible.")
                        .padding()
                }

                // Bouton pour obtenir une nouvelle citation
                Button(action: showRandomQuote) {
                    Text("Nouvelle citation")
                        .font(.headline)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)) // Dégradé pour le fond
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: .blue, radius: 10, x: 0, y: 5)
                }
                .padding(.top, 20)
                
                // Navigation vers les favoris
                NavigationLink(destination: FavorisView()) {
                    Text("Voir les Favoris")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: .green, radius: 10, x: 0, y: 5)
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
        // Toggle the favorite status
        currentQuote?.isFavorite.toggle()
    }
}
