import SwiftUI

struct MainView: View {
    @State private var currentQuote: Quote?
    @State private var isFavorite: Bool = false // État pour gérer le favori
    private let quotes = QuoteLoader.loadQuotes()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                // Zone pour afficher la citation
                VStack {
                    if let quote = currentQuote {
                        Text("“\(quote.quote)”")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .multilineTextAlignment(.center)
                        
                        // Commenté : HStack pour afficher l'auteur et le bouton cœur
                        /*
                        HStack {
                            Text("- \(quote.author)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Button(action: toggleFavorite) {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(isFavorite ? .red : .gray)
                                    .padding(.leading, 8)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Permet de mieux gérer les clics dans une HStack
                        }
                        .padding(.top, 8)
                        */
                    } else {
                        Text("Aucune citation disponible.")
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 300) // Fixe une hauteur minimale pour éviter que le bouton ne bouge
                .padding()

                Spacer() // Espace pour maintenir le bouton en bas

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
                .padding(.bottom, 20) // Marge en bas
            }
            .onAppear(perform: showRandomQuote)
            .padding()
            .navigationTitle("Motivation du Jour") // Titre pour la barre de navigation
        }
    }

    private func showRandomQuote() {
        currentQuote = quotes.randomElement()
        isFavorite = false // Réinitialise le favori lorsque la citation change
    }

    // Commenté : Fonction qui inverse l'état du favori
    /*
    private func toggleFavorite() {
        isFavorite.toggle() // Inverse l'état du favori
    }
    */
}
