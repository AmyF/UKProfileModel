//
//  UKProfileRemoteDataService.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

// 数据获取
protocol UKProfileFetchRemoteDataService {
    associatedtype FetchRemoteDataServiceHandler
    func fetch(_ handler: FetchRemoteDataServiceHandler)
}

// 数据储存
protocol UKProfileStoreDataToRemoteService {
    associatedtype StoreDataToRemoteServiceHandler
    associatedtype DATA
    func store(_ data: DATA, _ handler: StoreDataToRemoteServiceHandler)
}

class UKProfileRemoteDataService: UKProfileFetchRemoteDataService, UKProfileStoreDataToRemoteService {
    fileprivate var memoryItems: [ProfileItem] = []
    
    init(items: [ProfileItem]) {
        self.memoryItems = items
    }
    
    func fetch(_ handler: @escaping ([ProfileItem], _ debugMsg: Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            handler(self.memoryItems, true)
        }
    }
    
    func store(_ items:[ProfileItem], _ handler: @escaping (_ result: Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            if items.count % 2 == 0 {
                self.memoryItems = items
                handler(true)
            }
            else {
                handler(false)
            }
        }
    }
}
