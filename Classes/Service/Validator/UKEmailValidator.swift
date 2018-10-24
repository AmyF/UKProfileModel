//
//  UKEmailValidator.swift
//  UKProfileModel
//
//  Created by unko on 2018/10/24.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation


enum UKEmailValidatorRule {
    case requiredValue
    case valid
    case maxLength(Int)
    case nameMaxLength(Int)
    case host(String) // host必须是xx
    case subdomain(String) // 子域必须包含xx。com.cn里，com和cn是不同的子域
    case regex(String)
}

class UKEmail {
    fileprivate var _name: String = ""
    var name: String {
        return _name
    }
    
    fileprivate var _host: String = ""
    var host: String {
        return _host
    }
    
    fileprivate var _subdomains: [String] = []
    var subdomains: [String] {
        return _subdomains
    }
    
    var string: String
    
    var isValid: Bool = false
    
    init(string: String) {
        self.string = string
        parse(string)
    }
    
    fileprivate func parse(_ string: String) {
        // TODO: Mac还没开机，还没法写
    }
}

class UKEmailValidator: UKValidator {
    fileprivate var rules: [UKEmailValidatorRule] = []
    fileprivate var info: String?
    
    init(rules: [UKEmailValidatorRule]) {
        self.rules = rules
    }
    
    func run(val: Any?) -> Bool {
        if let string = val as? String {
            return run(val: string)
        }
        let email = val as? UKEmail
        return run(val: email)
    }
    
    fileprivate func run(val: String) -> Bool {
        let email = UKEmail(string: val)
        return run(val:email)
    }
    
    fileprivate func run(val: UKEmail?) -> Bool {
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
            case .valid:
                if !val.isValid {
                    info = ""
                    return false
                }
            case .maxLength(let len):
                if val.string.count > len {
                    info = ""
                    return false
                }
            case .nameMaxLength(let len):
                if val.name.count > len {
                    info = ""
                    return false
                }
            case .host(let host):
                if val.host != host {
                    info = ""
                    return false
                }
            case .subdomain(let subdomain):
                if !val.subdomains.contains(subdomain) {
                    info = ""
                    return false
                }
            case .regex(let p):
                if !regex(p, match: val.string) {
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
