//
//  QuestionView.swift
//  Master
//
//  Created by Brett George on 1/1/15.
//  Copyright (c) 2015 Brett George. All rights reserved.
//

import UIKit

@IBDesignable class QuestionView: UIView {
    var view: UIView!
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var explanationView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var explanationTextView: UITextView!
    @IBOutlet weak var explanationViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var explanationMarginConstraint: NSLayoutConstraint!
    
    let UNBOUNDED_HEIGHT: CGFloat = 100000000
    
    internal func setup() {
        view = loadViewFromNib()
        
        view.frame = self.bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        addSubview(view)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    internal func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "QuestionView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        
        return view
    }
    
    func showExplanation(layoutSuperviewIfNeeded: ()->()) {
        layoutSuperviewIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.explanationViewHeightConstraint.constant = self.UNBOUNDED_HEIGHT
            self.explanationMarginConstraint.constant = 8
            self.explanationView.alpha = 1
            layoutSuperviewIfNeeded()
            }, completion: nil)
    }
}
