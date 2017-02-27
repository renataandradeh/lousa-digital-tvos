//
//  LettersGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 22/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class LettersGame: ActivityScene {
    
    var object: SKSpriteNode?
    var letterBox: SKSpriteNode?
    
    var letters : [Button] = []
  
    var selectedLetter : String!
    let firstMomentDuration : Double = 10
    let secondMomentDuration : Double = 18
    
    override func didMove(to: SKView) {
        
        object = childNode(withName: "object") as? SKSpriteNode
        letterBox = childNode(withName: "letterBox") as? SKSpriteNode
        
        //Criando e adicionando os gestures à view
        self.createGestures(view: self.view!, actionTouch: #selector(pressedPlay), actionPlay: #selector(pressedPlay))
        
        //Preenchendo um array com todas as letras da cena
        letters = self.scene!["letter1_*"] as! [Button]
        
        for letter in letters {
            letter.isFocusable = false
            letter.alpha = 0
        }
        
        //Pausando as actions da cena para esperar a fala
        setPauseForChildren(paused: true, afterTime: 0)
        owl.speak("Let's learn the vowels!")
        setPauseForChildren(paused: false, afterTime: 2)

        //Action customizada que checa letra por letra se sua animação terminou para poder falar
        var firstLetters = letters
        var secondLetters = self.scene!["letter2_*"] as! [SKSpriteNode]
        
        let firstMomentActions = SKAction.customAction(withDuration: firstMomentDuration, actionBlock: { (_, _) in
            if let nextLetter = firstLetters.first, !nextLetter.hasActions(), let letterName = nextLetter.name {
                owl.speak(ButtonType(buttonName: letterName.replacingOccurrences(of: "1_", with: "")).rawValue)
                firstLetters.removeFirst()
            }
        })
        let fadeOut = SKAction.group([SKAction.run({
            for letter in self.letters {
                letter.run(SKAction.fadeAlpha(to: 0, duration: 1.0))
            }
        }), SKAction.wait(forDuration: 3.0)])
        let slowDown = SKAction.run { 
            self.scene?.run(SKAction.speed(to: 0.75, duration: 0.1))
        }
        let secondMomentActions = SKAction.customAction(withDuration: secondMomentDuration, actionBlock: { (_, _) in
            if let nextLetter = secondLetters.first, !nextLetter.hasActions(), let letterName = nextLetter.name {
                owl.speak(ButtonType(buttonName: letterName.replacingOccurrences(of: "2_", with: "")).rawValue)
                let speak = SKAction.run({ 
                    owl.speak(ButtonType(buttonName: letterName.replacingOccurrences(of: "2_", with: "") + "Obj").rawValue)
                })
                nextLetter.run(SKAction.sequence([
                    SKAction.group([SKAction.wait(forDuration: 1.0), speak]),
                    SKAction.wait(forDuration: 1.0),
                    SKAction.fadeOut(withDuration: 0.5),
                    ]))
                secondLetters.removeFirst()
            }
        })
        
        run(SKAction.sequence([firstMomentActions, fadeOut, slowDown, secondMomentActions])){
            self.speed = 1.0
            for letter in self.letters {
                letter.setScale(1.0)
                letter.run(SKAction.fadeAlpha(to: 0.75, duration: 0.5)) {
                    letter.isFocusable = true
                }
            }
            self.run(SKAction.wait(forDuration: 1.0)){
                self.setInitialFocus()
            }
        }
    }
    
    func setPauseForChildren(paused : Bool, afterTime time: Double) {
        guard let children = self.scene?.children else { return }
        run(SKAction.wait(forDuration: time)){
            for child in children {
                child.isPaused = paused
            }
        }
    }
    
    func pressedPlay(){
        for letter in letters{
            if letter.isFocused{
                owl.speak(ButtonType(buttonName: (letter.name?.replacingOccurrences(of: "1_", with: ""))!).rawValue)
            }
        }
    }
}
