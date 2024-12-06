//
//  MainView.swift
//  MotivationDuJour
//
//  Created by Yoann TOURTELLIER on 06/12/2024.
//

import Foundation
import SwiftUI

struct MainView: View {
    @State private var currentQuote: Quote?
    private let quotes = QuoteLoader.loadQuotes()
    
    var body: some View {
        VStack {
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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
