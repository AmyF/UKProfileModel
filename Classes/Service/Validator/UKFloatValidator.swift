//
//  UKFloatValidator.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import UIKit


enum UKFloatValidatorRule {
    case requiredValue
    case min(CGFloat)
    case max(CGFloat)
    case not([CGFloat])
}

class UKFloatValidator: UKValidator {
    fileprivate var rules: [UKFloatValidatorRule] = []
    fileprivate var info: String?
    
    init(rules: [UKFloatValidatorRule]) {
        self.rules = rules
    }
    
    func run(val: Any?) -> Bool {
        let num = val as? CGFloat
        return run(val: num)
    }
    
    fileprivate func run(val: CGFloat?) -> Bool {
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
                    info = "低于最小值\(num)"
                    return false
                }
            case .max(let num):
                if val > num {
                    info = "超过最大值\(num)"
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
