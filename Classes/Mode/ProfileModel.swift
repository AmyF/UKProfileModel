//
//  ProfileModel.swift
//  UKChat
//
//  Created by unko on 2018/10/16.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

class ProfileModel {
    fileprivate var _uid: Int
    var uid: Int {
        return _uid
    }
    
    fileprivate var items: [[ProfileItem]] = []
    
    fileprivate var localDataService = ProfileLocalDataService()
    fileprivate var serverDataService = ProfileServerDataService()
    
    init(uid: Int) {
        self._uid = uid
    }
}

extension ProfileModel: UKProfileModel {
    func cmpID(_ model: ProfileModel) -> Bool {
        return uid == model.uid
    }
    
    func fetchDataFromLocal(_ handler: ((String?, Int) -> Void)?) {
        self.items = localDataService.fetch(by: uid)
        handler?(nil,0)
    }
    
    func fetchDataFromServer(_ handler: ((String?, Int) -> Void)?) {
        serverDataService.fetch(by: uid) { [weak self](items) in
            if items.count == 0 {
                handler?("not found", -1)
                return
            }
            self?.items = items
            handler?(nil, 0)
        }
    }
    
    func storeDataToLocal(_ handler: ((String?, Int) -> Void)?) {
        
    }
    
    func storeDataToServer(_ handler: ((String?, Int) -> Void)?) {
        
    }
    
    func isValid() -> Bool {
        for section in items {
            for item in section {
                if !item.isValid() {
                    return false
                }
            }
        }
        return true
    }
}
