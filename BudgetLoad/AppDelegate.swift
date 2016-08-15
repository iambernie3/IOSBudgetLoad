//
//  AppDelegate.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 3/28/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit
import Contacts
import Foundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var centerContainer : MMDrawerController?
    var contactStore = CNContactStore()
    var sharedInstance = DatabaseManager()
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let systemVersion = UIDevice.currentDevice().systemVersion
        
        
        
        
        print("ios version : \(systemVersion)")
        
        //database for transaction
        sharedInstance.createtable()
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("IsUserLoggedIn")
        
        if(isUserLoggedIn)
        {
            
            
            // var rootViewController = self.window?.rootViewController
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let centerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TopUpController") as! TopUpController
            let leftsideController = mainStoryboard.instantiateViewControllerWithIdentifier("LeftController") as! LeftController
            
            
            let leftSideNav = UINavigationController(rootViewController:leftsideController)
            let centerNav = UINavigationController(rootViewController: centerViewController)
            centerContainer = MMDrawerController(centerViewController: centerNav, leftDrawerViewController: leftSideNav)
            centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView;
            centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView;
            
            
            window?.rootViewController = centerContainer
            window?.makeKeyAndVisible()
            
        }
        
        self.generateIMEI()
        self.session()
        
        
        return true
    }
    
    func generateIMEI(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let defaults = NSUserDefaults.standardUserDefaults()
        let imei = defaults.objectForKey("ApplicationIdentifier")
        
        print("MyIMEI \(imei)")
        
        if userDefaults.objectForKey("ApplicationIdentifier") == nil {
            let UUID = NSUUID().UUIDString
            userDefaults.setObject(UUID, forKey: "ApplicationIdentifier")
            userDefaults.synchronize()
            print(UUID)
        }
    }
    
    func session(){
        //log if session is create
        if Reachability.isConnectedToNetwork(){
            
            HttpRequest.createSession()
            
        }
        
    }
    
    func requestForAccess(completionHandler: (accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Authorized:
            completionHandler(accessGranted: true)
            
        case .Denied, .NotDetermined:
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(accessGranted: access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.Denied {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            self.showMessage(message)
                        })
                    }
                }
            })
            
        default:
            completionHandler(accessGranted: false)
        }
    }
    
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    
    func showMessage(message: String) {
        let alertController = UIAlertController(title: "Birthdays", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
        }
        
        alertController.addAction(dismissAction)
        
        let pushedViewControllers = (self.window?.rootViewController as! UINavigationController).viewControllers
        let presentedViewController = pushedViewControllers[pushedViewControllers.count - 1]
        
        presentedViewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

