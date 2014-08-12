//
//  AppDelegate.swift
//  DB5Demo
//
//  Created by Scott Williams on 8/12/14.
//  Copyright (c) 2014 Scott Williams. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var viewController: ViewController?
    var themeLoader: ThemeLoader?
    var theme: Theme?


    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {

        themeLoader = ThemeLoader(themeFilename: "Vesper-DB5")
        theme = themeLoader?.defaultTheme
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        viewController = ViewController(nibName: "ViewController", bundle: nil, theme: theme)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}

