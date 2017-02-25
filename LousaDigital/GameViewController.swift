//
//  GameViewController.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 13/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import UIKit
import SpriteKit

var activeScene : String?
let owl = VoiceManager()

class GameViewController: UIViewController {
    
    var menu : SKScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = Menu(fileNamed: "Menu")
        
        activeScene = menu?.name
        
        presentScene(scene: menu!)
        
        
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
        self.view = SKView()
        if let view = self.view as! SKView? {
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
//    override var preferredFocusEnvironments: [UIFocusEnvironment] {
//        if let scene = (view as? SKView)?.scene {
//            return [scene]
//        } else {
//            return []
//        }
//    }
}
