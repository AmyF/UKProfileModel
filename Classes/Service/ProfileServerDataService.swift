//
//  FetchServerDataService.swift
//  UKChat
//
//  Created by unko on 2018/10/18.
//  Copyright © 2018 unko. All rights reserved.
//

import Foundation

class ProfileServerDataService {
    func fetch(by uid: Int, _ handler: ([[ProfileItem]])->Void) {
        handler([])
    }
}
