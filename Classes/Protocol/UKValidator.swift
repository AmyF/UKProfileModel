//
//  UKValidator.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


typealias UKProfileItemValueValidator = UKValidator

protocol UKValidator {
    func run(val: Any?) -> Bool
    
    func validateInfo() -> String?
}
