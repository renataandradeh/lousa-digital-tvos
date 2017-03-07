//
//  Menu.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 17/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class Menu: ActivityScene {
    
    var allButtons : [Button]?
    var colorsButton : Button?
    let mainSong = SKAudioNode(fileNamed: "petit_song")

    override func didMove(to view: SKView) {
        
        activeScene = self.name

        allButtons = self["button*"] as? [Button]
        colorsButton = childNode(withName: "buttonColors") as? Button
        colorsButton?.buttonDidGetFocus()

        setInitialFocus()
        
        createGestures(view: self.view!, actionPlay: #selector(pressedPlay))

        addChild(mainSong)
        mainSong.run(SKAction.play())
    }
    
    func pressedPlay(){}
    
    override func endSelected(){
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
        mainSong.run(SKAction.changeVolume(to: 0.5
            , duration: 0.3)){
            self.run(SKAction.run({
                self.view?.presentScene(scene, transition: SKTransition.fade(with: .white, duration: 1.0))
            }))
        }
    }  
}
