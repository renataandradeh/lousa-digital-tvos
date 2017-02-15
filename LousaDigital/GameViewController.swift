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

class GameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate {
    
    var gameScene : SKScene?
    var countingGame : SKScene?
    var matchingGame : SKScene?
    
    var activities = ["alfabeto", "numeros", "mundo", "cores", "mais"]
     @IBOutlet weak var tableViewMenu: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameScene = GameScene(fileNamed: "GameScene")
        countingGame = CountingGame(fileNamed: "CountingGame")
        matchingGame = MatchingGame(fileNamed: "MatchingGame")
        
        presentScene(scene: matchingGame!)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return activities[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMenu.dequeueReusableCell(withIdentifier: "cell") as! MenuRow
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
