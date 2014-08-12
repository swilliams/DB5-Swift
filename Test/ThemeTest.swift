//
//  ThemeTest.swift
//  PhotoScout
//
//  Created by Scott Williams on 8/12/14.
//  Copyright (c) 2014 Scott Williams. All rights reserved.
//

import UIKit
import XCTest

var _theme: Theme?

class ThemeTest: XCTestCase {

    override func setUp() {
        super.setUp()
        let url = NSBundle.mainBundle().URLForResource("testTheme", withExtension: "plist")
        let dict = NSDictionary(contentsOfURL: url)
        _theme = Theme(fromDictionary: dict)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: - colowWithString
    func testColorWithHexString() {
        // given
        let redColor = UIColor.redColor()

        // when
        let result = colorWithHexString("#ff0000")

        // then
        XCTAssertEqual(result, redColor, "Expected red")
    }

    func testColorWithHexStringNullString() {
        // given
        let black = UIColor.blackColor()

        // when
        let result = colorWithHexString(nil)

        // then
        XCTAssertEqual(result, black, "Expected nil string to be black")
    }

    // MARK: - stringIsEmpty
    func testStringIsEmptyWithString() {
        // given
        let notEmpty = "foo"

        // when
        let result = stringIsEmpty(notEmpty)

        // then
        XCTAssert(!result, "'foo' should not be empty")
    }

    func testStringIsEmptyWithEmpty() {
        // given
        let empty = ""

        // when
        let result = stringIsEmpty(empty)

        // then
        XCTAssert(result, "empty should be empty")
    }

    func testStringIsEmptyNullString() {
        // given

        // when
        let result = stringIsEmpty(nil)

        // then
        XCTAssert(result, "nil should be empty")
    }

    // MARK: - Theme
    func testThemeInit() {
        // given
        let dict = NSDictionary(object: true, forKey: "thing")

        // when
        let theme = Theme(fromDictionary: dict)

        // then
        XCTAssertNotNil(theme, "theme should not be nil")
        XCTAssert(theme.boolForKey("thing")!, "boolForKey should be true")
    }

    func testStringForKey() {
        // given

        // when

        // then
        XCTAssertEqual("oh hi", _theme!.stringForKey("testString")!, "expected greeting to match up")
    }

    func testStringForBadKey() {
        // given

        // when

        // then
        XCTAssertNil(_theme!.stringForKey("does not exist"), "expected a nil for a bad key")
    }

    func testStringForNumberKey() {
        // given

        // when

        // then
        XCTAssertEqual("2", _theme!.stringForKey("testInsetLeft")!, "expected a string for a number value")
    }

    func testIntForKey() {
        // given

        // when

        // then
        XCTAssertEqual(100, _theme!.integerForKey("testInt"), "expected an int value")
    }

    func testIntForBadKey() {
        // given

        // when

        // then
        XCTAssertEqual(0, _theme!.integerForKey("does not exist"), "expected a 0 for a bad key")
    }

    func testFloatForKey() {
        // given

        // when

        // then
        XCTAssertEqual(20.5, _theme!.floatForKey("testFloat"), "expected a 20.5 for float")
    }

    func testImageForKeyBadKey() {
        // given

        // when

        // then
        XCTAssertNil(_theme!.imageForKey("does not exist"), "expected a nil for a bad image key")
    }

    func testColorForKey() {
        // given
        let defaultColor = UIColor.blackColor()

        // when
        let resultColor = _theme!.colorForKey("testColor")

        // then
        XCTAssertNotNil(resultColor, "expected a color for a color key")
        XCTAssertNotEqual(defaultColor, resultColor, "expected color not to be the default black")
    }

    func testColorForKeyDefault() {
        // given
        let defaultColor = UIColor.blackColor()

        // when

        // then
        XCTAssertEqual(defaultColor, _theme!.colorForKey("does not exist"), "expected the default black for a bad key")
    }

    func testEditInsetsForKey() {
        // given

        // when
        let insets = _theme!.edgeInsetsForKey("testInset")

        // then
        XCTAssertEqual(2, insets.left, "left did not load")
        XCTAssertEqual(3, insets.top, "top did not load")
        XCTAssertEqual(4, insets.right, "right did not load")
        XCTAssertEqual(5, insets.bottom, "bottom did not load")
    }

    func testFontForKey() {
        // given

        // when
        let font = _theme!.fontForKey("testFont")

        // then
        XCTAssertEqual("Helvetica", font.familyName, "expected Helvetica for the font name")
        XCTAssertEqual(15, font.pointSize, "expected a size of 15")
    }

    func testPointForKey() {
        // given

        // when
        let point = _theme!.pointForKey("testPoint")

        // then
        XCTAssertEqual(5, point.x)
        XCTAssertEqual(3, point.y)
    }

    func testSizeForKey() {
        // given

        // when
        let size = _theme!.sizeForKey("testSize")

        // then
        XCTAssertEqual(11, size.width)
        XCTAssertEqual(13, size.height)
    }

    func testTimeForKey() {
        // given

        // when

        // then
        XCTAssertEqual(20.5, _theme!.timeIntervalForKey("testFloat"))
    }

    func testCurveForKey() {
        // given

        // when

        // then
        XCTAssertEqual(UIViewAnimationOptions.CurveEaseOut, _theme!.curveForKey("testCurve"))
    }

    func testAnimationSpecifierForKey() {
        // given

        // when
        let specifier = _theme!.animationSpecifierForKey("testAnimation")

        // then
        XCTAssertEqual(4, specifier.duration)
        XCTAssertEqual(2, specifier.delay)
        XCTAssertEqual(UIViewAnimationOptions.CurveLinear, specifier.curve)
    }

    func testTextCaseForKey() {
        // given

        // when

        // then
        XCTAssertEqual(TextCaseTransform.Lower, _theme!.textCaseForKey("testTextCase"))
    }
}
