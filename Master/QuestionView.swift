//
//  QuestionView.swift
//  Master
//
//  Created by Brett George on 1/1/15.
//  Copyright (c) 2015 Brett George. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    var view: UIView!
    
    @IBOutlet weak var topicLabel: UILabel!

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
        let view = nib.instantiateWithOwner(nil, options: nil)[0] as UIView
        
        return view
    }
}
