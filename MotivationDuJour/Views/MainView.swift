import SwiftUI

struct MainView: View {
    @State private var currentQuote: Quote?
    @State private var favoriteQuotes: [Quote] = [] // Liste des citations favorites
    private let quotes = QuoteLoader.loadQuotes()

    @State private var rotationY: Double = 0 // Gestion de l'angle de retournement
    @State private var isFlipping: Bool = false // État du retournement

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
                        VStack(spacing: 8) {
                            // Citation
                            Text("“\(quote.quote)”")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .multilineTextAlignment(.center)

                            // Auteur
                            Text("- \(quote.author)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .rotation3DEffect(
                            .degrees(rotationY),
                            axis: (x: 0, y: 1, z: 0) // Retournement horizontal
                        )
                        .opacity(isFlipping ? 0 : 1) // Masquer brièvement le texte pendant le changement
                        .animation(.easeInOut(duration: 0.5), value: rotationY) // Animation fluide
                    } else {
                        Text("Aucune citation disponible.")
                            .padding()
                    }
                    Spacer()

                    // Boutons d'actions
                    if !isFlipping {
                        HStack {
                            Spacer()

                            // Bouton de partage
                            Button(action: {
                                if let quote = currentQuote {
                                    shareQuote(quote: "“\(quote.quote)” - \(quote.author)")
                                }
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
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                    .padding()
                            }

                            // Bouton pour afficher les favoris
                            NavigationLink(destination: FavorisView(favoriteQuotes: $favoriteQuotes)) {
                                Image(systemName: "opticaldiscdrive.fill")
                                    .foregroundColor(.blue)
                                    .padding()
                            }

                            Spacer()
                        }
                        .padding(.top, 8)
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
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: .blue, radius: 10, x: 0, y: 5)
                }
                .padding(.bottom, 20) // Marge en bas
            }
            .onAppear(perform: showRandomQuote)
            .padding()
            .navigationTitle("Motivation du Jour")
        }
    }

    private func showRandomQuote() {
        // Lancer l'effet de retournement
        withAnimation {
            rotationY += 180 // Retournement à 90 degrés
            isFlipping = true // Empêche l'interaction pendant l'animation
        }

        // Attendre l'effet avant de changer la citation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            // Mise à jour de la citation après la moitié du retournement
            currentQuote = quotes.randomElement()

            // Compléter le retournement
            withAnimation {
                rotationY += 180 // Finaliser jusqu'à 180 degrés
                rotationY = rotationY.truncatingRemainder(dividingBy: 360) // Réinitialisation pour éviter l'inversion
                isFlipping = false // Réactiver l'interaction
            }
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
