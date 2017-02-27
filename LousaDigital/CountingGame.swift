//
//  CountingGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 14/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class CountingGame: ActivityScene {
    
    var box : SKSpriteNode?
    
    var randomAnswer : UInt32?
    var answerPosition : Button?
    
    var allNumbers : [Button]?
    
    let endGame = EndGame()
    
    override func didMove(to: SKView) {
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name
        
        allNumbers = (self["number*"] as! [Button])
        
        //Preenchendo a cena com os elementos
        randomAnswer = arc4random_uniform(5)+1
        
        //Onde fica a sombra do número
        box = childNode(withName: "box") as? SKSpriteNode
        
        //Fazendo a sombra do número e adicionando à box
        let shadow = SKSpriteNode(texture: SKTexture(imageNamed: "number\(Int(randomAnswer!))"), color: .black, size: (box?.size)!)
        shadow.setScale(1.5)
        shadow.blendMode = SKBlendMode.alpha
        shadow.colorBlendFactor = 1
        shadow.alpha = 0.75
        shadow.position = (box?.position)!
        addChild(shadow)

        //Preenchendo a cena com os números
        fillNumbers()
        
        //Definindo o primeiro foco
        setInitialFocus()
        
        fillSpacesWithObjects(number: randomAnswer!)
        
        //Criando e adicionando os gestures à view
        createGestures(view: self.view!, actionPlay: #selector(pressedPlay))
        
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
        
        let number = childNode(withName: "number\(randomPosition)") as? Button
        answerPosition = number
        number?.texture = SKTexture(imageNamed: "number\(randomAnswer!)")
        number?.buttonType = ButtonType(buttonName: "number\(randomAnswer!)")
        numbers.removeFirst()
        
        for i in 1...3{
            let number = childNode(withName: "number\(i)") as? Button
            if i != Int(randomPosition){
                number?.texture = SKTexture(imageNamed:"number\(numbers[0])")
                number?.buttonType = ButtonType(buttonName:"number\(numbers[0])")

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
                createObject(i: i, randomObject: randomObject, scale: 1.3)
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
    
    private func deactivateNumbers(){
        for number in allNumbers!{
            number.isFocused = false
            number.isFocusable = false
        }
    }
    
    override func endSelected(){
        for number in (self["number*"] as? [Button])! {
            if (number.isFocused) {
                if number == answerPosition{
                    deactivateNumbers()
                    number.associatingAnimation(position: (box?.position)!, zPosFinal: 2, activeView: self.view!) {
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
                }else {
                    number.associatingWrongAnimation()
                }
            }
        }
    }
    
    func pressedPlay(){
        for number in (self["number*"] as? [Button])! {
            if number.isFocused{
                owl.speak((number.buttonType?.rawValue)!)
            }
        }
    }
}
