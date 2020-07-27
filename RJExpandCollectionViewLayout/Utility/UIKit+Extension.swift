//
//  UIKit+Extension.swift
//  CustomCollectionAnimation
//
//  Created by apple on 27/07/20.
//  Copyright © 2020 UTC. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
