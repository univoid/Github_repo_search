//
//  Repo.swift
//  Github_repo_search
//
//  Created by YUHUI ZHENG on 2017/07/30.
//  Copyright © 2017 YUHUI ZHENG. All rights reserved.
//

import UIKit

class Repo {
    
    // MARK: Properties
    
    var name: String
    var owner: String
    var description: String
    var url: String
    var starCount: Int
    var forkCount: Int
    
    // MARK: Initialization
    
    init?(name: String, owner: String, des: String?, star: Int, fork: Int, url: String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Star must be positive
        guard (star >= 0) else {
            return nil
        }
        
        // Fork must be positive
        guard (fork >= 0) else {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        self.owner = owner
        self.description = des ?? ""
        self.starCount = star
        self.forkCount = fork
        self.url = url
    }
}
