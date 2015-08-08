//
//  ViewController.swift
//  tips
//
//  Created by Angelo Wong on 8/1/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var plusSign: UILabel!
    @IBOutlet weak var equationBar: UIView!
    @IBOutlet weak var msgField: UILabel!
    var lowTip: Double = 0.0
    var midTip: Double = 0.0
    var hiTip: Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        if billField.text.isEmpty || billField.text == "$$$" {
            billField.text = "$"
        }
        //TODO load setting tip percentages here and divide by 100
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        //TODO make this load setting tip percentages.
        var tipPercentages = [self.lowTip, self.midTip, self.hiTip]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billFieldStr = billField.text
        if !billFieldStr.isEmpty {
            billFieldStr.removeAtIndex(billFieldStr.startIndex)
        }
        
        var billAmount = billFieldStr._bridgeToObjectiveC().doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        if billField.text.isEmpty {
            billField.text = "$"
        }
        if billField.text == "$" {
            UIView.animateWithDuration(0.4, animations: {
                // This causes first view to fade in and second view to fade out
                self.plusSign.alpha = 0
                self.equationBar.alpha = 0
                self.tipLabel.alpha = 0
                self.totalLabel.alpha = 0
                self.msgField.alpha = 1
            })
        } else {
            UIView.animateWithDuration(0.4, animations: {
                // This causes first view to fade in and second view to fade out
                self.plusSign.alpha = 1
                self.equationBar.alpha = 1
                self.tipLabel.alpha = 1
                self.totalLabel.alpha = 1
                self.msgField.alpha = 0
            })
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //load settings here
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipDefault = defaults.integerForKey("default_tip")
        //the tip fields will always have something: if setting was empty, defaults to 0
        var lowTipStr: String! = defaults.stringForKey("low_tip")
        var midTipStr: String! = defaults.stringForKey("mid_tip")
        var highTipStr: String! = defaults.stringForKey("high_tip")
        tipControl.setTitle(lowTipStr, forSegmentAtIndex: 0)
        tipControl.setTitle(midTipStr, forSegmentAtIndex: 1)
        tipControl.setTitle(highTipStr, forSegmentAtIndex: 2)
        
        lowTipStr.removeAtIndex(lowTipStr.endIndex.predecessor())
        midTipStr.removeAtIndex(midTipStr.endIndex.predecessor())
        highTipStr.removeAtIndex(highTipStr.endIndex.predecessor())
        self.lowTip = lowTipStr._bridgeToObjectiveC().doubleValue/100
        self.midTip = midTipStr._bridgeToObjectiveC().doubleValue/100
        self.hiTip = highTipStr._bridgeToObjectiveC().doubleValue/100
        
        tipControl.selectedSegmentIndex = tipDefault
        self.plusSign.alpha = 0
        self.equationBar.alpha = 0
        self.tipLabel.alpha = 0
        self.totalLabel.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")
        println(billField.text)
        self.billField.becomeFirstResponder()
        //billField.text = "$" //this shouldn't be needed. don't know why this is necessary for $ to show up on initialization
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("view did disappear")
    }

    
}

