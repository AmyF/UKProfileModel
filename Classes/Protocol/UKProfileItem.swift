//
//  UKProfileItem.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

protocol UKProfileItem {
    var type: Int { get }
    
    var originValue: Any? { get }
    
    var changedValue:Any? { get set }
    
    var isChanged: Bool { get }
    
    var displayValue: Any? { get }
    
    var needDisplay: Bool { get set }
    
    init(value: Any?, type: Int,
         converter: UKProfileItemValueConverter?,
         validator: UKProfileItemValueValidator?)
    
    // 验证编辑值/原值
    func isValid() -> Bool
    
    // 得到验证后的结果，可以用在HUD提示
    func validateInfo() -> String?
    
    // 改变编辑值到实际值
    func changeValue()
    
    // 还原改变
    func reset()
}


