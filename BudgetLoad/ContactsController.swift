//
//  ContactsController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/21/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit
import Contacts

class ContactsController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    
    
   
    @IBOutlet weak var tblContact: UITableView!
    @IBOutlet weak var searchContact: UISearchBar!
    
    var contacts = [CNContact]()
    var filteredContact = [CNContact]()
    var searchActive : Bool = false
    let pref = NSUserDefaults.standardUserDefaults().stringForKey("controller")
    
    var stockTransfer:StockTransferProtocol? 
    var topupProtocol:TopUpProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getContacts()
        searchContact.delegate = self
        
        if pref == "stocktransfer" || pref == "topup"{
            self.navigationItem.leftBarButtonItem = nil
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func openDrawer(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.centerContainer?.toggleDrawerSide(MMDrawerSide.Left
            , animated: true, completion: nil)
    }

    
    @IBAction func btnInviteFriendsImage(sender: AnyObject) {
        
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5 {
            let modalViewController = storyboard?.instantiateViewControllerWithIdentifier("InviteFriendsModalController") as!InviteFriendsModalController
            modalViewController.modalPresentationStyle = .OverCurrentContext
            presentViewController(modalViewController, animated: true, completion: nil)
        }
        else{
        
            let modalViewController = storyboard?.instantiateViewControllerWithIdentifier("InviteFriendsModaliPhone6UpController") as!InviteFriendsModaliPhone6UpController
            modalViewController.modalPresentationStyle = .OverCurrentContext
            presentViewController(modalViewController, animated: true, completion: nil)
        }
       
        
    }
    @IBAction func btnInvite(sender: AnyObject) {
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5 {
            let modalViewController = storyboard?.instantiateViewControllerWithIdentifier("InviteFriendsModalController") as!InviteFriendsModalController
            modalViewController.modalPresentationStyle = .OverCurrentContext
            presentViewController(modalViewController, animated: true, completion: nil)
        }
        else{
            
            let modalViewController = storyboard?.instantiateViewControllerWithIdentifier("InviteFriendsModaliPhone6UpController") as!InviteFriendsModaliPhone6UpController
            modalViewController.modalPresentationStyle = .OverCurrentContext
            presentViewController(modalViewController, animated: true, completion: nil)
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive{
            return filteredContact.count
        }
        
        
        return contacts.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactsTableCell") as! ContactsTableCell
        
        let contactData:CNContact
        contactData = searchActive ? self.filteredContact[indexPath.row] : self.contacts[indexPath.row]
        
 
        
        let formatter = CNContactFormatter()
        let number = (contactData.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String
        
        let text =  " \(formatter.stringFromContact(contactData)!)\n\(number)"
        let subString = formatter.stringFromContact(contactData)
        let index = subString!.startIndex.advancedBy(0)
        let firstletter = subString![index]
        cell.lblName.text = text
        cell.lblFirstLetter.text = String(firstletter)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contactData:CNContact
        
        contactData = searchActive ? self.filteredContact[indexPath.row] : self.contacts[indexPath.row]
        
 
       
      
        let number = (contactData.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String
        
        
        
        if pref == "topup" {
            let firsFourLetters = number.startIndex.advancedBy(0) ..< number.startIndex.advancedBy(4)
            let str = number.substringWithRange(firsFourLetters)
            let brand = SimIdentification().parseJson(str)
            
            if brand.isEmpty{
                print("invalid number")
                let alert = UIAlertController(title: "Note:", message: "Invalid mobile number", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }else {
                topupProtocol?.setContact(number, brand: brand)
                navigationController?.popViewControllerAnimated(true)
            }
            
        }
        
        if pref == "stocktransfer"{
            let firsFourLetters = number.startIndex.advancedBy(0) ..< number.startIndex.advancedBy(4)
            let str = number.substringWithRange(firsFourLetters)
            let brand = SimIdentification().parseJson(str)
            
            if brand.isEmpty{
                let alert = UIAlertController(title: "Note:", message: "Invalid mobile number", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }else {
                
                stockTransfer?.setRecipient(number)
                navigationController?.popViewControllerAnimated(true)
            }
            
        }
    }
    
    
    func getContacts(){
        let store = CNContactStore()
        if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined {
            store.requestAccessForEntityType(.Contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
                if authorized {
                    self.retrieveContactsWithStore(store)
                }
            })
        } else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Authorized {
            self.retrieveContactsWithStore(store)
        }
    }
    
    func retrieveContactsWithStore(store: CNContactStore) {
        
        var allContainers: [CNContainer] = []
        
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactPhoneNumbersKey]
        do {
            allContainers = try store.containersMatchingPredicate(nil)
            
            for container in allContainers {
                let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
                do{
                    let containerResults = try store.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: keysToFetch)
                    self.contacts = containerResults
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tblContact.reloadData()
                    })
                }catch{
                    
                }
            }
        } catch {
            print(error)
        }
    }

    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredContact = contacts.filter{ con in
            return con.givenName.lowercaseString.containsString(searchText.lowercaseString) || con.familyName.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        if filteredContact.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        
        self.tblContact.reloadData()
    }

    
}
