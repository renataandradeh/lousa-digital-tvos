//
//  CountingGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 14/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class CountingGame: SKScene {
    
    var button1 : Button?
    var button2 : Button?
    var button3 : Button?
    var box : SKSpriteNode?
    
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    
    override func didMove(to: SKView) {
        
        button1 = childNode(withName: "button1") as? Button
        button2 = childNode(withName: "button2") as? Button
        button3 = childNode(withName: "button3") as? Button
        box = childNode(withName: "box") as? SKSpriteNode
        
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
        //teste
        if (button1?.isFocused)! {
            print("errou")
        }else if (button2?.isFocused)!{
            if button2?.position != box?.position{
                button2?.movingAnimation(position: (box?.position)!)
            }
        }
    }
}
