//
//  CountingGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 14/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class CountingGame: SKScene {
    
    var box : SKSpriteNode?
    
    var randomAnswer : UInt32?
    var answerPosition : Button?
    
    var number1 : Button?
 
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    
    override func didMove(to: SKView) {
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name
        
        //Definindo o primeiro foco
        number1 = childNode(withName: "number1") as? Button
        number1?.isFocused = true
        number1?.focusAnimation()
        
        //Preenchendo a cena com os elementos
        randomAnswer = arc4random_uniform(5)+1
        
        box = childNode(withName: "box") as? SKSpriteNode
        box?.texture = SKTexture(imageNamed: "shadowNumber\(randomAnswer!)")
        
        fillNumbers()
        fillSpacesWithObjects(number: randomAnswer!)
        
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
    }
    
    private func fillNumbers(){
        
        var numbers = [Int(randomAnswer!)]
        while numbers.count < 3 {
            let random = arc4random_uniform(5)+1
            if !numbers.contains(Int(random)){
                numbers.append(Int(random))
            }
        }
        
        let randomPosition = arc4random_uniform(3)+1
        
        let number = childNode(withName: "number\(randomPosition)") as? SKSpriteNode
        answerPosition = number as? Button
        number?.texture = SKTexture(imageNamed: "number\(randomAnswer!)")
        numbers.removeFirst()
        
        for i in 1...3{
            let number = childNode(withName: "number\(i)") as? SKSpriteNode
            if i != Int(randomPosition){
                number?.texture = SKTexture(imageNamed:"number\(numbers[0])")
                numbers.removeFirst()
            }
        }
    }
    
    
    private func fillSpacesWithObjects(number: UInt32){
        let randomObject = arc4random_uniform(5)+1
        switch number {
        case 1:
            createObject(i: 3, randomObject: randomObject, scale: 5)
            
        case 2:
            var i = 1
            for _ in 1...2 {
                createObject(i: i, randomObject: randomObject, scale: 3)
                i = 5
            }
        case 3:
            var i = 1
            for _ in 1...3 {
                createObject(i: i, randomObject: randomObject, scale: 2)
                i += 2
            }
        case 4:
            for i in 1...5 {
                if i != 3 {
                    createObject(i: i, randomObject: randomObject, scale: 1.5)
                }
            }
        case 5:
            for i in 1...5 {
                createObject(i: i, randomObject: randomObject, scale: 1.2)
            }
        default:
            print("opção inválida")
        }
    }
 
    private func createObject(i: Int, randomObject : UInt32, scale: CGFloat){
        let space = childNode(withName: "space\(i)") as? SKSpriteNode
        space?.setScale(scale)
        space?.texture = SKTexture(imageNamed: "object\(randomObject)")
    }
    
    func pressedSelect(){
        for i in 1...3 {
            let number = childNode(withName: "number\(i)") as? Button
            if (number?.isFocused)! && number == answerPosition{
                number?.associatingAnimation(position: (box?.position)!, activeView: self.view!)
            }
        }
    }
    
}
