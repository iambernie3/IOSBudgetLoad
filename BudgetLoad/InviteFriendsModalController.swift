//
//  InviteFriendsModalController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 10/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit
import MessageUI
import Social

class InviteFriendsModalController: UIViewController,MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var ivMessenger: UIImageView!
    @IBOutlet weak var ivViber: UIImageView!
    @IBOutlet weak var ivWhatsApp: UIImageView!
    @IBOutlet weak var ivContacts: UIImageView!
    let msg:String = "Check out BudgetLoad for your Quick, Simple and Secure airtime reloadding.- www.budgetload.com \n\nFor google play downloads:https://play.google.com/store/apps/details?id=com.epayvenue.budgetload"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        let sendToContact = UITapGestureRecognizer(target: self, action: #selector(self.sendToContact(_:)) )
        ivContacts.addGestureRecognizer(sendToContact)
        
        let sendToFB = UITapGestureRecognizer(target: self, action: #selector(self.sendToFacebook(_:)) )
        ivMessenger.addGestureRecognizer(sendToFB)
        
        let sendToWhatsApp = UITapGestureRecognizer(target: self, action: #selector(self.sendToWhatsApp(_:)) )
        ivWhatsApp.addGestureRecognizer(sendToWhatsApp)
        
        let sendToViber = UITapGestureRecognizer(target: self, action: #selector(self.sendToViber(_:)) )
        ivViber.addGestureRecognizer(sendToViber)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.rawValue:
            print("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.rawValue:
            print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }
    func sendToContact(sender: UITapGestureRecognizer){
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let messageVC = MFMessageComposeViewController()
        //messageVC.recipients = ["Enter tel-nr"]
        messageVC.body = msg;
        messageVC.messageComposeDelegate = self;
        
        self.presentViewController(messageVC, animated: false, completion: nil)
        
        
        
    }
    
    
    func sendToFacebook(sender: UITapGestureRecognizer){
        //        let controller: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        //        controller.setInitialText(msg)
        //        self.presentViewController(controller, animated: true, completion: { _ in })
        
        
        let fbURL: NSURL = NSURL(string: "fb-messenger-api://")!
        if UIApplication.sharedApplication().canOpenURL(fbURL) {
            UIApplication.sharedApplication().openURL(fbURL)
        }
        
        //        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
        //        content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
        
        
        
        
        //let image: UIImage = UIImage(named: "invite")!
        //FBSDKMessengerSharer.shareImage(image, withOptions: nil)
    }
    
    
    func sendToWhatsApp(sender: UITapGestureRecognizer){
        //  "whatsapp://send?text=\("String to post here")"
        print("whatsapp")
        if let whatsappURL: NSURL = NSURL(string: "whatsapp://send?text=\(msg)"){
            if UIApplication.sharedApplication().canOpenURL(whatsappURL) {
                UIApplication.sharedApplication().openURL(whatsappURL)
                
            }
        }else{
            print("")
        }
    }
    
    func sendToViber(sender: UITapGestureRecognizer){
        
        print("viber")
        
        if let viberURL: NSURL = NSURL(string: "viber://forward?text=\(msg)"){
            if UIApplication.sharedApplication().canOpenURL(viberURL) {
                UIApplication.sharedApplication().openURL(viberURL)
                
            }
        }
    }


}
