//
//  ProfileModel.swift
//  UKChat
//
//  Created by unko on 2018/10/16.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

// 需求分析
// 1.提供分级数据
// 2.修改数据
// 3.从本地获取数据
// 4.从服务器获取数据
// 5.储存数据到服务器
// 6.储存数据到本地
// 7.

// 数据结构
// 每项数据Item都有类型与值
// Item要包含一个真值、一个展示值、一个修改后的值
// Item要能验证是否合法，是否修改，还原真值
// 要做到这点。我们需要 一个验证器、一个值转换器

protocol UKProfileModel {
    func fetchFromLocal()
    func pullFromServer()
}

protocol UKProfileModelEditable {
    func modify(item new: UKProfileItem) -> Bool
    func modify(items new: [UKProfileItem]) -> Bool
    func modifiedItems() -> [UKProfileItem]
    func isChanged() -> Bool
    
    func storeToLocal()
    func pushToServer()
}

protocol UKProfileModelDataSource {
    func numberOfSection() -> Int
    
    func numberOfItem(in section: Int) -> Int
    
    func item(of indexPath: IndexPath) -> UKProfileItem?
    
    func item(of type: UKProfileItemType) -> [UKProfileItem]
}

class ProfileModel: UKProfileModel {
    
    var items: [ProfileItem] = []
    
    init(items: [ProfileItem]) {
        self.items = items
    }
}
