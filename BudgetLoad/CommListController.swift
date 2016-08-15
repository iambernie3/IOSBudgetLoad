//
//  CommListController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 3/29/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

protocol myProtocol{
    func didSelectRow(communityID: String,communityName: String)
}

class CommListController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
  
    
//    let people = [
//        ("Bucky Robers","New York"),
//        ("Lisa Tucker","Alabama"),
//        ("Emma Hotpocker","Texas")
//    ]
//    
//    
//    let videos = [
//        ("Android App Development","74 videos"),
//        ("C++ for Beginners","87 vidoes"),
//        ("Java","142 vidoes"),
//        ("Web Design","68 vidoes")
    
//    var commList: NSArray = []
//    var selectedLabel:String?
    
    
    var TableData:Array< datastruct > = Array < datastruct >()
    
    enum ErrorHandler:ErrorType
    {
        case ErrorFetchingResults
    }
    
    
    struct datastruct
    {
//        var imageurl:String?
//        var description:String?
//        var image:UIImage? = nil
//        

        var networkid:String?
        var networkname:String?
        
        init(add: NSDictionary)
        {
            networkid = add["NetworkID"] as? String
            networkname = add["NetworkName"] as? String
        }
    }
    
    var UniqueID: String!
    
    
    @IBOutlet weak var tableview: UITableView!
    let communities : NSArray = []
    var myprotocol : myProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("here")
//        print(commList)
        
        // Do any additional setup after loading the view.
        
        tableview.dataSource = self
        tableview.delegate = self
        
         UniqueID = GUIDString() as String
 
        fetchCommunity()
        

        
        
    }


    
    
//     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//    }
    
    //*************************
    //Protocol for UITableViewDataSource
    //*************************

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        
        let data = TableData[indexPath.row]
        cell.textLabel?.text = data.networkname
        
//        if (data.image == nil)
//        {
//            cell.imageView?.image = UIImage(named:"image.jpg")
//            load_image(image_base_url + data.imageurl!, imageview: cell.imageView!, index: indexPath.row)
//        }
//        else
//        {
//            cell.imageView?.image = TableData[indexPath.row].image
//        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        let indexPath = tableView.indexPathForSelectedRow;
        //let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        let data = TableData[indexPath!.row]
        print(data.networkid)
        print(data.networkname)
        
        myprotocol?.didSelectRow( data.networkid!,communityName: data.networkname!)
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    //*************************
    //Protocol for UITableViewDelegate
    //*************************
    
    
    
    
    //*************************
    //FUNCTIONS
    //*************************
    func fetchCommunity()
    {
        
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        //let postEndpoint: String = "http://dev2-misc.budgetload.com:8282/"
        var urlWithParams = UrlVariable.OTHERSURL + "id=d6b27ee9de22e000700f0163e662ecba1d201c99"
        urlWithParams = urlWithParams + "&cmd=COMMUNITY"
        urlWithParams = urlWithParams + "&IMEI=\(UniqueID)"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlWithParams)!
        
        
        print(url)
        
//        let url:NSURL = NSURL(string: url)!
//        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
//            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
//            
//            let results = jsonDictionary[1] as! NSDictionary
//            let communities = results["Community"] as! NSArray
//            
//        } catch let error as NSError {
//            print("Error:\n \(error)")
//            return
//        }
        
            
//            var communities :NSArray = []
//            do {
//                //if let ipString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
//                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
//                    
//                    
//                     let results = jsonDictionary[1] as! NSDictionary
//                      communities = results["Community"] as! NSArray
//                    
//                    print(communities)
//                    
//                    //communityList = (jsonDictionary.valueForKey("Community") as? NSArray)!
//                    
//                    //print(communityList)
//                   
//                //}
//            } catch {
//                print("bad things happened")
//            }
            
            //do some task and update some ui
            dispatch_async(dispatch_get_main_queue(), {
                self.extract_json(data!)
                return
            })
            
        }
        
        task.resume()
        
    }
    
    func extract_json(jsonData:NSData)
    {
        let json: AnyObject?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        } catch {
            json = nil
            return
        }
        
    
        
                  //  let results = jsonDictionary[1] as? NSDictionary
                  //  let communities = results["Community"] as! NSArray
        
        
        if let list = json as? NSArray
        {

           let results = list[1] as! NSDictionary
           let communities = results["Community"] as! NSArray
          
            
            //for (var i = 0; i < communities.count ; i++ )  //drepricated in swift 3
            
            for i in 0..<communities.count
            {
               
                
                if let data_block = communities[i] as? NSDictionary
                {
                   TableData.append(datastruct(add: data_block))
                }
            }
            
            do
            {
                try read()
            }
            catch
            {
            }
            
            do_table_refresh()
            
        }
        
        
    }
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableview.reloadData()
            return
        })
    }
    
    func read() throws
    {
        
//        do
//        {
//            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            let managedContext = appDelegate.managedObjectContext!
//            let fetchRequest = NSFetchRequest(entityName: "Images")
//            
//            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest)
//            
//            for (var i=0; i < fetchedResults.count; i++)
//            {
//                let single_result = fetchedResults[i]
//                let index = single_result.valueForKey("index") as! NSInteger
//                let img: NSData? = single_result.valueForKey("image") as? NSData
//                
//                TableData[index].image = UIImage(data: img!)
//                
//            }
            
//        }
//        catch
//        {
//            print("error")
//            throw ErrorHandler.ErrorFetchingResults
        }
        
    }
    
//    func save(id:Int,image:UIImage)
//    {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedContext = appDelegate.managedObjectContext!
//        
//        let entity = NSEntityDescription.entityForName("Images",
//            inManagedObjectContext: managedContext)
//        let options = NSManagedObject(entity: entity!,
//            insertIntoManagedObjectContext:managedContext)
//        
//        let newImageData = UIImageJPEGRepresentation(image,1)
//        
//        options.setValue(id, forKey: "index")
//        options.setValue(newImageData, forKey: "image")
//        
//        do {
//            try managedContext.save()
//        } catch
//        {
//            print("error")
//        }
//        
//    }
    
    func GUIDString() -> NSString {
        let newUniqueID = CFUUIDCreate(kCFAllocatorDefault)
        let newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
        let guid = newUniqueIDString as NSString
        
        return guid.lowercaseString
    }
    
    
    
    //Methods for UITableViewDataSource
    
    //return how many sections
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 2
//    }
    
    //contents of each cell
//    func tableView(tableView: UITableView, 2 indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        if indexPath.section == 0{
//            var (personName, personLocation) = people[indexPath.row]
//            cell.textLabel?.text = personName
//        }
//        else{
//            var (videoTitle, videoDescription) = videos[indexPath.row]
//            cell.textLabel?.text = videoTitle
//            
//        }
//        
//        return cell
//        
//    }
    
    //Give each table section a Title
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "People"
//        }
//        else {
//            return "Vidoes"
//        }
//    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
//        var busRoutes: [Route] = routeService.retrieve()
//        
//        busDataDelegate?.didSelectRow(indexPath, data: busRoutes[indexPath.row])
//        println("You selected cell #\(indexPath.row)!")
        
//        let indexPath = tableView.indexPathForSelectedRow;
//        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
//        
//        selectedLabel = currentCell.textLabel!.text as String!
//        
//        print(selectedLabel)
//        
//        myprotocol?.didSelectRow(selectedLabel!)
//        navigationController?.popViewControllerAnimated(true)
//        
//    }

    
    
    //return how many rows
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        if section == 0 {
//            return people.count
//        }
//        else {
//            return videos.count
//        }
//        
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


