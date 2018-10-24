//
//  UKProfileModel.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

protocol UKProfileModel {
    func cmpID(_ model: Self) -> Bool
    
    associatedtype FetchDataFromLocalHandler
    func fetchDataFromLocal(_ handler: FetchDataFromLocalHandler?)
    associatedtype FetchDataFromServerHandler
    func fetchDataFromServer(_ handler:FetchDataFromServerHandler?)
    
    associatedtype StoreDataToLocalHandler
    func storeDataToLocal(_ handler: StoreDataToLocalHandler?)
    associatedtype StoreDataToServerHandler
    func storeDataToServer(_ handler:StoreDataToServerHandler?)
    
    func isValid() -> Bool
}


protocol UKProfileDisplayModel: UKProfileModel {
    func numberOfSection() -> Int
    func numberOfItem(in section: Int) -> Int
    
    func item(of type: Int) -> UKProfileItem?
    func item(of indexPath: IndexPath) -> UKProfileItem?
}

protocol UKProfileEditModel: UKProfileModel {
    func modify(val: Any?, type: Int)
    
    func save() -> Bool
    
    func isChanged() -> Bool
    
    func reset()
}
