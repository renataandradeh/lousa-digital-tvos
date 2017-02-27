//
//  ColorsGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 24/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class ColorsGame: ActivityScene {

    var colorPicture : SKSpriteNode?
    var pencils : [Button]!
    
    override func didMove(to view: SKView) {
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name
        
        pencils = self["*Pencil"] as? [Button]
        colorPicture = childNode(withName: "colorPicture") as? SKSpriteNode
        colorPicture?.alpha = 0
        
        for pencil in pencils {
            pencil.isFocusable = false
        }
        
        //Criando e adicionando os gestures à view
        self.createGestures(view: self.view!, actionPlay: #selector(pressedPlay))
        
        //Fala inicial e definição de foco
        let waitFirst = SKAction.wait(forDuration: 1.0)
        let speak = SKAction.run({
            owl.speak("Now we gonna learn the colors. Press one of the pencils")
        })
        let waitSecond = SKAction.wait(forDuration: 3.75)
        let setFocus = SKAction.run {
            for pencil in self.pencils {
                pencil.isFocusable = true
            }
        }
        run(SKAction.sequence([waitFirst, speak, waitSecond, setFocus, waitFirst])){
            //Definindo o primeiro foco
            self.setInitialFocus()
        }
    }
    
    override func endSelected(){
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
}
