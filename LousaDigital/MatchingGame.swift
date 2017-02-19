//
//  MatchingGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 15/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class MatchingGame: SKScene {

    var object : SKSpriteNode?
    var matchBox : SKSpriteNode?
    var randomNumber : UInt32 = 0

    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()

    //var letter1 : Button?
    
    var letters : [Button]!
    
    let endGame = EndGame()
 
    override func didMove(to: SKView) {
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name
        
        //Definindo o primeiro foco
        setNeedsFocusUpdate()
        updateFocusIfNeeded()

        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        
        //Tap Play Pause
//        tapPlayPause.addTarget(self, action: #selector(pressedSelect))
//        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
//        self.view!.addGestureRecognizer(tapPlayPause)
        
        //Randomizando o objeto e preenchendo a matchBox
        randomNumber = arc4random_uniform(5) + 1
        
        object = childNode(withName: "object") as? SKSpriteNode
        matchBox = childNode(withName: "matchBox") as? SKSpriteNode
        
        object?.texture = SKTexture(imageNamed: "object\(randomNumber)")
        matchBox?.texture = SKTexture(imageNamed: "shadow\(randomNumber)")
    
        letters = self["letter*"] as! [Button]
    }

    func pressedSelect(){
        for letter in letters{
            if letter.isFocused && letter.name == "letter\(randomNumber)" {
                //animação da letra movendo
                self.deactivateLettersFocuses()
                letter.associatingAnimation(position: (matchBox?.position)!, activeView: self.view!) {
                    let wait = SKAction.wait(forDuration: 3.0)
                    let block = SKAction.run({
                            self.addChild(self.endGame)
                    })
                    self.run(SKAction.sequence([wait, block]), completion:{
                        self.setNeedsFocusUpdate()
                        self.updateFocusIfNeeded()
                    })
                }
                
            }else if letter.isFocused && letter.name != "letter\(randomNumber)"{
                //Voz falando: "Try Again!"
                print("errou")
            }
        }
    }
    
    func deactivateLettersFocuses() {
        for letter in letters{
            letter.isFocused = false
            letter.isFocusable = false
        }
    }
}
