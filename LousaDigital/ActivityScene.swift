//
//  ActivityScene.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 25/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class ActivityScene: SKScene {
    
    private let tapGeneralSelection = UITapGestureRecognizer()
    private let tapPlayPause = UITapGestureRecognizer()
    private let tapMenu = UITapGestureRecognizer()
    
    func createGestures(view: SKView, actionTouch: Selector?, actionPlay: Selector?){
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: actionTouch!)
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
    
    func pressedMenu(){
        self.run(SKAction.run {
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
