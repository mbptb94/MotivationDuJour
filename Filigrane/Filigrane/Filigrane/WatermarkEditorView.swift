import SwiftUI

struct WatermarkEditorView: View {
    @Binding var watermark: Watermark
    
    var body: some View {
        Form {
            TextField("Texte du filigrane", text: $watermark.text)
            
            Stepper("Taille de la police : \(Int(watermark.fontSize))", value: $watermark.fontSize, in: 10...100)
            
            ColorPicker("Couleur", selection: Binding(get: {
                Color(hex: watermark.color)
            }, set: { color in
                watermark.color = color.toHex() ?? "#000000" // Ajout de la coalescence nil
            }))
            
            Picker("Position", selection: $watermark.position) {
                Text("En haut à gauche").tag("TopLeft")
                Text("Centre").tag("Center")
                Text("En bas à droite").tag("BottomRight")
            }
            
            Slider(value: $watermark.opacity, in: 0.1...1.0) {
                Text("Opacité")
            }
            .padding()
        }
    }
}
