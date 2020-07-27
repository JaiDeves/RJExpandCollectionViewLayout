//
//  Datsource.swift
//  CustomCollectionAnimation
//
//  Created by apple on 21/07/20.
//  Copyright © 2020 UTC. All rights reserved.
//

import Foundation

struct Item {
    var name:String
    var isEnabled:Bool
}

struct Section<Item> {
    var name:String
    var isEnabled:Bool = false
    var items: [Item]
}

struct DataSource<Item> {
    var sections: [Section<Item>]
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func titleForHeader(in section: Int)->String{
        return sections[section].name
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].items.count
    }
    
    func item(at indexPath: IndexPath) -> Item {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    
}
