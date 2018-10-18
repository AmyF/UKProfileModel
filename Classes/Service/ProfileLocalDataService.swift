//
//  FetchLocalDataService.swift
//  UKChat
//
//  Created by unko on 2018/10/18.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


class ProfileLocalDataService {
    func fetch(by uid: Int) -> [[ProfileItem]] {
        let idItem = ProfileItem(value: 10000, type: .id)
        idItem.needDisplay = false
        let nameItem = ProfileItem(value: "unko", type: .name)
        let ageItem = ProfileItem(value: 16, type: .age)
        
        return [[idItem],[nameItem,ageItem]]
    }
    
    func store() {
        
    }
}
