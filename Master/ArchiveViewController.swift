//
//  ArchiveViewController.swift
//  Master
//
//  Created by Brett George on 12/23/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit
import Realm

class ArchiveViewController: UITableViewController {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    var questions: RLMResults!
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(questions.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as ArchiveQuestionCell
        var question = questions.objectAtIndex(UInt(indexPath.row)) as Question
        cell.index.text = "\(indexPath.row+1)."
        cell.questionTitle.text = question.title
        if question.solved {
            cell.checkmarkIndicator.hidden = false;
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showQuestion") {
            let dest = segue.destinationViewController as QuestionViewController
            if let index = self.tableView.indexPathForSelectedRow() {
                dest.question = questions.objectAtIndex(UInt(index.row)) as Question
            }
        } else {
            assert(false, "Unrecognized segue identifier from ArchiveViewController")
        }
    }
}
