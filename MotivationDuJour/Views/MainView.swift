import Foundation
import SwiftUI

struct MainView: View {
    @State private var currentQuote: Quote?
    private let quotes = QuoteLoader.loadQuotes()
    
    var body: some View {
        VStack {
            // Affichage de la date du jour
            HStack {
                Image(systemName: "calendar.circle")
                Text(getCurrentDate())
                    .font(.title2)
                    .padding()
            }
            
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
        }
        .onAppear(perform: showRandomQuote)
        .padding()
    }
    
    private func showRandomQuote() {
        currentQuote = quotes.randomElement()
    }
    
    // Fonction pour obtenir la date actuelle
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
