//
//  LettersGame.swift
//  LousaDigital
//
//  Created by Bruna Costa on 22/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class LettersGame: SKScene {
    var object: SKSpriteNode?
    var letterBox: SKSpriteNode?
    var letters : [Button] = []
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    let tapMenu = UITapGestureRecognizer()
    
    
    var selectedLetter : String!
    //let fullNameArr : [String]!
    
    override func didMove(to: SKView) {
        
        //Definindo o primeiro foco
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
        
        
        object = childNode(withName: "object") as? SKSpriteNode
        letterBox = childNode(withName: "letterBox") as? SKSpriteNode
        
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: #selector(pressedPlay))
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)
        //Tap Menu 
        tapMenu.addTarget(self, action: #selector(pressedMenu))
        tapMenu.allowedPressTypes = [NSNumber (value: UIPressType.menu.rawValue)]
        self.view!.addGestureRecognizer(tapMenu)
        
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
    func pressedMenu() {
        self.view?.presentScene(Menu(fileNamed: "Menu"))
    }

}
