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
    var background : SKSpriteNode!
    var endScreen : SKSpriteNode!
    var restart : Button!
    var home : Button!
    var owlNode : SKSpriteNode!
    
    var emitterPosition1 : CGPoint?
    var emitterPosition2 : CGPoint?
    
    var stars : [SKSpriteNode]?
    
    var shadow : SKSpriteNode?
    
    override init() {
        super.init()
        
        let endGameScene = SKScene(fileNamed: "EndGame")!
        background = endGameScene.childNode(withName: "background") as! SKSpriteNode
        endScreen = background.childNode(withName: "endScreen") as! SKSpriteNode
        restart = endScreen.childNode(withName: "restart") as? Button
        home = endScreen.childNode(withName: "home") as? Button
        owlNode = background.childNode(withName: "owlNode") as! SKSpriteNode
        
        background.removeFromParent()
        background.alpha = 0
        addChild(background)
        
        //Estrelas - teste
        stars = endScreen["star*"] as? [SKSpriteNode]
        for star in stars! {
            star.run(SKAction.colorize(with: .darkGray, colorBlendFactor: 1, duration: 0))
        }
        
        //Adicionando partículas de estrelinhas
        emitterPosition1 = endScreen.childNode(withName: "emitterPosition1")?.position
        emitterPosition2 = endScreen.childNode(withName: "emitterPosition2")?.position

        run(SKAction.run({
            self.addedToSuperview()
        }))
        self.background.run(SKAction.fadeIn(withDuration: 1), completion:{
            self.endScreenAnimation()
        })

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
    
    private func endScreenAnimation() {
        let moveEndScreen = SKAction.move(to: background.position, duration: 0.25)
        let moveOwl = SKAction.moveTo(y: -(background.size.height/2.9), duration: 0.25)

        endScreen.run(moveEndScreen)
        owlNode.run(moveOwl)

        emittingStars()
    }
 
    private func emittingStars(){
        let wait = SKAction.wait(forDuration: 3.0)
        let emitting = SKAction.run({
            for i in 1...2{
                let emitter = SKEmitterNode(fileNamed: "emitter_stars")!
                self.endScreen.addChild(emitter)
                emitter.position = (i == 1 ? self.emitterPosition1 : self.emitterPosition2)!
            }
            
            owl.speak("Congratulations! Do you want to try again?")
        })
        colorizeStars()
        self.run(SKAction.sequence([wait, emitting]))
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
            owl.stopSpeaking()
            view.presentScene(selectedScene)
        }
    }
    
    func colorizeStars(){
        let star1 = stars?[0]
        let star2 = stars?[1]
        let star3 = stars?[2]
        let scale : CGFloat = 1.5
        
        let colorize = SKAction.colorize(with: .yellow, colorBlendFactor: 1, duration: 0.5)
        
        run(SKAction.wait(forDuration: 1.0), completion:{
            star1?.run(colorize, completion: {
                star1?.setScale(scale)
                star2?.run(colorize, completion: {
                    star2?.setScale(scale)
                    star3?.run(colorize, completion:{
                        star3?.setScale(scale)
                    })
                })
            })
        })
    }
}
