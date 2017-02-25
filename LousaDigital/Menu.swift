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
                case "buttonCounting":
                    presentGame(scene: CountingGame(fileNamed: "CountingGame")!)
                case "buttonWorm":
                    presentGame(scene: WormGame(fileNamed: "WormGame")!)
                case "buttonLetters":
                    presentGame(scene: LettersGame(fileNamed: "LettersGame")!)
                case "buttonNumbers":
                    presentGame(scene: NumbersGame(fileNamed: "NumbersGame")!)
                case "buttonColors":
                    presentGame(scene: ColorsGame(fileNamed: "ColorsGame")!)
                default:
                    print("Cena não existe")
                }
            }
        }
    }
    
    private func presentGame(scene: SKScene){
        self.run(SKAction.run({
            self.view?.presentScene(scene)
        }))
    }
}
