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
  
  private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    UIApplication.shared.setStatusBarHidden(false, with: .slide)
    UIApplication.shared.statusBarStyle = .lightContent
    
    let font = UIFont(name: "Futura", size: 22)
    if let font = font {
      UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    UINavigationBar.appearance().barTintColor = UIColor(red: 0.12, green: 0.55, blue: 0.84, alpha: 1)
    UINavigationBar.appearance().tintColor = .white
    
    return true
  }
  
}

