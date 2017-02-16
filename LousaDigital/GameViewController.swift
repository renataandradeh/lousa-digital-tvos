//
//  GameViewController.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 13/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var gameScene : SKScene?
    var countingGame : SKScene?
    var matchingGame : SKScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        gameScene = GameScene(fileNamed: "GameScene")
        countingGame = CountingGame(fileNamed: "CountingGame")
        matchingGame = MatchingGame(fileNamed: "MatchingGame")
        
       // presentScene(scene: matchingGame!)
        
//        if let view = self.view as! SKView? {
//            gameScene = GameScene(fileNamed:"GameScene")
//            if let scene = gameScene, let skView = view as? SKView{
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//                
//                // Present the scene
//                view.presentScene(scene)
//            }
//            
//            view.ignoresSiblingOrder = true
//            
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    }
    
    func presentScene(scene : SKScene){
        if let view = self.view as! SKView? {
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
        }
    }
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        if let scene = (view as? SKView)?.scene {
            return [scene]
        } else {
            return []
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    

    
    
   
    
    
    
   
}
