//
//  LettersGame.swift
//  LousaDigital
//
//  Created by Bruna Costa on 22/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class LettersGame: ActivityScene {
    
    var object: SKSpriteNode?
    var letterBox: SKSpriteNode?
    
    var letters : [Button] = []
  
    var selectedLetter : String!
    let firstMomentDuration : Double = 8
    let secondMomentDuration : Double = 24
    
    override func didMove(to: SKView) {
        
        //Definindo o primeiro foco
        setInitialFocus()
        
        object = childNode(withName: "object") as? SKSpriteNode
        letterBox = childNode(withName: "letterBox") as? SKSpriteNode
        
        //Criando e adicionando os gestures à view
        self.createGestures(view: self.view!)
        
        //Preenchendo um array com todas as letras da cena
        letters = self.scene!["letter1_*"] as! [Button]
        
        for letter in letters {
            letter.isFocusable = false
            letter.alpha = 0
        }

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
        }
    }
    
    func processActionForMoment(moment: Int, array: [SKSpriteNode]) {
        
    }
    
    func pressedSelect(){
        
//        for letter in letters{
//            if letter.isFocused  {
//                
//                selectedLetter = letter.name
//                
//                let fullNameArr = selectedLetter.characters.split{$0 == "r"}.map(String.init)
//                 object?.texture = SKTexture(imageNamed: "object\(fullNameArr[1])")
//                letterBox?.texture = SKTexture(imageNamed: selectedLetter)
//            }
//        }
    }
    
    func pressedPlay(){
//        for letter in letters{
//            if letter.isFocused{
//                owl.speak((letter.buttonType?.rawValue)!)
//            }
//        }
    }
}
