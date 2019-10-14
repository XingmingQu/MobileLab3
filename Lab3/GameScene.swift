//
//  GameScene.swift
//  mazeGame
//
//  Created by Ketan Jogalekar on 10/11/19.
//  Copyright © 2019 Siddhika Ghaisas. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    //This framework holds functions for accessing gyrometer and other utilities of iphone
    let manager = CMMotionManager()
    var marble = SKSpriteNode()
    var blackHole = SKSpriteNode()
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        //Update the core motion manager, so it starts updating data immediately
        physicsWorld.contactDelegate = self
        marble = self.childNode(withName: "marble") as! SKSpriteNode
        blackHole = self.childNode(withName: "blackHole") as! SKSpriteNode
        
        manager.startAccelerometerUpdates()
        //Grab data every 10th of a second
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data,Error) in
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 10, dy:CGFloat(( data?.acceleration.y)!) * 10)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let playerBody = contact.bodyA
        let blackHoleBody = contact.bodyB
        
        //Check if one of the 2 bodies contacting is a Black hole
        //In that case the marble has successfully reached the target
        if playerBody.node?.name == "blackHole" ||
            blackHoleBody.node?.name == "blackHole"
        {
            //Let's mke the marble disappear in the black hole
            if playerBody.node?.name == "marble"
            {
                playerBody.node?.removeFromParent()
            }
            else
            {
                blackHoleBody.node?.removeFromParent()
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    //Create a new SKSpriteNode as a marble, with given properties
    func addMarble(){
         let marble = SKSpriteNode(imageNamed: "marble")
         
        marble.size = CGSize(width:50,height:50)
         
         marble.position = CGPoint(x:-280, y:-550)
         
        marble.physicsBody = SKPhysicsBody(circleOfRadius: 35)
        marble.physicsBody?.restitution = CGFloat(0.2)
         marble.physicsBody?.isDynamic = true
         marble.physicsBody?.contactTestBitMask = 0x00000002
         marble.physicsBody?.collisionBitMask = 0x00000001
         marble.physicsBody?.categoryBitMask = 0x00000001
         
         self.addChild(marble)
     }
    
    //A new marble should be created when user touches the screen anywhere.
    //The marble will be created at a fixed location specified in addMarble function
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        addMarble()
    }

}
