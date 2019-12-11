//
//  TreeFactory.swift
//  Tree
//
//  Created by Philip Lindberg on 2019-12-09.
//  Copyright © 2019 Philip Lindberg. All rights reserved.
//

import Foundation
import SpriteKit

// swiftlint:disable all
class TreeFactory
{
    static func createTree(level: Int) -> SKNode
    {
        //Actions
        let rotateAction1 = createRotationAction(angle: 0.08, duration: 6)
        let rotateAction2 = createRotationAction(angle: 0.12, duration: 6)
        let rotateAction3 = createRotationAction(angle: 0.5, duration: 3)
        
        //Textures
        let leafTexture1 = SKTexture(imageNamed: "leaf1")
        
        let tree = SKNode()
        tree.name = "tree"
        tree.isUserInteractionEnabled = false
        
        if (level == 1)
        {
            let ground = SKSpriteNode(imageNamed: "ground1")
            ground.zPosition = -10
            tree.addChild(ground)
            
            let mudPile = SKSpriteNode(imageNamed: "mud_pile")
            mudPile.position = CGPoint(x: 0, y: ground.size.height*0.2)
            ground.addChild(mudPile)
        
            let stem = SKSpriteNode(imageNamed: "stem_stage1")
            stem.anchorPoint = CGPoint(x: 0.5, y: 0.05)
            stem.position = CGPoint(x: 0, y: mudPile.size.height*0.48)
            stem.zRotation += 0.04
            stem.run(rotateAction1)
            mudPile.addChild(stem)
            
            let leaf = SKSpriteNode(texture: leafTexture1)
            leaf.xScale = -1
            leaf.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leaf.position = CGPoint(x: stem.size.width*0.13, y: stem.size.height*0.9)
            leaf.run(rotateAction3)
            stem.addChild(leaf)
            
            let leaf2 = SKSpriteNode(texture: leafTexture1)
            leaf2.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leaf2.position = CGPoint(x: stem.size.width*0.13, y: stem.size.height*0.5)
            let l2Action = SKAction.sequence([SKAction.wait(forDuration: 1), rotateAction3])
            leaf2.run(l2Action)
            stem.addChild(leaf2)
        }
        else if (level == 2)
        {
            let ground = SKSpriteNode(imageNamed: "ground1")
            ground.zPosition = -10
            tree.addChild(ground)
            
            let mudPile = SKSpriteNode(imageNamed: "mud_pile")
            mudPile.position = CGPoint(x: 0, y: ground.size.height*0.2)
            ground.addChild(mudPile)
            
            let stem = SKSpriteNode(imageNamed: "stem_stage2")
            stem.anchorPoint = CGPoint(x: 0.5, y: 0.05)
            stem.position = CGPoint(x: 0, y: mudPile.size.height*0.48)
            stem.zRotation += 0.04
            stem.zPosition = 10
            stem.run(rotateAction1)
            mudPile.addChild(stem)
            
            // Branch on the right side
            let branch1 = SKSpriteNode(imageNamed: "branch_stage2_big")
            branch1.anchorPoint = CGPoint(x: 0.5, y: 0.05)
            branch1.position = CGPoint(x: 0, y: stem.size.height*0.3)
            branch1.zRotation = 0.5
            branch1.run(rotateAction2)
            branch1.zPosition = -10
            stem.addChild(branch1)
            
            let leafb1 = SKSpriteNode(texture: leafTexture1)
            leafb1.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leafb1.position = CGPoint(x: branch1.size.width*0.2, y: branch1.size.height*0.9)
            leafb1.zRotation = -0.4
            leafb1.run(rotateAction3)
            branch1.addChild(leafb1)
            
            let leafb1_2 = SKSpriteNode(texture: leafTexture1)
            leafb1_2.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leafb1_2.position = CGPoint(x: branch1.size.width*0.13, y: branch1.size.height*0.5)
            let l2Action = SKAction.sequence([SKAction.wait(forDuration: 1), rotateAction3])
            leafb1_2.run(l2Action)
            branch1.addChild(leafb1_2)
            
            // Branch on the left side
            let branch2 = SKSpriteNode(imageNamed: "branch_stage2_small")
            branch2.anchorPoint = CGPoint(x: 0.5, y: 0.05)
            branch2.position = CGPoint(x: stem.size.width*0.45, y: stem.size.height*0.6)
            branch2.zRotation = -0.85
            branch2.run(rotateAction2)
            branch2.zPosition = -10
            stem.addChild(branch2)
            
            let leafb2_1 = SKSpriteNode(texture: leafTexture1)
            leafb2_1.xScale = -1
            leafb2_1.anchorPoint = CGPoint(x: 0.85, y: 0.05)
            leafb2_1.position = CGPoint(x: branch2.size.width*0.13, y: branch2.size.height*0.9)
            leafb2_1.run(rotateAction3)
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
            leaf2.run(rotateAction3)
            stem.addChild(leaf2)
        }
        
        return tree
    }
    
    
    static func createRotationAction(angle: CGFloat, duration: Double) -> SKAction
    {
        let rotateLeft = SKAction.rotate(byAngle: angle, duration: duration*0.5)
        rotateLeft.timingMode = .easeInEaseOut
       
        let rotateRight = SKAction.rotate(byAngle: -angle, duration: duration*0.5)
        rotateRight.timingMode = .easeInEaseOut
        
        let actionSequence = SKAction.sequence([rotateLeft, rotateRight])
        return SKAction.repeatForever(actionSequence)
    }
}
