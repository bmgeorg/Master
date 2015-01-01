//
//  ReplaceSegue.swift
//  Master
//
//  Created by Brett George on 1/1/15.
//  Copyright (c) 2015 Brett George. All rights reserved.
//

import UIKit

class ReplaceSegue: UIStoryboardSegue {
    
    override func perform() {
        let source = self.sourceViewController as UIViewController
        let dest = self.destinationViewController as UIViewController
        assert(source.navigationController != nil, "Cannot perform ReplaceSegue outside a navigation controller.")
        let nav = source.navigationController! as UINavigationController
        
        var controllerStack = nav.viewControllers
        controllerStack.removeLast()
        controllerStack.append(dest)
        nav.setViewControllers(controllerStack, animated: true)
    }
}