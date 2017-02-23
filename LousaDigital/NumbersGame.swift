//
//  NumbersGame.swift
//  LousaDigital
//
//  Created by Bruna Costa on 22/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class NumbersGame: SKScene {
    var object: SKSpriteNode?
    var numberBox: SKSpriteNode?
    var numbers : [Button] = []
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    var rightNumber : Int? = nil
    
    
    var selectedNumber : String!
    //let fullNameArr : [String]!
    
    override func didMove(to: SKView) {
        
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
        
        //object = childNode(withName: "object") as? SKSpriteNode
        numberBox = childNode(withName: "numberBox") as? SKSpriteNode
        
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: #selector(pressedPlay))
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)

        for i in 1...5{
            numbers.append(childNode(withName: "number\(i)") as! Button)
        }
 
    }
    
    func pressedSelect(){
        
        for number in numbers{
            if number.isFocused  {
                
                selectedNumber = number.name
                
                let fullNameArr = selectedNumber.characters.split{$0 == "r"}.map(String.init)
              
                rightNumber = Int(fullNameArr[1])
                fillSpacesWithObjects(number: rightNumber!)
                guard let numberOfItems = self.rightNumber
                    else{
                        return
                }
                
                print("number \(numberOfItems)")
               // object?.texture = SKTexture(imageNamed: "object\(fullNameArr[1])")
                numberBox?.texture = SKTexture(imageNamed: selectedNumber)
                //animação da letra movendo
                //self.deactivateLettersFocuses()
                
                
            }
        }
    }
    
    func pressedPlay(){
        for number in numbers{
            if number.isFocused{
                owl.speak((number.buttonType?.rawValue)!)
            }
        }
    }
    
    private func fillSpacesWithObjects(number: Int){
        let randomObject = arc4random_uniform(5)+1
    
        switch number {
        case 1:
            cleanObjectsTexture()
            createObject(i: 3, randomObject: randomObject, scale: 5)
            
        case 2:
            var i = 1
            cleanObjectsTexture()
            for _ in 1...2 {
                
                createObject(i: i, randomObject: randomObject, scale: 3)
                i = 5
            }
        case 3:
            var i = 1
            cleanObjectsTexture()
            for _ in 1...3 {
                
                createObject(i: i, randomObject: randomObject, scale: 2)
                i += 2
            }
        case 4:
            cleanObjectsTexture()
            for i in 1...5 {
                if i != 3 {
                    
                    createObject(i: i, randomObject: randomObject, scale: 1.5)
                }
            }
        case 5:
            cleanObjectsTexture()
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
        space?.texture = SKTexture(imageNamed: "object\(rightNumber!)")
        
        
    }
    
    func cleanObjectsTexture(){
        for i in 1...5{
            let space = childNode(withName: "space\(i)") as? SKSpriteNode
            space?.texture = SKTexture()
            space?.setScale(0)
        }
        
    }

}
