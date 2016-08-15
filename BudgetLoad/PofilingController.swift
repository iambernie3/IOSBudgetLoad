//
//  PofilingController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/19/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class ProfilingController :UIViewController,UITextFieldDelegate {
    
    var arrayOfTextFields:[UITextField] = []
    
    var centerContainer : MMDrawerController?
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtMiddleName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    var logButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false;
        ScrollView.contentInset = UIEdgeInsetsZero;
        ScrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
        ScrollView.contentOffset = CGPointMake(0.0, 0.0);
        
        navigationItem.hidesBackButton = true
        //navigationItem.rightBarButtonItem?.title = "Skip"
    
        //var homeButton : UIBarButtonItem = UIBarButtonItem(title: "LeftButtonTitle", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        
        logButton = UIBarButtonItem(title: "Skip", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ProfilingController.implementAction))
        
        
        self.arrayOfTextFields.append(txtFirstName)
        self.arrayOfTextFields.append(txtMiddleName)
        self.arrayOfTextFields.append(txtLastName)
        self.arrayOfTextFields.append(txtGender)
        
       // self.navigationItem.leftBarButtonItem = homeButton
        self.navigationItem.rightBarButtonItem = logButton

    
        // Do any additional setup after loading the view.
        
        
    }
    
    func findEmptyField() -> Bool? {
       var myreturn: Bool! = false
        for field in arrayOfTextFields {
            if field.text!.isEmpty {
                myreturn = true
                break
            }
        }
        return myreturn
    }
    
    func IsSupplied(){
        
       var response: Bool! = false
        
        response = findEmptyField()
        print(response)

        if (response == true) {
            logButton.title = "Skip"
            // focus emptyField or give a message
        } else {
            logButton.title = "Submit"
            // all fields filled, ok to continue
        }
    }
    
    func implementAction(){
    
        print(logButton.title)
        
        if (logButton.title == "Skip"){
           // performSegueWithIdentifier("main", sender: self)
            
          //  [self, MainController.self:MainController animated:YES completion:nil];
        
   
            
        }
        else{
  //           print("here")
            //performSegueWithIdentifier("main", sender: self)
        }
        
        
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc : MainController = mainStoryboard.instantiateViewControllerWithIdentifier("MainController") as! MainController
//        let navigationController = UINavigationController(rootViewController: vc)
//        self.presentViewController(navigationController, animated: true, completion: nil)
        
        let appDelegte:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
       // var rootViewController = appDelegte.window?.rootViewController
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let centerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationController
        let leftsideController = mainStoryboard.instantiateViewControllerWithIdentifier("LeftController") as! LeftController
        //let rightsidecontroller = mainStoryboard.instantiateViewControllerWithIdentifier("RightController") as! RightController
        
        let leftSideNav = UINavigationController(rootViewController:leftsideController)
        let centerNav = UINavigationController(rootViewController: centerViewController)
        //let rightSideNav = UINavigationController(rootViewController: rightsidecontroller)
        
        
        centerContainer = MMDrawerController(centerViewController: centerNav, leftDrawerViewController: leftSideNav)//,rightDrawerViewController: rightSideNav
        centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView;
        centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView;
        
        
        
        
        
        appDelegte.centerContainer = centerContainer
        
        appDelegte.window?.rootViewController = appDelegte.centerContainer
        appDelegte.window?.makeKeyAndVisible()
        
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //print("hee")
        if(textField == txtGender){
        ScrollView.setContentOffset(CGPointMake(0, 70), animated: true)
        }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
         IsSupplied()
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPointMake(0,0), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}