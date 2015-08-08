//
//  SettingsViewController.swift
//  tips
//
//  Created by Angelo Wong on 8/2/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipDefaultControl: UISegmentedControl!
    @IBOutlet weak var badTipField: UITextField!
    @IBOutlet weak var okTipField: UITextField!
    @IBOutlet weak var goodTipField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChangedBad(sender: AnyObject) {
        
        if badTipField.text.isEmpty {
            tipDefaultControl.setTitle("0%", forSegmentAtIndex: 0)
        } else {
            tipDefaultControl.setTitle(badTipField.text + "%", forSegmentAtIndex: 0)
        }
    }
    
    @IBAction func onEditingChangedMid(sender: AnyObject) {
        if okTipField.text.isEmpty {
            tipDefaultControl.setTitle("0%", forSegmentAtIndex: 1)
        } else {
            tipDefaultControl.setTitle(okTipField.text + "%", forSegmentAtIndex: 1)
        }
    }
    
    @IBAction func onEditingChangedGood(sender: AnyObject) {
        if goodTipField.text.isEmpty {
            tipDefaultControl.setTitle("0%", forSegmentAtIndex: 2)
        } else {
            tipDefaultControl.setTitle(goodTipField.text + "%", forSegmentAtIndex: 2)
        }
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //load previous values, if any
        var defaults = NSUserDefaults.standardUserDefaults()

        if let tipDefault = defaults.integerForKey("default_tip") as Int? {
            tipDefaultControl.selectedSegmentIndex = tipDefault
        } else {
            tipDefaultControl.selectedSegmentIndex = 0
        }
        
        if var lowTip = defaults.stringForKey("low_tip") as String? {
            tipDefaultControl.setTitle(lowTip, forSegmentAtIndex: 0)
            lowTip.removeAtIndex(lowTip.endIndex.predecessor())
            badTipField.text = lowTip
        } else {
            tipDefaultControl.setTitle("18%", forSegmentAtIndex: 0)
        }
        if var midTip = defaults.stringForKey("mid_tip") as String? {
            tipDefaultControl.setTitle(midTip, forSegmentAtIndex: 1)
            midTip.removeAtIndex(midTip.endIndex.predecessor())
            okTipField.text = midTip
        } else {
            tipDefaultControl.setTitle("20%", forSegmentAtIndex: 1)
        }
        if var highTip = defaults.stringForKey("high_tip") as String? {
            tipDefaultControl.setTitle(highTip, forSegmentAtIndex: 2)
            highTip.removeAtIndex(highTip.endIndex.predecessor())
            goodTipField.text = highTip
        } else {
            tipDefaultControl.setTitle("22%", forSegmentAtIndex: 2)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.badTipField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //store of setting values
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipDefaultControl.selectedSegmentIndex, forKey: "default_tip")
        defaults.setObject(tipDefaultControl.titleForSegmentAtIndex(0), forKey: "low_tip")
        defaults.setObject(tipDefaultControl.titleForSegmentAtIndex(1), forKey: "mid_tip")
        defaults.setObject(tipDefaultControl.titleForSegmentAtIndex(2), forKey: "high_tip")
        defaults.synchronize()
        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
