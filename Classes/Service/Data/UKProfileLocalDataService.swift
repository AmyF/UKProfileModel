//
//  UKProfileLocalDataService.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

// 数据获取
protocol UKProfileFetchLocalDataService {
    associatedtype FetchLocalDataServiceDebugMsg
    func fetch(_ uid: Int) -> (FetchLocalDataServiceDebugMsg)
}

// 数据储存
protocol UKProfileStoreDataToLocalService {
    associatedtype StoreDataToLocalServiceDebugMsg
    associatedtype DATA
    func store(_ data: DATA) -> StoreDataToLocalServiceDebugMsg
}

class UKProfileLocalDataService: UKProfileFetchLocalDataService, UKProfileStoreDataToLocalService {
    
    fileprivate var memoryItems: [ProfileItem] = []
    
    init(items: [ProfileItem]) {
        self.memoryItems = items
    }
    
    func fetch(_ uid: Int) -> ([ProfileItem], Bool) {
        return (memoryItems, true)
    }
    
    func store(_ items: [ProfileItem]) -> Bool {
        self.memoryItems = items
        return true
    }
}
