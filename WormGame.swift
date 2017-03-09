//
//  WormGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 21/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class WormGame: ActivityScene {
    
    var numberBodies : [Button] = []
    var randomNumbers : [Int]  = []
    var numberPositions : [CGPoint]  = []
    
    let endGame = EndGame()
    
    var currentNumber = 1
    
    override func didMove(to: SKView) {
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name
        
        //Randomizando os números na cena
        numberBodies = (self["number*"] as? [Button])!
        
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
       
        //Instruções para a atividade
        if name != lastSceneLoaded{
            run(SKAction.wait(forDuration: 1.0)){
                self.run(SKAction.playSoundFileNamed("sound_putthenumbercorrectorder", waitForCompletion: true))
            }
        }
        //Seta a variável que controla qual a última cena carregada para não ficar repetindo as instruções sempre que restartar
        lastSceneLoaded = scene?.name
        
        //Definindo o primeiro foco
        setInitialFocus()
        
        //Criando e adicionando os gestures à view
        createGestures(view: self.view!, actionPlay: #selector(pressedPlay))
    }
    
    override func endSelected(){
        for number in numberBodies{
            let currenteButton = "number\(currentNumber)"
            if number.isFocused && number.name == currenteButton{
                let body = childNode(withName: "body\(currentNumber)") as? SKSpriteNode
    
                matchingFadeAnimation(number: number, position: body!.position, zPosFinal: (body?.zPosition)! + 1, activeView: self.view!, completion: {
                    self.setNeedsFocusUpdate()
                    self.updateFocusIfNeeded()
                })
                
                if currentNumber == 5 {
                    let playSoundComplete = SKAction.playSoundFileNamed("sound_complete", waitForCompletion: true)
                    
                    let waitFirst = SKAction.wait(forDuration: 2.0)
                    let waitSecond = SKAction.wait(forDuration: 2.0)

                    let block = SKAction.run({
                        self.deactivateNumberFocus()
                        self.endGame.removeFromParent()
                        self.addChild(self.endGame)
                        self.setNeedsFocusUpdate()
                        self.updateFocusIfNeeded()
                    })
                    self.run(SKAction.sequence([waitFirst, playSoundComplete, waitSecond, block]))
                    
                }else{
                    number.isFocused = false
                    number.isFocusable = false
                    currentNumber += 1
                }
            }else if number.isFocused && number.name != currenteButton{
                number.associatingWrongAnimation()
            }
        }
    }
    
    func pressedPlay(){
        for number in numberBodies {
            if number.isFocused{
                run(SKAction.playSoundFileNamed((number.buttonType?.rawValue)!, waitForCompletion: true))
            }
        }
    }
    
    private func matchingFadeAnimation(number: Button, position: CGPoint, zPosFinal: CGFloat, activeView: SKView, completion: (()->())?){
        
        let actionDuration : Double = 0.8
        let maxScale : CGFloat = 1.3
        
        //som de acerto
        run(SKAction.playSoundFileNamed("sound_rightMatch", waitForCompletion: false))
        
        let actionScaleUp = SKAction.customAction(withDuration: actionDuration, actionBlock: { (node, elapsedTime) in
            number.zPosition = 100
            let percentage = elapsedTime/CGFloat(actionDuration)
            number.alpha = 1 - percentage/2
            number.setScale(1.25 + percentage * maxScale)
        })
        
        let actionScaleDown = SKAction.customAction(withDuration: actionDuration, actionBlock: { (node, elapsedTime) in
            number.zPosition = zPosFinal
            number.run(SKAction.fadeAlpha(to: 0, duration: 0.25))
        })
        self.run(SKAction.sequence([actionScaleUp, actionScaleDown]), completion: {
            number.position = position
            number.setScale(maxScale)
            number.isFocused = false
            number.removeAction(forKey: "buttonAnimation")
            number.run(SKAction.fadeAlpha(to: 1, duration: 1.0))
            completion?()
        })
        //removendo a sombra
        number.shadow?.run(SKAction.fadeOut(withDuration: 2.0))
    }

    func deactivateNumberFocus() {
        for number in numberBodies {
            number.isFocused = false
            number.isFocusable = false
        }
    }
}
