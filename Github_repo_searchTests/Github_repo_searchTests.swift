//
//  Github_repo_searchTests.swift
//  Github_repo_searchTests
//
//  Created by YUHUI ZHENG on 2017/07/30.
//  Copyright © 2017 YUHUI ZHENG. All rights reserved.
//

import XCTest
@testable import Github_repo_search

class Github_repo_searchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    // MARK: Repo Class Tests
    
    // Confirm that the Repo initializer returns a Repo object when passed valid parameters
    func testRepoInitializationSuccceeds() {
        
        // Repo without Description
        let nilDesRepo = Repo.init(name: "God", owner: "me", des: "", star: 0)
        XCTAssertNotNil(nilDesRepo)
    }
    
    // Confirm that the Repo initializer returns nil when passed unvalid parameters
    func testRepoInitializationFails() {
        
        // Repo without Name
        let nilNameRepo = Repo.init(name: "", owner: "me", des: "", star: 0)
        XCTAssertNil(nilNameRepo)
        
        // Repor with nagtive Star Count
        let nagStarRepo = Repo.init(name: "God", owner: "me", des: "wantedly win", star: -1)
        XCTAssertNil(nagStarRepo)
        
    }
    
}
