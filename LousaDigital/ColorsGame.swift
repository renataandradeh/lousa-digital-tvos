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
    let tapMenu = UITapGestureRecognizer()
    
    var colorPicture : SKSpriteNode?
    var pencils : [Button]!
    
    override func didMove(to view: SKView) {
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name
        
        //Definindo o primeiro foco
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
        
        pencils = self["*Pencil"] as? [Button]
        colorPicture = childNode(withName: "colorPicture") as? SKSpriteNode
        colorPicture?.alpha = 0
        
        //Touch Pressed
        tapGeneralSelection.addTarget(self, action: #selector(pressedSelect))
        tapGeneralSelection.allowedPressTypes = [NSNumber (value: UIPressType.select.rawValue)]
        self.view!.addGestureRecognizer(tapGeneralSelection)
        
        //Tap Play Pause
        tapPlayPause.addTarget(self, action: #selector(pressedPlay))
        tapPlayPause.allowedPressTypes = [NSNumber (value: UIPressType.playPause.rawValue)]
        self.view!.addGestureRecognizer(tapPlayPause)
        
        //Tap Menu
        tapMenu.addTarget(self, action: #selector(pressedMenu))
        tapMenu.allowedPressTypes = [NSNumber (value: UIPressType.menu.rawValue)]
        self.view!.addGestureRecognizer(tapMenu)
        
        run(SKAction.wait(forDuration: 1.0)){
            owl.speak("Now we gonna learn the colors. Press one of the pencils")
        }
    }
    
    func pressedSelect(){
        colorPicture?.alpha = 0
        for pencil in pencils{
            if pencil.isFocused{
                colorPicture?.texture = SKTexture(imageNamed: (pencil.buttonType?.rawValue)!)
                colorPicture?.run(SKAction.fadeAlpha(to: 1, duration: 0.5), completion: {
                    owl.speak((pencil.buttonType?.rawValue)!)
                })
            }
        }
    }
    
    func pressedPlay(){
        for pencil in pencils {
            if pencil.isFocused {
                owl.speak((pencil.buttonType?.rawValue)!)
            }
        }
    }
    
    func pressedMenu() {
        self.view?.presentScene(Menu(fileNamed: "Menu"))
    }

}
