import SwiftUI
import SpriteKit

struct GameSceneView: UIViewRepresentable {
    let size: CGSize
    let treeLevel: Int
    let fruit: Bool
    let fruitTapCallback: () -> Void

    func makeUIView(context: Context) -> SKView {
        // Let SwiftUI handle the sizing
        return SKView(frame: .zero)
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        let scene = GameScene(size: size, treeLevel: treeLevel, fruit: fruit, fruitTapCallback: fruitTapCallback)
        uiView.presentScene(scene)
    }
}
