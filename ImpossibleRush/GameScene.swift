//
//  GameScene.swift
//  ImpossibleRush
//
//  Created by Fan Qi on 6/30/15.
//  Copyright (c) 2015 f_qi. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let centerBox = SKSpriteNode(imageNamed: "squareRed")
    let passScorePoint: Bool = false
    
    var colorDot = SKSpriteNode()
    var colorDotColorSet = ["red", "blue", "green", "yellor"]
    var colorDotColor: String = ""
    var tapCounter = Int()
    var centerBoxColor = String()
    var score: Int = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.whiteColor()
        
        // Default color when start
        tapCounter = 1
        centerBoxColor = "red"
        
        // Add center box to screen
        centerBox.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 3)
        // centerBox.zPosition = 10
        self.addChild(centerBox)
        
        positionColorDots()
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        var centerBoxAction = SKAction.rotateByAngle(-CGFloat(M_PI) / 2, duration: 0.18)
        centerBox.runAction(centerBoxAction)
        tapCounter++
        if tapCounter == 5 {
            tapCounter = 1
        }

        // Assign color to centerBox
        switch tapCounter {
        case 1:
            centerBoxColor = "red"
        case 2:
            centerBoxColor = "blue"
        case 3:
            centerBoxColor = "green"
        case 4:
            centerBoxColor = "yellow"
        default:
            println("\(tapCounter) + \(centerBoxColor)")
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        println(colorDot.position)
        var checkPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 3 + 50)
//        if colorDot.parent === self && colorDot.position.y < checkPoint.y {
        if colorDot.parent != nil && colorDot.position.y < checkPoint.y {
            if colorDotColor == centerBoxColor {
                score++
                colorDot.removeFromParent()
            } else {
                println("unable to calculate score")
                colorDot.removeFromParent()
            }
        }
        println(score)
    }
    
    func positionColorDots() {
        let colorDotColorIndex = Int(arc4random_uniform(UInt32(colorDotColorSet.count)))
        switch colorDotColorIndex {
        case 0:
            colorDot = SKSpriteNode(imageNamed: "redCircle")
            colorDotColor = "red"
        case 1:
            colorDot = SKSpriteNode(imageNamed: "blueCircle")
            colorDotColor = "blue"
        case 2:
            colorDot = SKSpriteNode(imageNamed: "greenCircle")
            colorDotColor = "green"
        case 3:
            colorDot = SKSpriteNode(imageNamed: "yellowCircle")
            colorDotColor = "yellow"
        default:
            println("color dot color index out of range, \(colorDotColorIndex)")
        }
        colorDot.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height)
        colorDot.physicsBody = SKPhysicsBody(circleOfRadius: 16)
        colorDot.physicsBody?.velocity = CGVectorMake(0, -100)
        colorDot.physicsBody?.affectedByGravity = false
        self.addChild(colorDot)
    }

}
