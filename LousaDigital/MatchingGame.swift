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

    var letter1 : Button?
    
    let endGame = EndGame()
    
    override func didMove(to: SKView) {
        
        object = childNode(withName: "object") as? SKSpriteNode
        matchBox = childNode(withName: "matchBox") as? SKSpriteNode
        
        letter1 = childNode(withName: "letter1") as? Button

        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: #selector(pressedSelect))
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)
        
        randomNumber = arc4random_uniform(5) + 1
        
        object?.texture = SKTexture(imageNamed: "object\(randomNumber)")
        matchBox?.texture = SKTexture(imageNamed: "shadow\(randomNumber)")
        
    }
    
    func pressedSelect(){
        for letter in children {
            if type(of: letter) == Button.self{
                if let letter = letter as? Button{
                    if letter.isFocused{
                        if letter.name == "letter\(randomNumber)"{
                            //animação da letra movendo
                            letter.movingAnimation(position: (matchBox?.position)!)
                           
                            //Animação provisória para a tela de Game Over
                            self.run(SKAction.fadeOut(withDuration: 0.8)){
                                self.view?.presentScene(EndGame(fileNamed: "EndGame"))
                            }
                        }else{
                            print("errou")
                        }
                    }
                }
            }
        }
     }

    override var preferredFocusEnvironments: [UIFocusEnvironment]{
        letter1?.isFocused = true
        letter1?.focusAnimation()
        return[letter1!]
    }

}
