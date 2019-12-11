//
//  GameScene.swift
//  Tree
//
//  Created by Philip Lindberg on 2019-12-09.
//  Copyright © 2019 Philip Lindberg. All rights reserved.
//

import SpriteKit

// swiftlint:disable all
class GameScene: SKScene {
    
    private var label: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    
    private var treeNode: SKNode!


    override func sceneDidLoad() {
        self.backgroundColor = UIColor.init(red: 0.55, green: 0.8, blue: 1, alpha: 1)

        treeNode = TreeFactory.createTree(level: 2)
        treeNode.position = CGPoint(x: size.width*0.5, y: size.height*0.25)
        addChild(treeNode!)
    }

    override func didMove(to view: SKView) {}
    
    func touchDown(atPoint pos : CGPoint) {}
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if treeNode.contains(touch.location(in: self)) {
            print("touched")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
