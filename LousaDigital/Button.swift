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
    var isFocusable = true
    
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
        if isFocusable{
            focusAnimation()
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
            let prevItem = context.previouslyFocusedItem
            let nextItem = context.nextFocusedItem
            
            if let prevButton = prevItem as? Button{
                if context.nextFocusedItem === self {
                    prevButton.buttonDidLoseFocus()
                }
                if let nextButton = nextItem as? Button {
                    nextButton.buttonDidGetFocus()
                }
            }
    }
    
    func focusAnimation() {
        if isFocused{
            let scaleUp = SKAction.scale(by: 2.0, duration: 0.5)
            let scaleDown = SKAction.scale(by: 0.5, duration: 0.5)
            let animation = SKAction.repeatForever(SKAction.group([scaleUp, scaleDown]))
            run(animation, withKey: "buttonAnimation")
        }else if !isFocused{
            run(SKAction.scale(to: 1, duration: 0.5), withKey: "buttonAnimation")
        }
    }
    
    func associatingAnimation(position: CGPoint, activeView: SKView, completion: (()->())?){
        self.zPosition = 2
        let actionDuration : Double = 1.0
        let maxScale : CGFloat = 2.5
        let actionScaleUp = SKAction.customAction(withDuration: actionDuration, actionBlock: { (node, elapsedTime) in
            let percentage = elapsedTime/CGFloat(actionDuration)
            self.alpha = 1 - percentage/2
            self.setScale(1 + percentage * maxScale)
        })
        let actionScaleDown = SKAction.customAction(withDuration: actionDuration, actionBlock: { (node, elapsedTime) in
            let percentage = elapsedTime/CGFloat(actionDuration)
            self.alpha = 1 + percentage
            self.run(SKAction.scale(to: 1.5, duration: actionDuration))
            self.run(SKAction.move(to: position, duration: 1.0))
        })
        
        self.run(SKAction.sequence([actionScaleUp, actionScaleDown]), completion: {
            self.isFocused = false
            self.removeAction(forKey: "buttonAnimation")
            completion?()
        })
    }
    
    
    override public var canBecomeFocused: Bool {
        get {
            return isFocusable
        }
    }
}
