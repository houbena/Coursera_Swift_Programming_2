//
//  TableViewController.swift
//  imageFilter
//
//  Created by HOU YADDA on 12.12.15.
//  Copyright © 2015 houyadda. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var myTableView: UITableView!

    let filters = [
        "maxCol",
        "transX",
        "contrast",
        "brightness",
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(filters[indexPath.row])
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = filters[indexPath.row]
        
        return cell
    }
}
