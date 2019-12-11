import SwiftUI
import SpriteKit

struct SceneView: UIViewRepresentable {

    let scene: SKScene

    func makeUIView(context: Context) -> SKView {
        // Let SwiftUI handle the sizing
        return SKView(frame: .zero)
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.presentScene(scene)
    }
}
