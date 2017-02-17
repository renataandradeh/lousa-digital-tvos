//
//  EndGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 17/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class EndGame: SKScene {
    
    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    var restart : Button?
    var home : Button?
    
    override func didMove(to view: SKView) {
        
        restart = childNode(withName: "restart") as? Button
        home = childNode(withName: "home") as? Button
        
        restart?.isFocused = true
        restart?.focusAnimation()
        
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
        if (restart?.isFocused)!{
            self.run(SKAction.fadeOut(withDuration: 0.8)){
                self.view?.presentScene(MatchingGame(fileNamed: "MatchingGame"))
            }
        }else if (home?.isFocused)!{
            
        }
        
    }
}
