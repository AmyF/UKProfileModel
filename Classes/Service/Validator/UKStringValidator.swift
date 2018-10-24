//
//  UKStringValidator.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


enum UKStringValidatorRule {
    case requiredValue
    case requiredString
    case minLength(Int)
    case maxLength(Int)
    case not(String)
    case regex(String)
}

class UKStringValidator: UKValidator {
    fileprivate var rules: [UKStringValidatorRule] = []
    fileprivate var info: String?
    
    init(rules: [UKStringValidatorRule]) {
        self.rules = rules
    }
    
    func run(val: Any?) -> Bool {
        let str = val as? String
        return run(val: str)
    }
    
    fileprivate func run(val: String?) -> Bool {
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
            case .requiredString:
                if val.count == 0 {
                    info = "空字符串"
                    return false
                }
            case .minLength(let len):
                if val.count < len {
                    info = "不足最小长度\(len)"
                    return false
                }
            case .maxLength(let len):
                if val.count > len {
                    info = "超过最大长度\(len)"
                    return false
                }
            case .not(let str):
                if val == str {
                    info = "\(str)不符合规定"
                    return false
                }
            case .regex(let p):
                if !regex(p, match: val) {
                    info = "不符合正则表达式[\(p)]"
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
    
    fileprivate func regex(_ p: String, match s: String) -> Bool {
        let r = try! NSRegularExpression(pattern: p, options: .caseInsensitive)
        let n = r.numberOfMatches(in: s, options: .anchored, range: NSRange(location: 0, length: s.count))
        return n > 0
    }
}
