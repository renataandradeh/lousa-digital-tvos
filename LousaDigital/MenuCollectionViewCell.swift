//
//  MenuCollectionViewCell.swift
//  TesteChallengeAppleTV
//
//  Created by Bruna Costa on 14/02/17.
//  Copyright © 2017 Bruna Costa. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activitieImage: UIImageView!
    
    override var preferredFocusEnvironments: [UIFocusEnvironment]{
        return [activitieImage]
    }
    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (context.previouslyFocusedView != nil) && (context.nextFocusedView != nil){
            if context.nextFocusedView is MenuCollectionViewCell {
                self.setNeedsFocusUpdate()
            }}
    }
}
