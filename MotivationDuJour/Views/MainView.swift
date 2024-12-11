import SwiftUI

struct MainView: View {
    @State private var currentQuote: Quote?
    @State private var favoriteQuotes: [Quote] = [] // Liste des citations favorites
    private let quotes = QuoteLoader.loadQuotes()

    @State private var rotation: Double = 0 // Propriété pour gérer la rotation de la citation
    @State private var isRotating: Bool = false // Propriété pour contrôler l'état de la rotation

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
                    Spacer()
                    if let quote = currentQuote {
                        // Affichage de la citation avec animation de rotation
                        Text("“\(quote.quote)”")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .multilineTextAlignment(.center)
                            .rotation3DEffect(
                                .degrees(rotation),
                                axis: (x: 0, y: 0, z: 1) // Rotation autour de l'axe Z
                            )
                            .animation(.easeInOut(duration: 0.5), value: rotation) // Animation fluide de la rotation
                        
                        // Affichage de l'auteur avec la même rotation
                        Text("- \(quote.author)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .rotation3DEffect(
                                .degrees(rotation),
                                axis: (x: 0, y: 0, z: 1) // Rotation autour de l'axe Z pour l'auteur
                            )
                            .animation(.easeInOut(duration: 0.5), value: rotation) // Animation fluide de la rotation
                        
                        Spacer()

                        // Masquer l'HStack pendant la rotation
                        if !isRotating {
                            HStack {
                                Spacer()

                                // Bouton de partage
                                Button(action: {
                                    shareQuote(quote: "“\(quote.quote)” - \(quote.author)")
                                }) {
                                    Image(systemName: "square.and.arrow.up")
                                        .foregroundColor(.blue)
                                        .padding()
                                }

                                // Bouton favori (cœur)
                                Button(action: {
                                    if let quote = currentQuote {
                                        favoriteQuotes.append(quote) // Ajoute la citation aux favoris
                                    }
                                }) {
                                    Image(systemName: "heart.fill") // Cœur toujours rempli
                                        .foregroundColor(.red) // Toujours rouge
                                        .padding()
                                }

                                // Bouton de favoris (icône opticaldiscdrive.fill)
                                NavigationLink(destination: FavorisView(favoriteQuotes: $favoriteQuotes)) {
                                    Image(systemName: "opticaldiscdrive.fill") // Icône de favoris
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                                
                                Spacer()
                            }
                            .padding(.top, 8)
                        }
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
        // Ajouter une animation lors de la mise à jour de la citation avec une rotation
        withAnimation {
            isRotating = true // Démarrer la rotation
            rotation += 360 // Rotation complète de 360 degrés à chaque nouvelle citation
        }

        // Attendre la fin de la rotation avant d'afficher la nouvelle citation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            currentQuote = quotes.randomElement()
            isRotating = false // Fin de la rotation
        }
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
