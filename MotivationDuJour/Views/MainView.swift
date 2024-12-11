import SwiftUI

struct MainView: View {
    @State private var currentQuote: Quote?
    private let quotes = QuoteLoader.loadQuotes()

    var body: some View {
        NavigationView {
            VStack {
                // Date du jour affichée discrètement
                               Text(Date.now, style: .date)
                                   .font(.footnote)
                                   .foregroundColor(.gray)
                                   .padding(.bottom, 8)

                               Spacer()
                
                // Zone pour afficher la citation
                VStack {
                    if let quote = currentQuote {
                        Text("“\(quote.quote)”")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .multilineTextAlignment(.center)
                        
                        // Affichage de l'auteur
                        Text("- \(quote.author)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                        
                        // Bouton de partage
                        HStack {
                            Spacer()
                            Button(action: {
                                shareQuote(quote: "“\(quote.quote)” - \(quote.author)")
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                            Spacer()
                        }
                        .padding(.top, 8)
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
    }

    private func shareQuote(quote: String) {
        let activityVC = UIActivityViewController(activityItems: [quote], applicationActivities: nil)
        
        // Trouver la scène active pour présenter le UIActivityViewController
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
