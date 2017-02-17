//
//  Menu.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 17/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class Menu: SKScene {
    
    var matchingGame : Button?
    let tapGeneralSelection = UITapGestureRecognizer()
    
    override func didMove(to view: SKView) {
        matchingGame = childNode(withName: "matchingGame") as? Button
        matchingGame?.isFocused = true
        matchingGame?.focusAnimation()
        
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
    }
    
    func pressedSelect(){
        if (matchingGame?.isFocused)!{
            self.run(SKAction.fadeOut(withDuration: 0.8)){
                self.view?.presentScene(MatchingGame(fileNamed: "MatchingGame"))
            }
        }
    }
    
}
