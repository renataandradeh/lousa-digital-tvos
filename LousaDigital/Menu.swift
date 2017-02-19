//
//  Menu.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 17/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class Menu: SKScene {
    
    let tapGeneralSelection = UITapGestureRecognizer()
    var allButtons : [Button]?
    
    override func didMove(to view: SKView) {
    
        //Definindo o primeiro foco
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
        
        allButtons = self["button*"] as? [Button]
        
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
    }
    
    func pressedSelect(){
        for button in allButtons!{
            if button.isFocused{
                switch button.name! {
                case "buttonMatching":
                    presentGame(scene: MatchingGame(fileNamed: "MatchingGame")!)
                case "buttonCounting":
                    presentGame(scene: CountingGame(fileNamed: "CountingGame")!)
                default:
                    print("Cena não existe")
                }
            }
        }
    }
    
    private func presentGame(scene: SKScene){
        self.run(SKAction.fadeOut(withDuration: 0.8)){
            self.view?.presentScene(scene)
        }
    }
    override var preferredFocusEnvironments: [UIFocusEnvironment]{
        return[allButtons![0]]
    }
    
}
