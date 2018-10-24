//
//  UKURLValidator.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


enum UKURLValidatorRule {
    case requiredValue
    case valid
    case maxLength(Int)
    case host(String) // host必须是xx
    case path(String) // path必须符合规则。
    case regex(String)
}

class UKURLValidator: UKValidator {
    fileprivate var rules: [UKURLValidatorRule] = []
    fileprivate var info: String?
    
    init(rules: [UKURLValidatorRule]) {
        self.rules = rules
    }
    
    func run(val: Any?) -> Bool {
        if let string = val as? String {
            return run(val: string)
        }
        
        let url = val as? URL
        return run(val: url)
    }
    
    fileprivate func run(val: String) -> Bool {
        guard let url = URL(string: val) else {
            let hasValid = rules.contains {
                rule -> Bool in
                switch rule {
                case .valid: return true
                default: return false
                }
            }
            if hasValid {
                info = "不是一个正确的链接"
            } else {
                info = nil
            }
            return !hasValid
        }
        
        return run(val: url)
    }
    
    fileprivate func run(val: URL?) -> Bool {
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
            case .valid: continue
            case .maxLength(let len):
                if val.absoluteString.count > len {
                    info = ""
                    return false
                }
            case .host(let host):
                if let vh = val.host, vh != host {
                    info = ""
                    return false
                }
            case .path(let path):
                if val.path != path {
                    info = ""
                    return false
                }
            case .regex(let p):
                if !regex(p, match: val.absoluteString) {
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
