//
//  TopicListViewController.swift
//  Master
//
//  Created by Brett George on 12/26/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit
import Realm

class TopicListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var topics: RLMResults!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chooseTopicsButton: UIButton!
    
    override func viewDidLoad() {
        QuestionBank.populateQuestions()
        topics = Topic.allObjects().sortedResultsUsingProperty("order", ascending: true)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        updateChooseTopicsButton()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(topics.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as TopicCell
        let topic = topics[UInt(indexPath.row)] as Topic
        cell.topicLabel.text = topic.topic
        cell.completedLabel.text = String(topic.numSolved)
        cell.outOfLabel.text = String(topic.questions.count)
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as TopicCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        updateChooseTopicsButton()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as TopicCell
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        updateChooseTopicsButton()
    }
    
    internal func updateChooseTopicsButton() {
        var text = ""
        if let chosenIndexPaths = tableView.indexPathsForSelectedRows() {
            text = "Choose \((chosenIndexPaths as [NSIndexPath]).count) Topic"
        } else {
            text = "Choose Random Topics"
        }
        UIView.performWithoutAnimation({
            self.chooseTopicsButton.setTitle(text, forState: .Normal)
            self.chooseTopicsButton.setTitle(text, forState: .Disabled)
            self.chooseTopicsButton.setTitle(text, forState: .Selected)
            self.chooseTopicsButton.setTitle(text, forState: .Highlighted)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "startTest") {
            var chosenTopics = [Topic]()
            let indexPaths = self.tableView.indexPathsForSelectedRows()
            if let paths = indexPaths {
                for object in paths {
                    let path = object as NSIndexPath
                    chosenTopics.append(topics[UInt(path.row)] as Topic)
                }
            } else {
                //choose all topics
                for object in topics {
                    let topic = object as Topic
                    chosenTopics.append(topic)
                }
            }
            let test = Test(topics: chosenTopics)
            let dest = segue.destinationViewController as QuestionViewController
            dest.test = test
            dest.question = test.nextQuestion()
        }
    }
}