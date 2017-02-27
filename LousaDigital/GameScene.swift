//
//  GameScene.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 13/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit
import GameplayKit

var gameScene : GameScene?

class GameScene: SKScene {

    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()

    override func didMove(to: SKView) {
        
        //Gestures
        //Swipe Right
//        swipeRightRec.addTarget(self, action: Selector(("swipedRight")))
//        swipeRightRec.direction = .right
//        self.view!.addGestureRecognizer(swipeRightRec)
        //Swipe Left
//        swipeLeftRec.addTarget(self, action: Selector(("swipedLeft")))
//        swipeLeftRec.direction = .left
//        self.view!.addGestureRecognizer(swipeLeftRec)
        //Touch Pressed
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
 
}
