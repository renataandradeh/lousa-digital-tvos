//
//  SoundManager.swift
//  LousaDigital
//
//  Created by Matheus Vasconcelos de Sousa on 21/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//
/*
 HOW TO USE:
 var sm = SoundManager()
 sm.playSound(named:"canto_renata.mp3")
 sm.stop()
 */

import SpriteKit

class SoundManager {
    
    var sound : SKAction?
    
    func playMainSong() -> SKAction {
        return (SKAction.playSoundFileNamed("petit_song", waitForCompletion: true))
    }
    
    func stop(){
        sound = SKAction.pause()
    }
    
}
