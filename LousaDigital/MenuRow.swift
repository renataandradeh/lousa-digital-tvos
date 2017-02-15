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
}

extension MenuRow: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activitiesCell", for: indexPath)
       
        return cell
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
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

