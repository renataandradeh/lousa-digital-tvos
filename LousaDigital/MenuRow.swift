//
//  MenuCollectionViewCell.swift
//  TesteChallengeAppleTV
//
//  Created by Bruna Costa on 10/02/17.
//  Copyright © 2017 Bruna Costa. All rights reserved.
//

import UIKit

class MenuRow: UITableViewCell {
    
    
    @IBOutlet weak var collectionViewMenu: UICollectionView!
    

    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
       // collectionViewMenu.addGestureRecognizer(tapGesture)
        
//        if collectionViewMenu == self.collectionViewMenu {
//            print(context.nextFocusedIndexPath as Any)
//            let indexPath = context.nextFocusedIndexPath
//            print("OK!!")
//            if indexPath != nil {
//                let cell = collectionView.cellForItem(at: indexPath!)
////                cell?.layer.borderWidth = 2.0
////               cell?.layer.borderColor = UIColor.blue.cgColor
//            }
//            
//        }
    }
    
//    func selectItem(at indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition){
//        let cell = collectionViewMenu.cellForItem(at: indexPath!)
//        cell?.layer.borderWidth = 2.0
//        cell?.layer.borderColor = UIColor.blue.cgColor
//    }
//    
//    func deselectItem(at indexPath: IndexPath, animated: Bool){
//        
//    }

    
}

extension MenuRow: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activitiesCell", for: indexPath)
       
        return cell
    }
    
    
    
    
}
extension MenuRow: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 4
        let hardCoddedPadding: CGFloat = 5
        let itemWidth = (collectionView.bounds.width/itemPerRow) - hardCoddedPadding
        let itemHeight = collectionView.bounds.height - (2*hardCoddedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}



