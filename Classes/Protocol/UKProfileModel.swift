//
//  UKProfileModel.swift
//  UKChat
//
//  Created by unko on 2018/10/18.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

typealias UKProfileModelDataHandler = (_ msg: String?, _ code: Int) -> Void

protocol UKProfileModel {
    func cmpID(_ model: Self) -> Bool
    
    func fetchDataFromLocal(_ handler: UKProfileModelDataHandler?)
    func fetchDataFromServer(_ handler:UKProfileModelDataHandler?)
    
    func storeDataToLocal(_ handler: UKProfileModelDataHandler?)
    func storeDataToServer(_ handler:UKProfileModelDataHandler?)
    
    func isValid() -> Bool
}

protocol UKProfileDisplayModel: UKProfileModel {
    func numberOfSection() -> Int
    func numberOfItem(in section: Int) -> Int
    
    func item(of type: Int) -> UKProfileItem?
    func item(of indexPath: IndexPath) -> UKProfileItem?
}

protocol UKProfileEditModel: UKProfileDisplayModel {
    func modify(item new: UKProfileItem) -> Bool
    
    func isChanged() -> Bool
}
