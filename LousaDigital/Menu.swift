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
    let owl = VoiceManager()
    
    var buttonMatching : Button?

    override func didMove(to view: SKView) {
        
        activeScene = self.name
        
        allButtons = self["button*"] as? [Button]
        allButtons?.first?.buttonDidGetFocus()
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
                    owl.speak("You've selected the Matching game! Woow! I'm an owl!")
                case "buttonCounting":
                    presentGame(scene: CountingGame(fileNamed: "CountingGame")!)
                    owl.speak("You've selected the Counting! Woow! Olha o gás!")
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
}
