//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by Andrea Mazzini on 31/10/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
     
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        let font = UIFont(name: "Futura", size: 22)
        if let font = font {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        }

        UINavigationBar.appearance().barTintColor = UIColor(red: 0.12, green: 0.55, blue: 0.84, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        return true
    }

}

