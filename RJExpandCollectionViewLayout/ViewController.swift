//
//  UICoolCollectionViewController.swift
//  CustomCollectionAnimation
//
//  Created by apple on 21/07/20.
//  Copyright © 2020 UTC. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionCell"
private let headerId = "HeaderView"

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    var datasource:DataSource<String> = DataSource(sections: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    func setUp(){
        for index in 0..<3{
            let items = (0...5).map{ String($0) }
            datasource.sections.append(
                Section(name: String(index), isEnabled: false, items: items))
        }
        ///Register Section Header
        let nib = UINib(nibName: headerId, bundle: nil)
        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        /// set CollectionView Layout
        let layout = RJExpandCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 0)
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func headerViewTapAction(indexPath:IndexPath){
        let isEnabled = !self.datasource.sections[indexPath.section].isEnabled
        self.datasource.sections[indexPath.section].isEnabled = isEnabled
        
        var indexPaths:[IndexPath] = []
        let items = self.datasource.sections[indexPath.section].items
        
        for index in 0..<items.count{
            indexPaths.append(
                IndexPath(item: index, section: indexPath.section)
            )
        }
        collectionView.performBatchUpdates({
            if isEnabled{
                collectionView.insertItems(at: indexPaths)
            }else{
                collectionView.deleteItems(at: indexPaths)
            }
        }, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if datasource.sections[section].isEnabled{
            return datasource.numberOfItems(in: section)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCell
        cell.textLabel.text = datasource.sections[indexPath.section].items[indexPath.row]
        
        cell.backgroundColor = UIColor.random
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderView
        headerView.textLabel.text = datasource.sections[indexPath.section].name
        
        headerView.tapAction = { [weak self] in
            guard let `self` = self else { return }
            self.headerViewTapAction(indexPath: indexPath)
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = CGSize(width: collectionView.bounds.width, height: 40)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sectionInset = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let width = collectionView.bounds.width - sectionInset.left - sectionInset.right
        let size = CGSize(width: width, height: 30)
        
        return size
    }
}


