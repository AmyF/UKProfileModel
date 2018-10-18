//
//  UKProfileItemValueValidator.swift
//  UKChat
//
//  Created by unko on 2018/10/18.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

// 验证器
protocol UKProfileItemValueValidator {
    func run(val: Any?) -> Bool
    
    func validateInfo() -> String?
}
