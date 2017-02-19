//
//  EndGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 17/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class EndGame: SKNode {
    
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    var backgrond : SKSpriteNode!
    var restart : Button!
    var home : Button!
    
    override init() {
        super.init()
        
        let endGameScene = SKScene(fileNamed: "EndGame")!
        backgrond = endGameScene.childNode(withName: "background") as! SKSpriteNode!
        restart = backgrond.childNode(withName: "restart") as? Button
        home = backgrond.childNode(withName: "home") as? Button
        backgrond.removeFromParent()
        addChild(backgrond)

        run(SKAction.run({
            //Definindo o primeiro foco
            self.addedToSuperview()
        }))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addedToSuperview() {
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.scene!.view?.addGestureRecognizer(tapGeneralSelection)
        
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: #selector(pressedSelect))
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        self.scene!.view?.addGestureRecognizer(tapPlayPause)
    }
 
    class func emittingStars(scene: SKScene, position1: CGPoint, position2: CGPoint){
        let wait = SKAction.wait(forDuration: 3.5)
        let emitting = SKAction.run({
            for i in 1...2{
                let emitter = SKEmitterNode(fileNamed: "emitter_stars")!
                scene.addChild(emitter)
                emitter.position = i == 1 ? position1 : position2
                emitter.resetSimulation()
            }
        })
        scene.run(SKAction.sequence([wait, emitting]))
    }

    func pressedSelect(){
        let selectedScene : SKScene?
        if (self.restart.isFocused){
            guard let sceneName = activeScene else { return }
            selectedScene  = { () -> SKScene? in
                switch(sceneName) {
                case "MatchingGame":
                    return MatchingGame(fileNamed: sceneName)
                case "CountingGame":
                    return CountingGame(fileNamed: sceneName)
                default:
                    return Menu(fileNamed: "Menu")
                }
            }()
        } else if (self.home.isFocused) {
            selectedScene = Menu(fileNamed: "Menu")
        } else {
            selectedScene = nil
            print("Focou em um nó que não está tratado")
        }
        self.run(SKAction.fadeOut(withDuration: 0.8)) {
            guard let view = self.scene?.view else { return }
            view.presentScene(selectedScene)
        }
    }
}
