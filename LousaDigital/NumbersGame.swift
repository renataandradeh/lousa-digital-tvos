//
//  NumbersGame.swift
//  LousaDigital
//
//  Created by Bruna Costa on 22/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class NumbersGame: ActivityScene {
    
//    var object: SKSpriteNode?
//    var numberBox: SKSpriteNode?
    var numbers : [Button]!
//    
//    var rightNumber : Int? = nil
//
//    var selectedNumber : String!
    
    override func didMove(to: SKView) {
        
        //Definindo o primeiro foco
//        setInitialFocus()

//        numberBox = childNode(withName: "numberBox") as? SKSpriteNode

        numbers = self["number*"] as? [Button]
        
        //tirando o foco dos botões inicialmente
        for number in numbers {
            number.isFocusable = false
            number.alpha = 0
        }

        //Criando e adicionando os gestures à view
        createGestures(view: self.view!, actionTouch: #selector(pressedSelect), actionPlay: #selector(pressedPlay))
    }
    
    func pressedSelect(){
        
//        for number in numbers{
//            if number.isFocused  {
//                
//                selectedNumber = number.name
//                
//                let fullNameArr = selectedNumber.characters.split{$0 == "r"}.map(String.init)
//              
//                rightNumber = Int(fullNameArr[1])
//                fillSpacesWithObjects(number: rightNumber!)
//                guard let numberOfItems = self.rightNumber
//                    else{
//                        return
//                }
//                
//                print("number \(numberOfItems)")
//                numberBox?.texture = SKTexture(imageNamed: selectedNumber)
//            }
//        }
    }
    
    func pressedPlay(){
//        for number in numbers{
//            if number.isFocused{
//                owl.speak((number.buttonType?.rawValue)!)
//            }
//        }
    }
//
//    private func fillSpacesWithObjects(number: Int){
//        let randomObject = arc4random_uniform(5)+1
//    
//        switch number {
//        case 1:
//            cleanObjectsTexture()
//            createObject(i: 3, randomObject: randomObject, scale: 5)
//            
//        case 2:
//            var i = 1
//            cleanObjectsTexture()
//            for _ in 1...2 {
//                
//                createObject(i: i, randomObject: randomObject, scale: 3)
//                i = 5
//            }
//        case 3:
//            var i = 1
//            cleanObjectsTexture()
//            for _ in 1...3 {
//                
//                createObject(i: i, randomObject: randomObject, scale: 2)
//                i += 2
//            }
//        case 4:
//            cleanObjectsTexture()
//            for i in 1...5 {
//                if i != 3 {
//                    
//                    createObject(i: i, randomObject: randomObject, scale: 1.5)
//                }
//            }
//        case 5:
//            cleanObjectsTexture()
//            for i in 1...5 {
//                
//                createObject(i: i, randomObject: randomObject, scale: 1.3)
//            }
//        default:
//            print("opção inválida")
//        }
//    }
//    
//    private func createObject(i: Int, randomObject : UInt32, scale: CGFloat){
//        let space = childNode(withName: "space\(i)") as? SKSpriteNode
//        space?.setScale(scale)
//        space?.texture = SKTexture(imageNamed: "object\(rightNumber!)")
//    }
//    
//    func cleanObjectsTexture(){
//        for i in 1...5{
//            let space = childNode(withName: "space\(i)") as? SKSpriteNode
//            space?.texture = SKTexture()
//            space?.setScale(0)
//        }
//    }
}
