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
    var createdTest: Test?
    var firstQuestion: Question?
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
        cell.topicLabel.text = topic.name
        cell.percentLabel.text = String(format: "%.1f%%", Double(topic.numSolved)/Double(topic.questions.count))
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as TopicCell
        cell.checkmarkView.image = UIImage(named: "CheckmarkBorder")
        cell.topicLabel.highlighted = false
        updateChooseTopicsButton()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as TopicCell
        cell.checkmarkView.image = UIImage(named: "Checkmark")
        cell.topicLabel.highlighted = true
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
    
    @IBAction func startTest() {
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
        createdTest = Test(topics: chosenTopics)
        firstQuestion = createdTest!.nextQuestion()
        performSegueWithIdentifier("showFirstTextQuestion", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as QuestionViewController
        dest.test = createdTest!
        dest.question = firstQuestion!
    }
}