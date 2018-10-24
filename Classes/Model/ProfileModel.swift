//
//  ProfileModel.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


class ProfileModel: UKProfileModel {
    fileprivate let _uid: Int
    var uid: Int {
        return _uid
    }
    
    fileprivate var items: [ProfileItem] = []
    
    fileprivate let localDataService: UKProfileLocalDataService
    fileprivate let remoteDataService: UKProfileRemoteDataService
    
    init(uid: Int) {
        self._uid = uid
        
        let name = ProfileItem(value: "unko", type: .name)
        let age = ProfileItem(value: 18, type: .age)
        let email = ProfileItem(value: "840382477@qq.com", type: .email)
        self.localDataService = UKProfileLocalDataService(items: [name,age,email])
        self.remoteDataService = UKProfileRemoteDataService(items: [])
    }
    
    func Initialized() {
        fetchDataFromLocal(nil)
    }
    
    func cmpID(_ model: ProfileModel) -> Bool {
        return model.uid == self._uid
    }
    
    func fetchDataFromLocal(_ handler: ((ProfileModel, String?, Int) -> Void)?) {
        let (newItems, flag) = self.localDataService.fetch(_uid)
        if flag {
            self.items = newItems
            handler?(self, nil, 0)
        } else {
            handler?(self, "获取数据失败", -1)
        }
    }
    
    func fetchDataFromServer(_ handler:((ProfileModel, String?, Int) -> Void)?) {
        self.remoteDataService.fetch { newItems, debugMsg in
            if debugMsg {
                self.items = newItems
                handler?(self, nil, 0)
            } else {
                handler?(self, "下载数据失败", -1)
            }
        }
    }
    
    func storeDataToLocal(_ handler: ((ProfileModel, String?, Int) -> Void)?) {
        if self.localDataService.store(items) {
            handler?(self, nil, 0)
        } else {
            handler?(self, "储存数据失败", -1)
        }
    }
    
    func storeDataToServer(_ handler:((ProfileModel, String?, Int) -> Void)?) {
        self.remoteDataService.store(items) { result in
            if result {
                handler?(self, nil, 0)
            } else {
                handler?(self, "上传数据失败", -1)
            }
        }
    }
    
    func isValid() -> Bool {
        for item in items {
            if !item.isValid() {
                return false
            }
        }
        return true
    }
}



class ProfileDisplayModel: ProfileModel, UKProfileDisplayModel {
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfItem(in section: Int) -> Int {
        return items.count
    }
    
    func item(of type: Int) -> UKProfileItem? {
        for item in items {
            if item.type == type {
                return item
            }
        }
        return nil
    }
    
    func item(of indexPath: IndexPath) -> UKProfileItem? {
        return items[indexPath.item]
    }
}



// class ProfileEditModel: ProfileModel, UKProfileEditModel {
class ProfileEditModel: ProfileDisplayModel, UKProfileEditModel {
    func modify(val: Any?, type: Int) {
        for item in items {
            if item.type == type {
                item.changedValue = val
            }
        }
    }
    
    func save() -> Bool {
        for item in items {
            if !item.isValid() {
                return false
            }
        }
        for item in items {
            item.changeValue()
        }
        return true
    }
    
    func isChanged() -> Bool {
        for item in items {
            if item.isChanged {
                return true
            }
        }
        return false
    }
    
    func reset() {
        for item in items {
            item.reset()
        }
    }
}
