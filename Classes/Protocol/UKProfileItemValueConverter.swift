//
//  UKProfileItemValueConverter.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


// 将原值/编辑值转换成界面上展示的值的转换器
protocol UKProfileItemValueConverter {
    func build(val: Any?) -> Any?
}

class UKProfileItemValueDefaultConverter: UKProfileItemValueConverter {
    func build(val: Any?) -> Any? {
        return val
    }
}
