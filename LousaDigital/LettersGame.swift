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
    //let fullNameArr : [String]!
    
    override func didMove(to: SKView) {
        
        //Definindo o primeiro foco
        setInitialFocus()
        
        object = childNode(withName: "object") as? SKSpriteNode
        letterBox = childNode(withName: "letterBox") as? SKSpriteNode
        
        //Criando e adicionando os gestures à view
        self.createGestures(view: self.view!, actionTouch: #selector(pressedSelect), actionPlay: #selector(pressedPlay))
        
        for i in 1...5{
            letters.append(childNode(withName: "letter\(i)") as! Button)
        }

    }
    
    func pressedSelect(){
        
        for letter in letters{
            if letter.isFocused  {
                
                selectedLetter = letter.name
                
                let fullNameArr = selectedLetter.characters.split{$0 == "r"}.map(String.init)
                 object?.texture = SKTexture(imageNamed: "object\(fullNameArr[1])")
                letterBox?.texture = SKTexture(imageNamed: selectedLetter)
                //animação da letra movendo
                //self.deactivateLettersFocuses()
  
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
}
