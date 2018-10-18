//
//  ProfileItem.swift
//  UKChat
//
//  Created by unko on 2018/10/16.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

class ProfileItem: UKProfileItem {
    var type: Int
    
    var originValue: Any?
    
    var changedValue: Any? = nil
    
    var isChanged: Bool = false
    
    var displayValue: Any? {
        return self.converter?.build(val: originValue)
    }
    
    var needDisplay: Bool = true
    
    var converter: UKProfileItemValueConverter?
    
    var validator: UKProfileItemValueValidator?
    
    convenience init(value: Any?, type: ProfileItemType, converter: UKProfileItemValueConverter?=nil, validator: UKProfileItemValueValidator?=nil)
    {
        self.init(value: value, type: type.rawValue,
                  converter: converter,
                  validator: validator)
    }
    
    required init(value: Any?, type: Int,
                  converter: UKProfileItemValueConverter?=nil,
                  validator: UKProfileItemValueValidator?=nil)
    {
        self.originValue = value
        self.type = type
        self.converter = converter
        self.validator = validator
    }
    
    func isValid() -> Bool {
        if let value = originValue, let flag = validator?.run(val: value) {
            return flag
        }
        if let value = changedValue, let flag = validator?.run(val: value) {
            return flag
        }
        return false
    }
    
    func validateInfo() -> String? {
        return validator?.validateInfo()
    }
    
    func changeValue() -> Bool {
        return changedValue != nil
    }
}
