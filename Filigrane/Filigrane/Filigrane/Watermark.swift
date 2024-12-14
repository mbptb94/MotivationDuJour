import SwiftData

@Model
class Watermark {
    var text: String
    var fontSize: Double
    var color: String // Couleur en hexadécimal
    var position: String
    var opacity: Double

    init(text: String, fontSize: Double, color: String, position: String, opacity: Double) {
        self.text = text
        self.fontSize = fontSize
        self.color = color
        self.position = position
        self.opacity = opacity
    }
}
