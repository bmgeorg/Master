//
//  TopicListViewController.swift
//  Master
//
//  Created by Brett George on 12/26/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit
import Realm

class TopicListViewController: UITableViewController {
    
    var topics: RLMResults!
    
    override func viewDidLoad() {
        QuestionBank.populateQuestions()
        topics = Topic.allObjects().sortedResultsUsingProperty("order", ascending: true)
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(topics.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as TopicCell
        let topic = topics[UInt(indexPath.row)] as Topic
        cell.topicLabel.text = topic.topic
        cell.completedLabel.text = String(topic.numSolved)
        cell.outOfLabel.text = String(topic.questions.count)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "") {
        } else {
            assert(false, "Unrecognized segue identifier from ArchiveViewController")
        }
    }
}