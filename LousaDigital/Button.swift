//
//  Button.swift
//  LousaDigital
//
//  Created by Renata Gondim Andrade Theóphilo on 13/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import SpriteKit

enum ButtonType : String {
    case letter1 = "a"
    case letter2 = "e"
    case letter3 = "i"
    case letter4 = "o"
    case letter5 = "u"
    case number1 = "1"
    case number2 = "2"
    case number3 = "3"
    case number4 = "4"
    case number5 = "5"
    case buttonMatching = "Matching Game"
    case buttonCounting = "Counting Game"
    case notDefinedYet = ""
    
    init(buttonName: String){
        switch buttonName{
            case "letter1" : self = .letter1
            case "letter2" : self = .letter2
            case "letter3" : self = .letter3
            case "letter4" : self = .letter4
            case "letter5" : self = .letter5
            case "number1" : self = .number1
            case "number2" : self = .number2
            case "number3" : self = .number3
            case "number4" : self = .number4
            case "number5" : self = .number5
            case "buttonMatching" : self = .buttonMatching
            case "buttonCounting" : self = .buttonCounting
            default : self = .notDefinedYet
        }
    }
}

class Button : SKSpriteNode {

    var isFocused = false
    var isFocusable = true
    var shadow : SKSpriteNode?
    var buttonType : ButtonType?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        shadow = SKSpriteNode(texture: self.texture, color: .black, size: self.size)
        alpha = 0.5
        self.buttonType = ButtonType(buttonName: self.name!)
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
            shadow?.texture = self.texture
            let increaseAlpha = SKAction.fadeAlpha(to: 1, duration: 0.2)
            let scaleUp = SKAction.scale(to: 1.2, duration: 0.2)
            let animation = SKAction.group([increaseAlpha, scaleUp])
            run(animation, withKey: "buttonAnimation")
            
            shadow?.blendMode = SKBlendMode.alpha
            shadow?.colorBlendFactor = 1
            shadow?.anchorPoint = CGPoint(x: 0.53, y: 0.55)
            shadow?.removeFromParent()
            self.addChild(shadow!)
            shadow?.run(SKAction.fadeAlpha(to: 0.3, duration: 0.2))
            shadow?.zPosition = self.zPosition-1
            
        }else if !isFocused{
            let decreaseAlpha = SKAction.fadeAlpha(to: 0.5, duration: 0.2)
            let scaleDown = SKAction.scale(to: 1.0, duration: 0.2)
            let animation = SKAction.group([decreaseAlpha, scaleDown])
            run(animation, withKey: "buttonAnimation")
            shadow?.run(SKAction.fadeAlpha(to: 0, duration: 0.2))
        }
    }
    
    func associatingAnimation(position: CGPoint, activeView: SKView, completion: (()->())?){
        self.zPosition = 2
        let actionDuration : Double = 0.8
        let maxScale : CGFloat = 2.0
        
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
        //removendo a sombra
        shadow?.run(SKAction.fadeOut(withDuration: 2.0))
        
    }
    
    
    override public var canBecomeFocused: Bool {
        get {
            return isFocusable
        }
    }
}
