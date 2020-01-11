import Foundation
import SpriteKit

/// Contains factory metod for adding fruit to trees of different *levels*
enum FruitFactory {
    /// Adds a fruit to a tree of the given level
    /// - parameter tree: the tree to add the fruit to
    /// - parameter level: level of the tree
    /// - returns: a tree with a fruit
    static func addFruit(to tree: SKNode, withLevel level: Int) -> SKNode {
        let scaleAction1 = TreeFactory.createScaleAction(scaleAmount: 1.1, duration: 12, loop: true)
        let fruit = SKSpriteNode(imageNamed: "fruit")
        fruit.name = "fruit"

        if level == 2 {
            let fruitAnchor = tree.childNode(withName: "//leafb1_2")!

            fruit.setScale(0.75)
            fruit.position = CGPoint(x: -170, y: -85)
            fruit.run(scaleAction1)
            fruitAnchor.addChild(fruit)
            
        } else if level == 3 {
            let fruitAnchor = tree.childNode(withName: "//branchRightLower")!

            fruit.position = CGPoint(x: 100, y: -150)
            fruit.run(scaleAction1)
            fruitAnchor.addChild(fruit)

        }

        return tree
    }

    /// Creates an explosion effect
    static func createFruitExplosionEffect() -> SKNode? {
        let effect = SKNode()

        let e1 = SKEmitterNode(fileNamed: "fruit_effect1.sks")
        effect.addChild(e1!)

        let e2 = SKEmitterNode(fileNamed: "fruit_effect2.sks")
        effect.addChild(e2!)

        let e3 = SKEmitterNode(fileNamed: "fruit_effect3.sks")
        effect.addChild(e3!)

        effect.setScale(5)

        // Remove effect after duration
        effect.run(SKAction.sequence([SKAction.wait(forDuration: 2.5), SKAction.removeFromParent()]))

        return effect
    }
}
