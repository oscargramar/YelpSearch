//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchResultsUpdating, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var businesses: [Business]!
    var filteredBusinesses: [Business]!
    var searchController: UISearchController!
    var isMoreDataLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        navigationController?.navigationBar
        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        navigationController?.navigationBar.translucent = false
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
        
        

        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.tableView.reloadData()
        })

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredBusinesses != nil {
            return filteredBusinesses.count
        }
        else{
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath:indexPath) as! BusinessCell
        cell.setBusinessNumber(indexPath.row)
        cell.business = filteredBusinesses[indexPath.row]
        
        
        
        
        return cell
    }
    
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
            if let  searchText = searchController.searchBar.text{
                filteredBusinesses = searchText.isEmpty ? businesses : businesses.filter(){
                    ($0 as Business).name?.rangeOfString(searchText,options: .CaseInsensitiveSearch) != nil
                }
                tableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(!isMoreDataLoading){
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = (scrollViewContentHeight - tableView.bounds.size.height)
                
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                Business.searchWithTerm("Restaurants", offset: 20, sort: .Distance, categories: nil, deals: nil) { (businesses: [Business]!, error: NSError!) -> Void in
                    self.isMoreDataLoading = false
                    self.businesses.appendContentsOf(businesses)
                    self.filteredBusinesses.appendContentsOf(businesses)
                    self.tableView.reloadData()
                }
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
