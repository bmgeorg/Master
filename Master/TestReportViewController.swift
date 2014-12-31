//
//  TestReportViewController.swift
//  Master
//
//  Created by Brett George on 12/30/14.
//  Copyright (c) 2014 Brett George. All rights reserved.
//

import UIKit

class TestReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var youSolvedLabel: UILabel!
    @IBOutlet weak var resultsTable: UITableView!
    
    var report: TestReport!
    
    override func viewDidLoad() {
        youSolvedLabel.text = "You solved \(report.numSolved)/\(report.questions.count) questions!"
        resultsTable.estimatedRowHeight = 44
        resultsTable.rowHeight = UITableViewAutomaticDimension
        navigationItem.hidesBackButton = true
    }

    @IBAction func finish(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return report.questions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath) as ResultCell
        cell.indexLabel.text = String(indexPath.row)
        if report.questions[indexPath.row].solved {
            cell.solvedLabel.text = "solved"
            cell.solvedLabel.textColor = UIColor.greenColor()
        } else {
            cell.solvedLabel.text = "unsolved"
            cell.solvedLabel.textColor = UIColor.redColor()
        }
        return cell
    }
}
