import SpriteKit
import AVFoundation

/// GameScene with the gamification tree
class GameScene: SKScene {
    private var treeNode: SKNode!
    private var shakeAction: SKAction!
    private var treeLevel: Int
    private var fruit: Bool
    private var fruitTapCallback: () -> Void = {}
    /// For playing soundeffects when the fruit explodes
    private var audioPlayer: AVAudioPlayer?

    /// Creates a scene with size and given tree level
    init(size: CGSize, treeLevel: Int, fruit: Bool = false, fruitTapCallback: @escaping () -> Void = {}) {
        self.treeLevel = treeLevel
        self.fruit = fruit
        self.fruitTapCallback = fruitTapCallback

        let coinSound = Bundle.main.path(forResource: "boom", ofType: "mp3")
        self.audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: coinSound!))
        self.audioPlayer?.prepareToPlay()

        super.init(size: size)
    }

    /// Recuired but not used. **Do not use**
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// :nodoc:
    override func sceneDidLoad() {
        // Initialize background color
        self.backgroundColor = UIColor.init(red: 0.55, green: 0.8, blue: 1, alpha: 1)

        // Create Fade in and out action for the backround glow
        let fadeIn = SKAction.fadeAlpha(to: 0.55, duration: 5)
        fadeIn.timingMode = .easeInEaseOut
        let fadeOut = SKAction.fadeAlpha(to: 0.35, duration: 5)
        fadeOut.timingMode = .easeInEaseOut
        let fadeSequence = SKAction.sequence([fadeIn, fadeOut])

        let bgGlow = SKSpriteNode(imageNamed: "glow")
        bgGlow.setScale(7)
        bgGlow.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.2)
        bgGlow.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        bgGlow.zPosition = -50
        bgGlow.run(SKAction.fadeAlpha(to: 0.25, duration: 0))
        bgGlow.run(SKAction.repeatForever(fadeSequence))
        addChild(bgGlow)

        // Tree Shake Action (Not used at the moment)
        shakeAction = SKAction.sequence([
            SKAction.rotate(byAngle: -0.05, duration: 0.1),
            TreeFactory.createRotationAction(angle: 0.1, duration: 0.2, loop: false),
            SKAction.rotate(byAngle: 0.05, duration: 0.2)
        ])

        // Create Tree
        treeNode = TreeFactory.createTree(level: treeLevel)
        treeNode.position = CGPoint(x: size.width*0.5, y: size.height*0.15)

        // Add coupon fruit to Tree
        if fruit {
            treeNode = FruitFactory.addFruit(to: treeNode, withLevel: treeLevel)
        }
        addChild(treeNode)
    }

    /// Removes the fruit with an explosion
    func removeFruit() {
        if let fruit = treeNode.childNode(withName: "//fruit") {
            if let parent = fruit.parent {
                audioPlayer?.play()
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                //AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                parent.addChild(FruitFactory.createFruitExplosionEffect()!)
                fruit.removeFromParent()
            }
        }
    }

    /// Delecate method for handling user input
    /// Currenly hooks up the callback event for the coupon fruit.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchedNode = self.atPoint(touch.location(in: self))

        if let name = touchedNode.name {
            if name == "fruit" {
                // This is not ideal, causes visual glitches.
                // However this is the only way to achive this effect with swiftUI at the momement.
                removeFruit()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
                    self.fruitTapCallback()
                }
            }
        }

        // Shake Tree When tapped
//        if treeNode.contains(touch.location(in: self)) {
//            // Shake the tree if it is touched
//            if let sprite = treeNode.childNode(withName: "stem") as? SKSpriteNode {
//                sprite.run(shakeAction)
//            }
//        }
    }
}
