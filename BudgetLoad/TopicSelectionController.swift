//
//  TopicSelectionController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 28/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class TopicSelectionController: UIViewController,UITableViewDataSource,UITableViewDelegate  {

    @IBOutlet weak var tblTopicSelection: UITableView!
    
    var topicProtocol: FileTicketProtocol?
    
    
    let topics = ["Topping Up","Transactions","Stock Transfer","Notifications","Purchasing","Profiling","Deactivating","Suggestions","Others"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select Topic"
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tblTopicSelection.reloadData()
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        
        let data = topics[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.blueColor()
        cell.textLabel?.text = data
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        let data = topics[indexPath.item]
        topicProtocol!.setTicket(data)
        navigationController?.popViewControllerAnimated(true)
        
    }

}
