//
//  MatchingGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 15/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class MatchingGame: ActivityScene {

    var object : SKSpriteNode?
    var matchBox : SKSpriteNode?
    var randomNumber : UInt32 = 0
    
    var letters : [Button]!
    
    let endGame = EndGame()
 
    override func didMove(to: SKView) {
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name
        
        //Instructions for the game
        run(SKAction.wait(forDuration: 1.0)){
            owl.speak("Select the number!")
        }
        
        //Definindo o primeiro foco
        setInitialFocus()
        
        //Randomizando o objeto e preenchendo a matchBox
        randomNumber = arc4random_uniform(5) + 1
        
        object = childNode(withName: "object") as? SKSpriteNode
        matchBox = childNode(withName: "matchBox") as? SKSpriteNode
        
        object?.texture = SKTexture(imageNamed: "object\(randomNumber)")
        matchBox?.texture = SKTexture(imageNamed: "shadow\(randomNumber)")
    
        letters = self["letter*"] as! [Button]
        
        //Criando e adicionando os gestures à view
        createGestures(view: self.view!, actionPlay: #selector(pressedPlay))
        
    }
    

    override func endSelected(){
        for letter in letters{
            if letter.isFocused && letter.name == "letter\(randomNumber)" {
                //animação da letra movendo
                self.deactivateLettersFocuses()
                letter.associatingAnimation(position: (matchBox?.position)!, zPosFinal: 2, activeView: self.view!) {
                    let wait = SKAction.wait(forDuration: 2.0)
                    let block = SKAction.run({
                            self.endGame.removeFromParent()
                            self.addChild(self.endGame)
                    })
                    self.run(SKAction.sequence([wait, block]), completion:{
                        self.setNeedsFocusUpdate()
                        self.updateFocusIfNeeded()
                    })
                }
                
            }else if letter.isFocused && letter.name != "letter\(randomNumber)"{
                //Voz falando: "Try Again!"
                letter.associatingWrongAnimation()
                print("errou")
            }
        }
    }
    
    func pressedPlay(){
        for letter in letters{
            if letter.isFocused{
                owl.speak((letter.buttonType?.rawValue)!)
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
