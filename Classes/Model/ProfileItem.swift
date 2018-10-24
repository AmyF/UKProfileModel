//
//  ProfileItem.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


enum ProfileItemType: Int {
    case uid
    case name
    case age
    case email
}

class ProfileItem: UKProfileItem {
    var _type: Int
    var type: Int {
        return _type
    }
    
    var _originValue: Any?
    var originValue: Any? {
        return _originValue
    }
    
    var changedValue: Any? {
        didSet {
            _isChanged = true
        }
    }
    
    var _isChanged: Bool = false
    var isChanged: Bool {
        return _isChanged
    }
    
    var displayValue: Any? {
        return converter?.build(val: changedValue)
    }
    
    var needDisplay: Bool = true
    
    fileprivate var converter: UKProfileItemValueConverter?
    fileprivate var validator: UKProfileItemValueValidator?
    
    convenience init(value: Any?, type: ProfileItemType,
                     converter: UKProfileItemValueConverter?=UKProfileItemValueDefaultConverter(),
                     validator: UKProfileItemValueValidator?=nil)
    {
        self.init(value: value, type: type.rawValue,
                  converter: converter,
                  validator: validator)
    }
    
    required init(value: Any?, type: Int,
                  converter: UKProfileItemValueConverter?,
                  validator: UKProfileItemValueValidator?)
    {
        self._originValue = value
        self.changedValue = value
        self._type = type
        self.converter = converter
        self.validator = validator
    }
    
    func isValid() -> Bool {
        guard let validator = validator else {
            return true
        }
        return validator.run(val: changedValue)
    }
    
    func validateInfo() -> String? {
        return validator?.validateInfo()
    }
    
    func changeValue() {
        _originValue = changedValue
    }
    
    func reset() {
        changedValue = _originValue
    }
}


