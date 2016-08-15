//
//  ProductTypeController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 01/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit
import Alamofire
import CryptoSwift

class ProductTypeController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    var searchActive:Bool = false
    
    var productProtocol: ProductTypeProtocol?
    var network:String!
    var networkJSON: String!
    var productType: [AnyObject]!
    var filteredProducts = [ProductModel]()
    var productModel = [ProductModel]()
    
    @IBOutlet weak var tblProductType: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let net = NSUserDefaults.standardUserDefaults().stringForKey(IdentifierName.productNetwork)
        self.network = net
        
        switch net! {
        case "SUN":
              networkJSON = ProductType.sunstr
              parseProduct(networkJSON)
            break
        case "GLOBE":
            networkJSON = ProductType.globestr
            parseProductGlobe(networkJSON)
            break
        default:
            networkJSON = ProductType.smartstr
            parseProduct(networkJSON)
            break
        }
        
        tblProductType.reloadData()
        
    }
    

    func parseProduct(strNetwork:String){
        
        let data:NSData = strNetwork.dataUsingEncoding(NSUTF8StringEncoding)!
        
        
        do{
             productType = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as! [AnyObject]
            
        }catch{
            print(Error)
        }
        
        for i in 0..<productType.count {
            let Description: String     = self.productType[i]["Description"] as! String
            let Amount: String          = self.productType[i]["Amount"] as! String
            let TransactionType         = self.productType[i]["TransactionType"] as! String
            let Keyword                 = self.productType[i]["Keyword"] as! String
            let Discount                = self.productType[i]["Discount"] as! String

            let prod = ProductModel(Keyword: Keyword, TransactionType: TransactionType, Amount: Amount, Description: Description, Discount: Discount)
            productModel.append(prod)
            
        }
        
    }

    
    //*********************************************************
    //  SEPARATE FUNCTION OF PARSING NETWORK OBJECT
    //  JUST BEACUSE HAS A DEFFIRENT KEY OF AND OBJECT COMPARE TO SMART AND SUN
    //*********************************************************
    
    func parseProductGlobe(strNetworkGlobe:String){
        let data:NSData = strNetworkGlobe.dataUsingEncoding(NSUTF8StringEncoding)!
        
        
        do{
            productType = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as! [AnyObject]
            
        }catch{
            print(Error)
        }
        
        for i in 0..<productType.count {
            let Description: String     = self.productType[i]["DenomType"] as! String
            let Amount: String          = self.productType[i]["MinimumAmount"] as! String
            let Keyword                 = self.productType[i]["ProductCode"] as! String
            let Discount                = self.productType[i]["Discount"] as! String
            
            let prod = ProductModel(Keyword: Keyword, TransactionType: " ", Amount: Amount, Description: Description, Discount: Discount)
            productModel.append(prod)
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if searchActive{
            return filteredProducts.count
        }
        return productModel.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductTypeCell") as! ProductTypeCell
        
        let newPro:[ProductModel]
        newPro = searchActive ? self.filteredProducts : self.productModel
        
        let p = newPro[indexPath.row]
        cell.lblProductType.text = p.Description
        cell.lblAmount.text = p.Amount
       
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let newPro:[ProductModel]
        newPro = searchActive ? self.filteredProducts : self.productModel
        
        let p = newPro[indexPath.row]
        let description = p.Description
        let amount = p.Amount
        let pCode = p.Keyword
        
        productProtocol?.setProduct(description, amount: amount, productCode: pCode)
        
        navigationController?.popViewControllerAnimated(true)
        
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
        
        filteredProducts = productModel.filter() {
            pro in return pro.Description.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        if filteredProducts.count == 0 {
            searchActive = false
        }else{
            searchActive = true
        }
        
        tblProductType.reloadData()

   }
    
   
}





