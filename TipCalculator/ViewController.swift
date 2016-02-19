//
//  ViewController.swift
//  TipCalculator
//
//  Created by Liem Ly Quan on 2/19/16.
//  Copyright © 2016 Liem Ly Quan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var billField: UITextField!
  @IBOutlet weak var tipRateLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  
  var tipRate:Int = 0
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    totalLabel.text = "$0.00"
    tipRateLabel.text = "0%"

    
  }
  @IBAction func onTap(sender: AnyObject) {
    view.endEditing(true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onEditingChange(sender: AnyObject) {
    calculate()
  }

  @IBAction func onDrag(sender: UIPanGestureRecognizer) {
    let translation = sender.translationInView(self.view!)
    changeRate(Int(translation.x / 20))
    calculate()
  }
  
  func changeRate(rate:Int){
    tipRate += rate
    if (tipRate < 0){
      tipRate = 0
    } else if (tipRate > 100){
      tipRate = 100
    }
    tipRateLabel.text = "\(tipRate)%"
  }

  func calculate(){
    let billAmount = NSString(string: billField.text!).doubleValue
    let tip = billAmount * Double(tipRate) / 100
    let total = billAmount + tip
    totalLabel.text = String(format: "$%.2f", total)
  }
  
}

