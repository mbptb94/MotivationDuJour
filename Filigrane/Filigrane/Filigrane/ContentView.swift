import SwiftUI
import PhotosUI

struct ContentView: View {
    // Variables d'état pour le filigrane et les images sélectionnées
    @State private var watermark = Watermark(text: "Mon Filigrane", fontSize: 20, color: "#000000", position: "BottomRight", opacity: 0.5)
    @State private var selectedImages: [UIImage] = []
    
    var body: some View {
        NavigationView {
            VStack {
                // Vue pour éditer le filigrane
                WatermarkEditorView(watermark: $watermark)
                
                // Vue pour sélectionner des images depuis la galerie
                PhotoPickerView(selectedImages: $selectedImages)
                
                // Bouton pour appliquer le filigrane sur les images sélectionnées
                Button("Appliquer le filigrane") {
                    // Ajouter le filigrane à chaque image sélectionnée
                    let processedImages = addWatermarkToBatch(images: selectedImages, watermark: watermark)
                    // Tu peux ici sauvegarder ou afficher les images transformées
                }
                .padding()
            }
            .navigationTitle("Filigraneur")
        }
    }
}

// Fonction pour ajouter un filigrane à une seule image
func addWatermark(to image: UIImage, with watermark: Watermark) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: image.size)
    return renderer.image { context in
        image.draw(at: .zero)

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: CGFloat(watermark.fontSize)),
            .foregroundColor: UIColor(hex: watermark.color).withAlphaComponent(watermark.opacity)
        ]
        
        let textSize = watermark.text.size(withAttributes: attributes)
        let position = calculatePosition(for: textSize, in: image.size, alignment: watermark.position)

        watermark.text.draw(at: position, withAttributes: attributes)
    }
}

// Fonction pour ajouter un filigrane à un lot d'images
func addWatermarkToBatch(images: [UIImage], watermark: Watermark) -> [UIImage] {
    return images.map { addWatermark(to: $0, with: watermark) }
}

// Fonction pour calculer la position du filigrane dans l'image
func calculatePosition(for textSize: CGSize, in imageSize: CGSize, alignment: String) -> CGPoint {
    switch alignment {
    case "TopLeft":
        return CGPoint(x: 10, y: 10)
    case "Center":
        return CGPoint(x: (imageSize.width - textSize.width) / 2, y: (imageSize.height - textSize.height) / 2)
    case "BottomRight":
        return CGPoint(x: imageSize.width - textSize.width - 10, y: imageSize.height - textSize.height - 10)
    default:
        return .zero
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Extension pour initialiser UIColor à partir d'une chaîne hexadécimale
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 1) & 0xF, (int >> 4 * 1) & 0xF, (int >> 0 * 1) & 0xF)
            self.init(
                red: CGFloat(r) / 15.0,
                green: CGFloat(g) / 15.0,
                blue: CGFloat(b) / 15.0,
                alpha: CGFloat(a) / 255.0
            )
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
            self.init(
                red: CGFloat(r) / 255.0,
                green: CGFloat(g) / 255.0,
                blue: CGFloat(b) / 255.0,
                alpha: CGFloat(a) / 255.0
            )
        case 8: // ARGB (32-bit)
            (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
            self.init(
                red: CGFloat(r) / 255.0,
                green: CGFloat(g) / 255.0,
                blue: CGFloat(b) / 255.0,
                alpha: CGFloat(a) / 255.0
            )
        default:
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
