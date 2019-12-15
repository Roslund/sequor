import Foundation
import SpriteKit

/// Contains factory metods for creating trees of different *levels*
enum TreeFactory { // swiftlint:disable:this type_body_length
    /// Creates a tree corresponding to the level given as a parameter
    /// - parameter level: requested level of the tree
    /// - returns: a tree as a SKNode
    static func createTree(level: Int) -> SKNode { // swiftlint:disable:this function_body_length
        // Initialize actions
        let rotateAction04 = createRotationAction(angle: 0.04, duration: 6, loop: true)
        let rotateAction08 = createRotationAction(angle: 0.08, duration: 6, loop: true)
        let rotateAction12 = createRotationAction(angle: 0.12, duration: 6, loop: true)
        let rotateAction50 = createRotationAction(angle: 0.5, duration: 3, loop: true)
        let scaleAction1 = createScaleAction(scaleAmount: 1.1, duration: 12, loop: true)
        let scaleAction065 = createScaleAction(scaleAmount: 1.065, duration: 12, loop: true)
        let scaleAction035 = createScaleAction(scaleAmount: 1.035, duration: 12, loop: true)

        // Load shared textures
        let leafTexture1 = SKTexture(imageNamed: "leaf1")
        let bushTextureSmall = SKTexture(imageNamed: "bush1")
        let branchStage3 = SKTexture(imageNamed: "branch_stage3_small")

        // Create shared tree components
        let tree = SKNode()
        let interactableNodeName = "interactable"

        let ground = SKSpriteNode(imageNamed: "ground1")
        tree.addChild(ground)

        // Create level specific tree components
        if level == 0 {
            let mudPile = SKSpriteNode(imageNamed: "mud_pile")
            mudPile.position = CGPoint(x: 0, y: ground.size.height*0.2)
            ground.addChild(mudPile)
        } else if level == 1 {
            let mudPile = SKSpriteNode(imageNamed: "mud_pile")
            mudPile.position = CGPoint(x: 0, y: ground.size.height*0.2)
            ground.addChild(mudPile)

            let stem = SKSpriteNode(imageNamed: "stem_stage1")
            stem.name = interactableNodeName
            stem.anchorPoint = CGPoint(x: 0.5, y: 0.05)
            stem.position = CGPoint(x: 0, y: mudPile.size.height*0.48)
            stem.zRotation += 0.04
            stem.run(rotateAction08)
            stem.run(scaleAction1)
            mudPile.addChild(stem)

            let leaf = SKSpriteNode(texture: leafTexture1)
            leaf.xScale = -1
            leaf.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leaf.position = CGPoint(x: stem.size.width*0.13, y: stem.size.height*0.9)
            leaf.run(rotateAction50)
            stem.addChild(leaf)

            let leaf2 = SKSpriteNode(texture: leafTexture1)
            leaf2.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leaf2.position = CGPoint(x: stem.size.width*0.13, y: stem.size.height*0.5)
            let l2Action = SKAction.sequence([SKAction.wait(forDuration: 1), rotateAction50])
            leaf2.run(l2Action)
            stem.addChild(leaf2)
        } else if level == 2 {
            let mudPile = SKSpriteNode(imageNamed: "mud_pile")
            mudPile.position = CGPoint(x: 0, y: ground.size.height*0.2)
            ground.addChild(mudPile)

            let stem = SKSpriteNode(imageNamed: "stem_stage2")
            stem.name = interactableNodeName
            stem.anchorPoint = CGPoint(x: 0.5, y: 0.05)
            stem.position = CGPoint(x: 0, y: mudPile.size.height*0.48)
            stem.zRotation += 0.04
            stem.zPosition = 10
            stem.run(rotateAction08)
            stem.run(scaleAction065)
            mudPile.addChild(stem)

            // Branch on the left side
            let branch1 = SKSpriteNode(imageNamed: "branch_stage2_big")
            branch1.anchorPoint = CGPoint(x: 0.5, y: 0.05)
            branch1.position = CGPoint(x: 0, y: stem.size.height*0.3)
            branch1.zRotation = 0.5
            branch1.run(rotateAction12)
            branch1.zPosition = -10
            stem.addChild(branch1)

            let leafb1 = SKSpriteNode(texture: leafTexture1)
            leafb1.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leafb1.position = CGPoint(x: branch1.size.width*0.2, y: branch1.size.height*0.9)
            leafb1.zRotation = -0.4
            leafb1.run(rotateAction50)
            branch1.addChild(leafb1)

            // swiftlint:disable:next identifier_name
            let leafb1_2 = SKSpriteNode(texture: leafTexture1)
            leafb1_2.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leafb1_2.position = CGPoint(x: branch1.size.width*0.13, y: branch1.size.height*0.5)
            let l2Action = SKAction.sequence([SKAction.wait(forDuration: 1), rotateAction50])
            leafb1_2.run(l2Action)
            branch1.addChild(leafb1_2)

            // Branch on the right side
            let branch2 = SKSpriteNode(imageNamed: "branch_stage2_small")
            branch2.anchorPoint = CGPoint(x: 0.5, y: 0.05)
            branch2.position = CGPoint(x: stem.size.width*0.45, y: stem.size.height*0.6)
            branch2.zRotation = -0.85
            branch2.run(rotateAction12)
            branch2.zPosition = -10
            stem.addChild(branch2)

            // swiftlint:disable:next identifier_name
            let leafb2_1 = SKSpriteNode(texture: leafTexture1)
            leafb2_1.xScale = -1
            leafb2_1.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leafb2_1.position = CGPoint(x: branch2.size.width*0.13, y: branch2.size.height*0.9)
            leafb2_1.run(rotateAction50)
            branch2.addChild(leafb2_1)

            // Top Leafs
            let leaf = SKSpriteNode(texture: leafTexture1)
            leaf.xScale = -1
            leaf.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leaf.position = CGPoint(x: stem.size.width*0.5, y: stem.size.height*0.85)
            leaf.run(l2Action)
            leaf.zRotation = -0.5
            stem.addChild(leaf)

            let leaf2 = SKSpriteNode(texture: leafTexture1)
            leaf2.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leaf2.setScale(1.4)
            leaf2.position = CGPoint(x: stem.size.width*0.5, y: stem.size.height*0.9)
            leaf2.zRotation = -0.4
            leaf2.run(rotateAction50)
            stem.addChild(leaf2)
        } else if level == 3 {
            let shadow = SKSpriteNode(imageNamed: "shadow_stage3")
            shadow.position = CGPoint(x: 0, y: ground.size.height*0.1)
            shadow.run(scaleAction035)
            ground.addChild(shadow)

            let stem = SKSpriteNode(imageNamed: "stem_stage3")
            stem.name = interactableNodeName
            stem.anchorPoint = CGPoint(x: 0.5, y: 0.025)
            stem.position = CGPoint(x: 0, y: shadow.size.height*0.2)
            stem.run(rotateAction04)
            shadow.addChild(stem)

            let grass = SKSpriteNode(imageNamed: "grass1")
            grass.position = CGPoint(x: 0, y: shadow.size.height*0.25)
            grass.zPosition = 10
            shadow.addChild(grass)

            //Middle
            let branchTopLeft = SKSpriteNode(texture: branchStage3)
            branchTopLeft.xScale = -1
            branchTopLeft.anchorPoint = CGPoint(x: 0.5, y: 0.025)
            branchTopLeft.position = CGPoint(x: stem.size.width*0.25, y: stem.size.height*0.95)
            branchTopLeft.zRotation = 0.5
            branchTopLeft.run(rotateAction12)
            branchTopLeft.zPosition = -10
            stem.addChild(branchTopLeft)

            let branchTopRight = SKSpriteNode(texture: branchStage3)
            branchTopRight.anchorPoint = CGPoint(x: 0.5, y: 0.025)
            branchTopRight.position = CGPoint(x: stem.size.width*0.25, y: stem.size.height*0.95)
            branchTopRight.zRotation = -0.5
            branchTopRight.run(rotateAction12)
            branchTopRight.zPosition = -10
            stem.addChild(branchTopRight)

            let bushTop = SKSpriteNode(texture: bushTextureSmall)
            bushTop.setScale(1.2)
            bushTop.anchorPoint = CGPoint(x: 0.5, y: 0.15)
            bushTop.position = CGPoint(x: 0, y: stem.size.height*1.025)
            bushTop.run(SKAction.sequence([SKAction.wait(forDuration: 1), rotateAction12]))
            stem.addChild(bushTop)

            // Branch on the left side
            let branch1 = SKSpriteNode(imageNamed: "branch_stage3_big")
            branch1.anchorPoint = CGPoint(x: 0.5, y: 0.025)
            branch1.position = CGPoint(x: 0, y: stem.size.height*0.3)
            branch1.zRotation = 0.4
            branch1.run(rotateAction04)
            branch1.zPosition = -10
            stem.addChild(branch1)

            let bushLeft = SKSpriteNode(texture: bushTextureSmall)
            bushLeft.xScale = -1
            bushLeft.anchorPoint = CGPoint(x: 0.5, y: 0.15)
            bushLeft.position = CGPoint(x: branch1.size.width*0.2, y: branch1.size.height*0.9)
            bushLeft.zRotation = -0.4
            bushLeft.run(rotateAction12)
            branch1.addChild(bushLeft)

            let branchLeftLower = SKSpriteNode(texture: branchStage3)
            branchLeftLower.xScale = -1
            branchLeftLower.anchorPoint = CGPoint(x: 0.5, y: 0.025)
            branchLeftLower.position = CGPoint(x: -branch1.size.width*0.25, y: branch1.size.height*0.45)
            branchLeftLower.zRotation = 0.8
            branchLeftLower.run(rotateAction12)
            branchLeftLower.zPosition = -10
            branch1.addChild(branchLeftLower)

            let leafBranchLeftLower = SKSpriteNode(texture: leafTexture1)
            leafBranchLeftLower.xScale = -1
            leafBranchLeftLower.anchorPoint = CGPoint(x: 0.8, y: 0.1)
            leafBranchLeftLower.position = CGPoint(x: 0, y: branchLeftLower.size.height*0.8)
            leafBranchLeftLower.zRotation = -0.2
            leafBranchLeftLower.run(SKAction.sequence([SKAction.wait(forDuration: 2), rotateAction50]))
            branchLeftLower.addChild(leafBranchLeftLower)

            let branchLeftUpper = SKSpriteNode(texture: branchStage3)
            branchLeftUpper.anchorPoint = CGPoint(x: 0.5, y: 0.025)
            branchLeftUpper.position = CGPoint(x: branch1.size.width*0.1, y: branch1.size.height*0.7)
            branchLeftUpper.zRotation = -0.6
            branchLeftUpper.run(rotateAction12)
            branchLeftUpper.zPosition = -10
            branch1.addChild(branchLeftUpper)

            // Branch on the right side
            let branch2 = SKSpriteNode(imageNamed: "branch_stage3_medium")
            branch2.anchorPoint = CGPoint(x: 0.5, y: 0.05)
            branch2.position = CGPoint(x: stem.size.width*0.4, y: stem.size.height*0.6)
            branch2.zRotation = -0.85
            branch2.run(rotateAction04)
            branch2.zPosition = -10
            stem.addChild(branch2)

            let leaf2right = SKSpriteNode(texture: leafTexture1)
            leaf2right.setScale(1.25)
            leaf2right.anchorPoint = CGPoint(x: 0.8, y: 0.1)
            leaf2right.position = CGPoint(x: 0, y: branch2.size.height*0.9)
            leaf2right.zRotation = -0.2
            leaf2right.run(rotateAction50)
            branch2.addChild(leaf2right)

            let leaf1right = SKSpriteNode(texture: leafTexture1)
            leaf1right.xScale = -1
            leaf1right.anchorPoint = CGPoint(x: 0.8, y: 0.1)
            leaf1right.position = CGPoint(x: 0, y: branch2.size.height*0.9)
            leaf1right.zRotation = -0.2
            leaf1right.run(SKAction.sequence([SKAction.wait(forDuration: 1), rotateAction50]))
            branch2.addChild(leaf1right)

            let branchRightUpper = SKSpriteNode(texture: branchStage3)
            branchRightUpper.anchorPoint = CGPoint(x: 0.5, y: 0.025)
            branchRightUpper.position = CGPoint(x: branch2.size.width*0.1, y: branch2.size.height*0.55)
            branchRightUpper.zRotation = -0.6
            branchRightUpper.run(rotateAction12)
            branchRightUpper.zPosition = -10
            branch2.addChild(branchRightUpper)

            let leafBranchRightUpper = SKSpriteNode(texture: leafTexture1)
            leafBranchRightUpper.xScale = -1
            leafBranchRightUpper.anchorPoint = CGPoint(x: 0.8, y: 0.1)
            leafBranchRightUpper.position = CGPoint(x: 0, y: branchRightUpper.size.height*0.8)
            leafBranchRightUpper.zRotation = -0.2
            leafBranchRightUpper.run(SKAction.sequence([SKAction.wait(forDuration: 2.5), rotateAction50]))
            branchRightUpper.addChild(leafBranchRightUpper)

            let branchRightLower = SKSpriteNode(texture: branchStage3)
            branchRightLower.anchorPoint = CGPoint(x: 0.5, y: 0.025)
            branchRightLower.position = CGPoint(x: branch2.size.width*0.1, y: branch2.size.height*0.4)
            branchRightLower.zRotation = 0.6
            branchRightLower.run(rotateAction12)
            branchRightLower.zPosition = -10
            branch2.addChild(branchRightLower)

            let leafBranchRightLower = SKSpriteNode(texture: leafTexture1)
            leafBranchRightLower.anchorPoint = CGPoint(x: 0.8, y: 0.1)
            leafBranchRightLower.position = CGPoint(x: 0, y: branchRightLower.size.height*0.8)
            leafBranchRightLower.zRotation = -0.2
            leafBranchRightLower.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), rotateAction50]))
            branchRightLower.addChild(leafBranchRightLower)
        }
        return tree
    }

    /// Creates a SKAction sequence of rotate SKActions
    /// - parameter angle: the angle of each individual rotation action
    /// - parameter duration: the duration of one iteration of the action sequence
    /// - parameter loop: if the action should loop
    /// - returns: SKAction sequence of rotation actions
    static func createRotationAction(angle: CGFloat, duration: Double, loop: Bool) -> SKAction {
        let rotateLeft = SKAction.rotate(byAngle: angle, duration: duration*0.5)
        rotateLeft.timingMode = .easeInEaseOut

        let rotateRight = SKAction.rotate(byAngle: -angle, duration: duration*0.5)
        rotateRight.timingMode = .easeInEaseOut

        let actionSequence = SKAction.sequence([rotateLeft, rotateRight])

        if !loop {
            return actionSequence
        }
        return SKAction.repeatForever(actionSequence)
    }

    /// Creates a SKAction sequence of scale SKActions
    /// - parameter scaleAmount: the amount the action should scale by
    /// - parameter duration: the duration of one iteration of the action sequence
    /// - parameter loop: if the action should loop
    /// - returns: SKAction sequence of scale actions
    static func createScaleAction(scaleAmount: CGFloat, duration: Double, loop: Bool) -> SKAction {
        let scaleIn = SKAction.scale(by: 1/scaleAmount, duration: duration*0.5)
        scaleIn.timingMode = .easeInEaseOut
        let scaleOut = SKAction.scale(by: scaleAmount, duration: duration*0.5)
        scaleOut.timingMode = .easeInEaseOut

        let actionSequence = SKAction.sequence([scaleIn, scaleOut])
        if !loop {
            return actionSequence
        }
        return SKAction.repeatForever(actionSequence)
    }
}
