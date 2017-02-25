//
//  VoiceManager.swift
//  LousaDigital
//
//  Created by Matheus Vasconcelos de Sousa on 20/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import AVFoundation

/* HOW TO USE
 
 Instance class:
 let owl = VoiceManager()
 
 Speak:
 owl.speak("hello")
 
 */

class VoiceManager {
    
    private let speechSynthesizer : AVSpeechSynthesizer
    private let speechPitch : Float
    private let speechLanguage : AVSpeechSynthesisVoice
    
    init() {
        speechSynthesizer = AVSpeechSynthesizer()
        speechPitch = 1.5
        speechLanguage = AVSpeechSynthesisVoice(language: "en-US")!
    }
    
    func speak(_ text: String) {
        let speechExpression = AVSpeechUtterance(string: text)
        speechExpression.pitchMultiplier = self.speechPitch
        speechExpression.voice = self.speechLanguage
        speechExpression.rate = 0.4
        speechSynthesizer.speak(speechExpression)
    }
    
    func stopSpeaking() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
    
}
