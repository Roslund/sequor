import SwiftUI
import SpriteKit

struct GameSceneView: UIViewRepresentable {
    //@EnvironmentObject var appState: AppState
    let size: CGSize
    let treeLevel: Int

    func makeUIView(context: Context) -> SKView {
        // Let SwiftUI handle the sizing
        return SKView(frame: .zero)
    }

    func updateUIView(_ uiView: SKView, context: Context) {
         let scene = GameScene(size: size, treeLevel: treeLevel)
        uiView.presentScene(scene)
    }
}
