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
    
    var letters : [SKSpriteNode] = []
  
    var selectedLetter : String!
    let firstMomentDuration : Double = 8
    let secondMomentDuration : Double = 8
    
    override func didMove(to: SKView) {
        
        //Definindo o primeiro foco
        setInitialFocus()
        
        object = childNode(withName: "object") as? SKSpriteNode
        letterBox = childNode(withName: "letterBox") as? SKSpriteNode
        
        //Criando e adicionando os gestures à view
        self.createGestures(view: self.view!, actionTouch: #selector(pressedSelect), actionPlay: #selector(pressedPlay))
        
        //Preenchendo um array com todas as letras da cena
        letters = self.scene?["letter1_*"] as! [SKSpriteNode]
        

        //Action customizada que checa letra por letra se sua animação terminou para poder falar
        var lettersCopy = letters
        
        let firstMomentActions = SKAction.customAction(withDuration: firstMomentDuration, actionBlock: { (_, _) in
            if let nextLetter = lettersCopy.first, !nextLetter.hasActions(), let letterName = nextLetter.name {
                owl.speak(ButtonType(buttonName: letterName.replacingOccurrences(of: "1_", with: "")).rawValue)
                lettersCopy.removeFirst()
            }
        })
        
        let fadeOut = SKAction.run({
            for letter in self.letters {
                letter.run(SKAction.fadeAlpha(to: 0, duration: 1.0))
            }
        })
        
        let secondMomentActions = SKAction.customAction(withDuration: secondMomentDuration, actionBlock: { (_, _) in
            
        })
        
        run(SKAction.sequence([firstMomentActions, fadeOut]))
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
