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
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: #selector(pressedSelect))
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)
        
    }
    
    func pressedSelect(){

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
 
}
