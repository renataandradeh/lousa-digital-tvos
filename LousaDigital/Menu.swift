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
    var countingGame : Button?
    let tapGeneralSelection = UITapGestureRecognizer()
    
    override func didMove(to view: SKView) {
        matchingGame = childNode(withName: "matchingGame") as? Button
        matchingGame?.isFocused = true
        matchingGame?.focusAnimation()
        
        countingGame = childNode(withName: "countingGame") as? Button

        
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
    }
    
    func pressedSelect(){
        if let matchingGame = matchingGame, let countingGame = countingGame{
            if matchingGame.isFocused{
                presentGame(scene: MatchingGame(fileNamed: "MatchingGame")!)
            }else if countingGame.isFocused{
                presentGame(scene: CountingGame(fileNamed: "CountingGame")!)
            }
        }
    }
    
    private func presentGame(scene: SKScene){
        self.run(SKAction.fadeOut(withDuration: 0.8)){
            self.view?.presentScene(scene)
        }
    }
    
}
