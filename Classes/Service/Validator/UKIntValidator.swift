//
//  UKIntValidator.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


enum UKIntValidatorRule {
    case requiredValue
    case min(Int)
    case max(Int)
    case not([Int])
}

class UKIntValidator: UKValidator {
    fileprivate var rules: [UKIntValidatorRule] = []
    fileprivate var info: String?
    
    init(rules: [UKIntValidatorRule]) {
        self.rules = rules
    }
    
    func run(val: Any?) -> Bool {
        let num = val as? Int
        return run(val: num)
    }
    
    fileprivate func run(val: Int?) -> Bool {
        guard let val = val else {
            let requiredValue = rules.contains {
                rule -> Bool in
                switch rule {
                case .requiredValue: return true
                default: return false
                }
            }
            if requiredValue {
                info = "值为nil"
            } else {
                info = nil
            }
            return !requiredValue
        }
        
        for rule in rules {
            switch rule {
            case .requiredValue: continue
            case .min(let num):
                if val < num {
                    info = "小于最小值\(num)"
                    return false
                }
            case .max(let num):
                if val > num {
                    info = "大于最大值\(num)"
                    return false
                }
            case .not(let nums):
                for num in nums {
                    if val == num {
                        info = "\(num)不符合规定"
                        return false
                    }
                }
            }
        }
        info = nil
        return true
    }
    
    func validateInfo() -> String? {
        return info
    }
}
