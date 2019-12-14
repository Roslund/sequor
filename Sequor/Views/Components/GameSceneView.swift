import SwiftUI
import SpriteKit

struct GameSceneView: UIViewRepresentable {
    @EnvironmentObject var appState: AppState

    func makeUIView(context: Context) -> SKView {
        // Let SwiftUI handle the sizing
        return SKView(frame: .zero)
    }

    func updateUIView(_ uiView: SKView, context: Context) {
         let scene = GameScene(size: CGSize(width: 3375, height: 7308), treeLevel: appState.treeLevel)
        uiView.presentScene(scene)
    }
}