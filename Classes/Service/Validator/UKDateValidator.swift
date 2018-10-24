//
//  UKDateValidator.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


enum UKDateValidatorRule {
    case requiredValue
    case min(Date)
    case max(Date)
}

class UKDateValidator: UKValidator {
    fileprivate var rules: [UKDateValidatorRule] = []
    fileprivate var info: String?
    
    init(rules: [UKDateValidatorRule]) {
        self.rules = rules
    }
    
    func run(val: Any?) -> Bool {
        let date = val as? Date
        return run(val: date)
    }
    
    fileprivate func run(val: Date?) -> Bool {
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
            case .min(let date):
                if val.compare(date) == .orderedAscending {
                    info = "未到日期\(date)"
                    return false
                }
            case .max(let date):
                if val.compare(date) == .orderedDescending {
                    info = "超过日期\(date)"
                    return false
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
