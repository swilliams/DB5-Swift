//
//  ThemeLoader.swift
//  DB5Demo
//

import UIKit



class ThemeLoader: NSObject {
    var defaultTheme: Theme?
    var themes: [Theme]

    init(themeFilename filename: String) {
        let themesFilePath = NSBundle.mainBundle().pathForResource(filename, ofType: "plist")
        let themesDictionary = NSDictionary(contentsOfFile: themesFilePath)
        themes = [Theme]()
        for oneKey in themesDictionary.allKeys {
            let key = oneKey as String
            let themeDictionary = themesDictionary[key] as NSDictionary
            let theme = Theme(fromDictionary: themeDictionary)
            if key.lowercaseString == "default" {
                defaultTheme = theme
            }
            theme.name = key
            themes.append(theme)
        }
        for oneTheme in themes {
            if oneTheme != defaultTheme {
                oneTheme.parentTheme = defaultTheme
            }
        }
    }

    func themeNamed(themeName: String) -> Theme? {
        for oneTheme in themes {
            if themeName == oneTheme.name {
                return oneTheme
            }
        }
        return nil
    }
}
