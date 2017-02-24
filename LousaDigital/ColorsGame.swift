//
//  ColorsGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 24/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class ColorsGame: SKScene {

    let tapGeneralSelection = UITapGestureRecognizer()
    let tapPlayPause = UITapGestureRecognizer()
    
    var pencils : [Button]!
    
    override func didMove(to view: SKView) {
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name
        
        //Definindo o primeiro foco
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
        
        pencils = self["*Pencil"] as? [Button]
        
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: #selector(pressedPlay))
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)
        
    }
    
    func pressedSelect(){

    }
    
    func pressedPlay(){
        for pencil in pencils {
            if pencil.isFocused {
                owl.speak((pencil.buttonType?.rawValue)!)
            }
        }
    }

}
