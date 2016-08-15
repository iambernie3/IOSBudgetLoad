//
//  NotificationController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/21/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class NotificationController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let flag:Bool = true
    
    let arr1 = ["REMITBOX","SYSTEM ADMIN"]
    let arr2 = ["budget load advisory budget load advisory budget load advisory","Budgetload advisorybudget load advisorybudget load advisory"]
    let arr3 = ["August 2, 2016 11:03 PM","August 2, 2016 11:03 PM"]
    
    @IBOutlet weak var tblNotification: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if flag {
            setDefaultView()
            tblNotification.hidden = true
        }
        tblNotification.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arr1.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NotificationCell") as! NotificationCell
        
        let index = arr1[indexPath.row].startIndex.advancedBy(0)
        let firstLetter = arr1[indexPath.row][index]
        
        
        
        cell.lblHeaderContent.text = arr1[indexPath.row]
        cell.lblContent.text       = arr2[indexPath.row]
        cell.lblDate.text          = arr3[indexPath.row]
        cell.lblLogo.text          = String(firstLetter)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let header  = arr1[indexPath.row]
        let content = arr2[indexPath.row]
        
        
        let index = header.startIndex.advancedBy(0)
        let firstLetter = header[index]
        
        let backItem = UIBarButtonItem()
        backItem.title = "Notification"
        navigationItem.backBarButtonItem = backItem
        let vc = storyboard?.instantiateViewControllerWithIdentifier("NotificationDetailsController") as! NotificationDetailsController
        
        vc.header = header
        vc.logo     = String(firstLetter)
        vc.content  = content
        
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func OpenDrawer(sender: AnyObject) {
        
        let appDeletegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDeletegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    func setDefaultView(){
        
        
        let image = UIImageView(frame: CGRectMake(0, 0, screenSize.width/2, screenSize.width/2))
        image.image = UIImage(named: "transferimg")
        
        let label = UILabel(frame: CGRectMake(0, 100, screenSize.width, 70))
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = label.font.fontWithSize(22)
        label.text = "You do not have any \nnotifications."
        
        self.view.addSubview(image)
        self.view.addSubview(label)
        
        
        //pin the label 20 points from the right edge of the super view
        let labelContraints = NSLayoutConstraint(item: label, attribute:
            .LeadingMargin, relatedBy: .Equal, toItem: view,
                            attribute: .LeadingMargin, multiplier: 1.0,
                            constant: 20)
        
        //negative because we want to pin -20 points from the end of the superview.
        //ex. if with of super view is 300, 300-20 = 280 position
        let label2Contraints = NSLayoutConstraint(item: label, attribute:
            .TrailingMargin, relatedBy: .Equal, toItem: view,
                             attribute: .TrailingMargin, multiplier: 1.0, constant: -20)
        
        let imageH = NSLayoutConstraint(item: image, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: screenSize.height/2)
        
        let imageW = NSLayoutConstraint(item: image, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: screenSize.width/2)
        
        let pinTop = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal,
                                        toItem: view, attribute: .Top, multiplier: 1.0, constant: screenSize.height/1.3)
        
        let imagepinTop = NSLayoutConstraint(item: image, attribute: .Top, relatedBy: .Equal,
                                             toItem: view, attribute: .Top, multiplier: 1.0, constant: screenSize.width/3)
        
        
        let xImageConstraint = NSLayoutConstraint(item: image, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activateConstraints([xImageConstraint,imagepinTop,imageH,imageW,labelContraints, label2Contraints,pinTop])
    }
    
    
}
