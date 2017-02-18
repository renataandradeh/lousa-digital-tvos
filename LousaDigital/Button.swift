//
//  Button.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 13/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

class Button : SKSpriteNode {

    var isFocused = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isUserInteractionEnabled = true
    }
    
    func buttonDidGetFocus() {
        isFocused = true
        focusAnimation()
    }
    
    func buttonDidLoseFocus() {
        isFocused = false
        run(SKAction.scale(to: 1, duration: 0.5), withKey: "buttonAnimation")
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        let prevItem = context.previouslyFocusedItem
        let nextItem = context.nextFocusedItem
        
        if let prevButton = prevItem as? Button {
            if context.nextFocusedItem === self {
                prevButton.buttonDidLoseFocus()
            }
            if let nextButton = nextItem as? Button {
                nextButton.buttonDidGetFocus()
            }
        }
    }
    
    func focusAnimation() {
        let scaleUp = SKAction.scale(by: 2.0, duration: 0.5)
        let scaleDown = SKAction.scale(by: 0.5, duration: 0.5)
        let animation = SKAction.repeatForever(SKAction.group([scaleUp, scaleDown]))
        run(animation, withKey: "buttonAnimation")
    }
    
    func associatingAnimation(position: CGPoint){
        self.zPosition = 2
        let actionDuration : Double = 1.0
        let maxScale : CGFloat = 2.5
        let actionScaleUp = SKAction.customAction(withDuration: actionDuration, actionBlock: { (node, elapsedTime) in
            let percentage = elapsedTime/CGFloat(actionDuration)
            self.alpha = 1 - percentage
            self.setScale(1 + percentage * maxScale)
            self.position = CGPoint(x: 0, y: 0)
        })
        let actionScaleDown = SKAction.customAction(withDuration: actionDuration, actionBlock: { (node, elapsedTime) in
            let percentage = elapsedTime/CGFloat(actionDuration)
            self.alpha = 1 + percentage
            self.run(SKAction.scale(to: 0.8, duration: actionDuration))
            self.position = (position)
        })
        
        self.run(SKAction.sequence([actionScaleUp, actionScaleDown]))
        
        
//        let animation = SKAction.group([SKAction.scale(by: 0.8, duration: 0.2), SKAction.move(to: position, duration: 0.2)])
//        self.run(animation, withKey: "buttonAnimation")
    }
    
    override public var canBecomeFocused: Bool {
        get {
            return true
        }
    }
}
