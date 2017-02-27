//
//  NumbersGame.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 22/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class NumbersGame: ActivityScene {

    var numbers : [Button]!
    let totalAnimationTime : TimeInterval = 59
    
    override func didMove(to: SKView) {

        numbers = self["number*"] as? [Button]
        
        //tirando o foco dos botões inicialmente
        for number in numbers {
            number.isFocusable = false
            number.alpha = 0
        }
        
        //Pausando as actions da cena para esperar a fala
        setPauseForChildren(paused: true, afterTime: 0)
        owl.speak("Let's learn the numbers!")
        setPauseForChildren(paused: false, afterTime: 2)
        
        //Aguardando o final de toda a animaçao para mostrar novamente todos os números.
        run(SKAction.wait(forDuration: totalAnimationTime), completion: {
            for number in self.numbers {
                number.setScale(1.0)
                number.run(SKAction.fadeAlpha(to: 0.75, duration: 0.5)) {
                    number.isFocusable = true
                }
            }
            self.run(SKAction.wait(forDuration: 1.0)){
                self.setInitialFocus()
            }
        })

        //Criando e adicionando os gestures à view
        createGestures(view: self.view!, actionPlay: #selector(pressedPlay))
    }

    func pressedPlay(){
        for number in (self["number*"] as? [Button])! {
            if number.isFocused{
                owl.speak((number.buttonType?.rawValue)!)
            }
        }
    }

    func setPauseForChildren(paused : Bool, afterTime time: Double) {
        guard let children = self.scene?.children else { return }
        run(SKAction.wait(forDuration: time)){
            for child in children {
                child.isPaused = paused
            }
        }
    }
}
