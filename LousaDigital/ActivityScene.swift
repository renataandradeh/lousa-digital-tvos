//
//  ActivityScene.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 25/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

let soundManager = SoundManager()

class ActivityScene: SKScene {
    
    private let tapGeneralSelection = UITapGestureRecognizer()
    private let tapPlayPause = UITapGestureRecognizer()
    private let tapMenu = UITapGestureRecognizer()
    
    func createGestures(view: SKView) {
        //Tap Menu
        tapMenu.addTarget(self, action: #selector(pressedMenu))
        tapMenu.allowedPressTypes = [NSNumber (value: UIPressType.menu.rawValue)]
        view.addGestureRecognizer(tapMenu)
    }
    
    func createGestures(view: SKView, actionPlay: Selector?){
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelected))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        view.addGestureRecognizer(tapGeneralSelection)
        
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: actionPlay!)
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        view.addGestureRecognizer(tapPlayPause)
        
        //Tap Menu
        tapMenu.addTarget(self, action: #selector(pressedMenu))
        tapMenu.allowedPressTypes = [NSNumber (value: UIPressType.menu.rawValue)]
        view.addGestureRecognizer(tapMenu)
    }
    
    //som de clique dos botões
    let playSound = SKAction.playSoundFileNamed("button click", waitForCompletion: false)
    
    func pressedSelected(){
        //Anima os botões
        for child in children{
            if let button = child as? Button, button.isFocused{
                button.run(SKAction.sequence([SKAction.scale(by: 0.8, duration: 0.2), playSound, SKAction.scale(by: 1.25, duration: 0.2)]))
            }
        }
        run(SKAction.wait(forDuration: 0.4)){
            self.endSelected()
        }
    }
    
    func endSelected(){}
    
    func pressedMenu(){
        self.run(SKAction.run {
            owl.stopSpeaking()
            self.view?.presentScene(Menu(fileNamed: "Menu"))
        }, withKey: "load")
    }
    
    func setInitialFocus(){
        self.run(SKAction.run{
            self.setNeedsFocusUpdate()
            self.updateFocusIfNeeded()
        }, withKey: "load")
    }
}
