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
        
        //Setando a cena ativa para facilitar as transições
        activeScene = self.name

        numbers = self["number*"] as? [Button]
        
        //tirando o foco dos botões inicialmente
        for number in numbers {
            number.isFocusable = false
            number.alpha = 0
        }
        
        //Pausando as actions da cena para esperar a fala
        scene?.speed = 0.75
        let speakPhrase = SKAction.playSoundFileNamed("sound_letslearnournumbers", waitForCompletion: true)
        let wait = SKAction.wait(forDuration: 0.5)
        setPauseForChildren(paused: true, afterTime: 0)
        run(SKAction.sequence([wait, speakPhrase]), completion: {
            self.scene?.speed = 1.0
        })
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
        createGestures(view: self.view!, actionPlay: #selector(endSelected))
    }

    override func endSelected() {
        for number in (self["number*"] as? [Button])! {
            if number.isFocused{
                self.run(SKAction.playSoundFileNamed((number.buttonType?.rawValue)!, waitForCompletion: true))
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
