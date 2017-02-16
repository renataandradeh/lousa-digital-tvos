//
//  MenuCollectionViewCell.swift
//  TesteChallengeAppleTV
//
//  Created by Bruna Costa on 14/02/17.
//  Copyright © 2017 Bruna Costa. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var activitieImage: UIImageView!
    
    override var preferredFocusEnvironments: [UIFocusEnvironment]{
        return [activitieImage]
    }
    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        return true
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
    }
    lazy private var motionEffectGroup: UIMotionEffectGroup = {
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -8.0
        horizontalMotionEffect.maximumRelativeValue = 8.0
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -8.0
        verticalMotionEffect.maximumRelativeValue = 8.0
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalMotionEffect,verticalMotionEffect]
            
        return motionEffectGroup
    }()
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

        if self === context.previouslyFocusedView {
            coordinator.addCoordinatedAnimations({
            self.transform = CGAffineTransform.identity
            self.layer.shadowOpacity = 0.0
            self.layer.shadowOffset = CGSize(width: 0, height: 15)
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
            self.removeMotionEffect(self.motionEffectGroup)}, completion: nil)
        }else if self === context.nextFocusedView {
            coordinator.addCoordinatedAnimations({
                self.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
               self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 15)
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1.0)
            self.addMotionEffect(self.motionEffectGroup)}, completion: nil)
            //print(context.nextFocusedView)
        }
        
        
    }
   
    
}
