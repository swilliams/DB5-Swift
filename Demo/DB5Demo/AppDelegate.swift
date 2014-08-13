//
//  AppDelegate.swift
//  DB5Demo

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

