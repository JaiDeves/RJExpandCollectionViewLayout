//
//  HeaderView.swift
//  CustomCollectionAnimation
//
//  Created by apple on 21/07/20.
//  Copyright © 2020 UTC. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var textLabel: UILabel!
    var tapAction:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func headerViewTapped(){
        tapAction?()
    }
}
