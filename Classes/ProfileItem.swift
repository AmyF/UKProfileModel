//
//  ProfileItem.swift
//  UKChat
//
//  Created by unko on 2018/10/16.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


// 验证器,验证传入值是否合法
protocol UKProfileItemValidator {
    func run(_ val: Any?) -> Bool
}
// 值转换器
protocol UKProfileItemConverter {
    func run(_ val: Any?) -> String
}

protocol UKProfileItemType {
    func isEqualTo(_ val: Any?) -> Bool
}

protocol UKProfileItemValue {
    func isEqualTo(_ val: Any?) -> Bool
}

// 数据项 即需求分析提到的Item
protocol UKProfileItem {
    var type: UKProfileItemType { get }
    var value: UKProfileItemValue? { get } // 真值, 只能通过方法从tmpValue转换
    var displayValue: String? { get } // 展示值，只能从真值/临时值使用转换器得到
    var tmpValue: UKProfileItemValue? { get set } // 临时值，用来储存临时修改的值
    var display: Bool { get set }
    
    mutating func save() -> Bool // 将tmpValue变成value
    func changed() -> Bool // 检查是否被修改
    func isValid() -> Bool // 检查是不是瓜的
}

struct ProfileItem: UKProfileItem {
    init(value: UKProfileItemValue?,
         type: UKProfileItemType,
         validator: UKProfileItemValidator?=nil,
         converter: UKProfileItemConverter?=nil)
    {
        self._value = value
        self._type = type
        self.validator = validator
        self.converter = converter
    }
    
    var value: UKProfileItemValue? { return _value }
    
    var displayValue: String? {
        if let val = tmpValue {
            return converter?.run(val)
        }
        return converter?.run(value)
    }
    
    var tmpValue: UKProfileItemValue?
    
    var type: UKProfileItemType { return _type }
    
    var display: Bool = true
    
    fileprivate var _value: UKProfileItemValue?
    fileprivate var _type: UKProfileItemType
    
    fileprivate var validator: UKProfileItemValidator?
    
    fileprivate var converter: UKProfileItemConverter?
    
    mutating func save() -> Bool {
        if isValid() {
            self._value = self.tmpValue
            return true
        }
        return false
    }
    
    func changed() -> Bool {
        if let flag = value?.isEqualTo(tmpValue) {
            return flag
        }
        return false
    }
    
    func isValid() -> Bool {
        guard let v = validator else { return false }
        return v.run(value)
    }
    
    func tmpIsValid() -> Bool {
        guard let v = validator else { return false }
        return v.run(tmpValue)
    }
}
