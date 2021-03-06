//
//  AppDelegate.swift
//  tripedia
//
//  Created by 窪田文也 on 2016/12/22.
//  Copyright © 2016年 窪田文也. All rights reserved.
//

import UIKit
import FontAwesome_swift
import MTMigration
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // ここで一度読んでおかないとIB上で置いてるフォントが見えん。
    let font = UIFont.fontAwesome(ofSize: 25)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let realm = try! Realm()
        // Version 1.0.0 DBPedia上にないプロパティをRealmに放り込む。
        MTMigration.migrate(toVersion: "1.0.0") {
            guard let path = Bundle.main.path(forResource: "properties", ofType: "txt") else {
                return
            }
            guard let content = try? String.init(contentsOf: .init(fileURLWithPath: path)) else {
                return
            }
            try! realm.write {
                for row in content.components(separatedBy: "\n") {
                    let uri = URI(value: ["uri": row])
                    realm.add(uri)
                    let property = PresetProperty(value:["uri": uri])
                    realm.add(property)
                }
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

