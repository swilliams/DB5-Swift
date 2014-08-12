//
//  ThemeLoaderTest.swift
//  PhotoScout
//
//  Created by Scott Williams on 8/12/14.
//  Copyright (c) 2014 Scott Williams. All rights reserved.
//

import UIKit
import XCTest

class ThemeLoaderTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit() {
        // given
        let loader = ThemeLoader(themeFilename: "themes")

        // when

        // then
        XCTAssertNotNil(loader, "loader didn't load")
    }

    func testThemeNamed() {
        // given
        let loader = ThemeLoader(themeFilename: "themes")

        // when
        let theme = loader.themeNamed("Other")

        // then
        XCTAssertNotNil(theme)
        XCTAssertEqual("other string", theme!.stringForKey("testString")!)
    }

    func testThemeNamedNil() {
        // given
        let loader = ThemeLoader(themeFilename: "themes")

        // when

        // then
        XCTAssertNil(loader.themeNamed("Derp"))
    }
}
