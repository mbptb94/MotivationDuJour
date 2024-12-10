import Foundation

struct Quote: Identifiable, Equatable, Decodable {
    let id = UUID() // Identifiant unique pour chaque citation
    let quote: String // Texte de la citation
    let author: String // Auteur de la citation
}
