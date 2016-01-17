//
//  ViewController.swift
//  CollectionViewLayoutExp
//
//  Created by Neil Wright on 1/15/16.
//  Copyright © 2016 Neil Wright. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: Computed properties
    var collectionViewController: HorizontalScrollerViewController? {
        return childViewControllers.last as? HorizontalScrollerViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    
    @IBAction func doAddItem(sender: AnyObject) {
        if let childViewController = collectionViewController {
            childViewController.incrementCount()
        }
    }
    
    @IBAction func doRemoveItem(sender: AnyObject) {
        if let childViewController = collectionViewController {
            childViewController.decrementCount()
        }
    }
}
