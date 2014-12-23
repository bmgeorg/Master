//
//  ArchiveViewController.swift
//  Master
//
//  Created by Brett George on 12/23/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

class ArchiveViewController: UITableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as ArchiveQuestionCell
        cell.index.text = String(indexPath.row)
        cell.questionTitle.text = "What is a virtual method?"
        return cell
    }
}
