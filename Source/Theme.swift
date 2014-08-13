//
//  Theme.swift
//  PhotoScout
//
//  Created by Scott Williams on 8/9/14.
//  Copyright (c) 2014 Scott Williams. All rights reserved.
//

import UIKit

enum TextCaseTransform {
    case None, Upper, Lower
}

func stringIsEmpty(s: String?) -> Bool {
    if s == nil {
        return true
    }
    return countElements(s!) == 0
}

// Picky. Crashes by design.
func colorWithHexString(hexString: String?) -> UIColor {
    if stringIsEmpty(hexString) {
        return UIColor.blackColor()
    }
    var s: NSMutableString = NSMutableString(string: hexString)
    s.replaceOccurrencesOfString("#", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: NSMakeRange(0, countElements(hexString!)))
    CFStringTrimWhitespace(s)
    let redString = s.substringToIndex(2)
    let greenString = s.substringWithRange(NSMakeRange(2, 2))
    let blueString = s.substringWithRange(NSMakeRange(4, 2))

    var r: UInt32 = 0, g: UInt32 = 0, b: UInt32 = 0
    NSScanner(string: redString).scanHexInt(&r)
    NSScanner(string: greenString).scanHexInt(&g)
    NSScanner(string: blueString).scanHexInt(&b)

    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
}

struct AnimationSpecifier {
    var delay: NSTimeInterval
    var duration: NSTimeInterval
    var curve: UIViewAnimationOptions
}

public class Theme: NSObject {
    var name: String
    var parentTheme: Theme?

    private let themeDictionary: NSDictionary
    private let colorCache: NSCache
    private let fontCache: NSCache

    // MARK: - Init
    init(fromDictionary themeDictionary: NSDictionary) {
        name = "Default"
        parentTheme = nil
        colorCache = NSCache()
        fontCache = NSCache()
        self.themeDictionary = themeDictionary
    }

    // MARK: - Queries
    private func objectForKey(key: String) -> AnyObject? {
        var obj: AnyObject? = themeDictionary[key]
        if obj == nil {
            obj = parentTheme?.objectForKey(key)
        }
        return obj
    }

    func boolForKey(key: String) -> Bool? {
        let obj: AnyObject? = objectForKey(key)
        if obj == nil {
            return false
        }
        return obj as Bool!
    }

    func stringForKey(key: String) -> String? {
        let obj: AnyObject? = objectForKey(key)
        if obj == nil {
            return nil
        }
        if obj is String {
            return obj as String!
        }
        if obj is NSNumber {
            return (obj as NSNumber!).stringValue
        }
        return nil
    }

    func integerForKey(key: String) -> Int {
        let obj: AnyObject? = objectForKey(key)
        if obj == nil {
            return 0
        }
        return obj as Int
    }

    func floatForKey(key: String) -> CGFloat {
        let obj: AnyObject? = objectForKey(key)
        if obj == nil {
            return 0.0
        }
        return obj as CGFloat
    }

    func imageForKey(key: String) -> UIImage? {
        let imageName = stringForKey(key)
        if stringIsEmpty(imageName) {
            return nil
        }
        return UIImage(named: imageName)
    }

    func colorForKey(key: String) -> UIColor {
        let cachedColor: UIColor? = colorCache.objectForKey(key) as? UIColor
        if cachedColor != nil {
            return cachedColor!
        }
        let colorString = stringForKey(key)
        var color = colorWithHexString(colorString)
        if color == nil {
            color = UIColor.blackColor()
        }
        colorCache.setObject(color, forKey: key)
        return color
    }

    func edgeInsetsForKey(key: String) -> UIEdgeInsets {
        let left: CGFloat = floatForKey(key.stringByAppendingString("Left"))
        let top: CGFloat = floatForKey(key.stringByAppendingString("Top"))
        let right: CGFloat = floatForKey(key.stringByAppendingString("Right"))
        let bottom: CGFloat = floatForKey(key.stringByAppendingString("Bottom"))
        return UIEdgeInsetsMake(top, left, bottom, right)
    }

    func fontForKey(key: String) -> UIFont {
        let cachedFont = fontCache.objectForKey(key) as? UIFont
        if cachedFont != nil {
            return cachedFont!
        }
        let fontName = stringForKey(key)
        var fontSize = floatForKey(key.stringByAppendingString("Size"))
        if fontSize < 15.0 {
            fontSize = 15.0
        }
        var font: UIFont
        if stringIsEmpty(fontName) {
            font = UIFont.systemFontOfSize(fontSize)
        } else {
            font = UIFont(name: fontName!, size: fontSize)
        }
        if font == nil {
            font = UIFont.systemFontOfSize(fontSize)
        }
        fontCache.setObject(font, forKey: key)
        return font
    }

    func pointForKey(key: String) -> CGPoint {
        let pointX = floatForKey(key.stringByAppendingString("X"))
        let pointY = floatForKey(key.stringByAppendingString("Y"))
        return CGPointMake(pointX, pointY)
    }

    func sizeForKey(key: String) -> CGSize {
        let width = floatForKey(key.stringByAppendingString("Width"))
        let height = floatForKey(key.stringByAppendingString("Height"))
        return CGSizeMake(width, height)
    }

    func timeIntervalForKey(key: String) -> NSTimeInterval {
        var obj: AnyObject? = objectForKey(key)
        if obj == nil {
            return 0.0
        }
        return obj as Double!
    }

    func curveForKey(key: String) -> UIViewAnimationOptions {
        var curveString = stringForKey(key)!
        if stringIsEmpty(curveString) {
            return .CurveEaseInOut
        }
        curveString = curveString.lowercaseString
        if curveString == "easeinout" {
            return .CurveEaseInOut
        } else if curveString == "easeout" {
            return .CurveEaseOut
        } else if curveString == "easein" {
            return .CurveEaseIn
        } else if curveString == "linear" {
            return .CurveLinear
        }
        return .CurveEaseInOut
    }

    func animationSpecifierForKey(key: String) -> AnimationSpecifier {
        let duration = timeIntervalForKey(key.stringByAppendingString("Duration"))
        let delay = timeIntervalForKey(key.stringByAppendingString("Delay"))
        let curve = curveForKey(key.stringByAppendingString("Curve"))
        return AnimationSpecifier(delay: delay, duration: duration, curve: curve)
    }

    func textCaseForKey(key: String) -> TextCaseTransform {
        var s = stringForKey(key)
        if s == nil {
            return .None
        }
        if s!.caseInsensitiveCompare("lowercase") == NSComparisonResult.OrderedSame {
            return .Lower
        } else if s!.caseInsensitiveCompare("uppercase") == NSComparisonResult.OrderedSame {
            return .Upper
        }
        return .None
    }

    func animateWithAnimationSpecifierKey(animationSpecifierKey: String, animations: () -> Void, completion: ((Bool) -> Void)?) {
        let animationSpecifier = animationSpecifierForKey(animationSpecifierKey)
        UIView.animateWithDuration(animationSpecifier.duration,
            delay: animationSpecifier.delay,
            options: animationSpecifier.curve,
            animations: animations,
            completion: completion)
    }
}
