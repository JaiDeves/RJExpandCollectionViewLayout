//
//  RJExpandCollectionViewLayout.swift
//  ActionableInsight
//
//  Created by apple on 24/07/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class RJExpandCollectionViewLayout: UICollectionViewFlowLayout {
    var deleteIndexPaths:[IndexPath] = []
    var insertIndexPaths:[IndexPath] = []
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        self.deleteIndexPaths = []
        self.insertIndexPaths = []
        
        for update in updateItems{
            if update.updateAction == .delete{
                if let indexPaths = update.indexPathBeforeUpdate{
                    self.deleteIndexPaths.append(indexPaths)
                }
            }else if update.updateAction == .insert{
                if let indexPaths = update.indexPathAfterUpdate{
                    self.insertIndexPaths.append(indexPaths)
                }
            }
        }
        
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        self.insertIndexPaths = []
        self.deleteIndexPaths = []
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        if self.insertIndexPaths.contains(itemIndexPath){
            attributes = attributes ?? self.layoutAttributesForItem(at: itemIndexPath)
            attributes?.alpha = 0.0
            let headerAttributes = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: itemIndexPath)
            
            attributes?.frame.origin.y = headerAttributes?.frame.maxY ?? 0
        }
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        if self.deleteIndexPaths.contains(itemIndexPath){
            attributes = attributes ?? self.layoutAttributesForItem(at: itemIndexPath)
            attributes?.alpha = 0.0

            let headerAttributes = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: itemIndexPath)
            
            attributes?.frame.origin.y = headerAttributes?.frame.origin.y ?? 0
        }
        return attributes
    }
}
