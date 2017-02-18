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
 
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    
    override func didMove(to: SKView) {
        
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
        
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: #selector(pressedSelect))
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)
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
        switch number {
        case 1:
            let space = childNode(withName: "space3") as? SKSpriteNode
            space?.texture = SKTexture(imageNamed: "object\(number)")
        case 2:
            var i = 1
            for _ in 1...2 {
                let space = childNode(withName: "space\(i)") as? SKSpriteNode
                space?.texture = SKTexture(imageNamed: "object\(number)")
                i = 5
            }
        case 3:
            var i = 1
            for _ in 1...3 {
                let space = childNode(withName: "space\(i)") as? SKSpriteNode
                space?.texture = SKTexture(imageNamed: "object\(number)")
                i += 2
            }
        case 4:
            for i in 1...5 {
                if i != 3 {
                    let space = childNode(withName: "space\(i)") as? SKSpriteNode
                    space?.texture = SKTexture(imageNamed: "object\(number)")
                }
            }
        case 5:
            for i in 1...5 {
                    let space = childNode(withName: "space\(i)") as? SKSpriteNode
                    space?.texture = SKTexture(imageNamed: "object\(number)")
            }
        default:
            print("opção inválida")
        }
    }
    
    
    
    func pressedSelect(){
        //teste
//        if (button1?.isFocused)! {
//            print("errou")
//        }else if (button2?.isFocused)!{
//            if button2?.position != box?.position{
//                button2?.movingAnimation(position: (box?.position)!)
//            }
//        }
    }
}
