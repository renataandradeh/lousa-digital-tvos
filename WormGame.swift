//
//  WormGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 21/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class WormGame: SKScene {

    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()

    var numberBodies : [Button] = []
    var randomNumbers : [Int]  = []
    var numberPositions : [CGPoint]  = []
    
    let endGame = EndGame()
    
    var currentNumber = 1
    
    override func didMove(to: SKView) {
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name
        
        //Definindo o primeiro foco
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
        
        //Randomizando os números na cena
        numberBodies = (self["numberBody*"] as? [Button])!
        
        for number in numberBodies {
            numberPositions.append(number.position)
        }
        
        while (randomNumbers.count) < numberBodies.count {
            let random = Int(arc4random_uniform(UInt32(numberBodies.count)))
            if !(randomNumbers.contains(random)){
                randomNumbers.append(random)
            }
        }
        
        for number in numberBodies {
            let index = randomNumbers.first
            number.position = (numberPositions[index!])
            randomNumbers.removeFirst()
        }

        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: #selector(pressedSelect))
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)
    }
    
    func pressedSelect(){
        for number in numberBodies{
            let currenteButton = "numberBody\(currentNumber)"
            if number.isFocused && number.name == currenteButton{
                let body = childNode(withName: "body\(currentNumber)")
                number.zPosition = (body?.zPosition)!+1
                number.associatingAnimation(position: body!.position, activeView: self.view!, completion: nil)
                if currentNumber == 5 {
                    let wait = SKAction.wait(forDuration: 2.0)
                    let block = SKAction.run({
                        self.addChild(self.endGame)
                    })
                    self.run(SKAction.sequence([wait, block]), completion:{
                        self.setNeedsFocusUpdate()
                        self.updateFocusIfNeeded()
                    })
                }else{
                    currentNumber += 1
                }
            }
            
                
                
                
//            }else if letter.isFocused && letter.name != "letter\(randomNumber)"{
//                //Voz falando: "Try Again!"
//                print("errou")
//            }
        }
    }
    
    func pressedPlay(){
//        for letter in letters{
//            if letter.isFocused{
//                owl.speak((letter.buttonType?.rawValue)!)
//            }
//        }
    }
}
