//
//  ViewController.swift
//  TipCalculator
//
//  Created by Liem Ly Quan on 2/19/16.
//  Copyright © 2016 Liem Ly Quan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var billFieldView: UIView!
  @IBOutlet weak var billField: UITextField!
  
  @IBOutlet weak var tipRateView: UIView!
  @IBOutlet weak var tipRateLabel: UILabel!
  
  @IBOutlet weak var tipAmountView: UIView!
  @IBOutlet weak var tipAmountLabel: UILabel!
  
  @IBOutlet weak var totalView: UIView!
  @IBOutlet weak var totalLabel: UILabel!
  
  @IBOutlet weak var totalForTwoView: UIView!
  @IBOutlet weak var totalForTwoLabel: UILabel!
  
  @IBOutlet weak var totalForThreeView: UIView!
  @IBOutlet weak var totalForThreeLabel: UILabel!
  
  @IBOutlet weak var totalForFourView: UIView!
  @IBOutlet weak var totalForFourLabel: UILabel!
  
  var tipRate:Int = 0
  var billAmount:Double = 0
  var userDefaults:NSUserDefaults!
  
  let formatter = NSNumberFormatter()
  let billFieldFormatter = NSNumberFormatter()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideAllField()
    resizeBillFieldToBig()
    
    formatter.numberStyle = .CurrencyStyle
    formatter.maximumFractionDigits = 2

    billFieldFormatter.numberStyle = .DecimalStyle
    billField.placeholder = formatter.stringFromNumber(0)
    tipAmountLabel.text = formatter.stringFromNumber(0)
    totalLabel.text = formatter.stringFromNumber(0)
    totalForTwoLabel.text = formatter.stringFromNumber(0)
    totalForThreeLabel.text = formatter.stringFromNumber(0)
    totalForFourLabel.text = formatter.stringFromNumber(0)
    
    userDefaults = NSUserDefaults.standardUserDefaults()
    if (userDefaults.objectForKey("defaultTipRate") != nil){
      tipRate = userDefaults.integerForKey("defaultTipRate")
      tipRateLabel.text = "\(tipRate)%"
    }

  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(false)
    if (userDefaults.boolForKey("thousandSeparator") == true){
      formatter.usesGroupingSeparator = true
      billFieldFormatter.usesGroupingSeparator = true
    } else {
      formatter.usesGroupingSeparator = false
      billFieldFormatter.usesGroupingSeparator = false
    }
    calculate()
    

  }
  
  override func viewDidAppear(animated: Bool) {
    billField.becomeFirstResponder()
  }
  @IBAction func onTap(sender: AnyObject) {
    view.endEditing(true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
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
    if (billField.text == ""){
      hideAllField()
    } else {
      showAllField()
      resizeBillFieldToSmall()
      billAmount = NSString(string: billField.text!.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)).doubleValue
    }
    let tip = billAmount * Double(tipRate) / 100
    tipAmountLabel.text = String(tip)
    let total = billAmount + tip
    billField.text = billFieldFormatter.stringFromNumber(billAmount)

    changeTotalLabel(totalLabel, total: total, numberOfPeople: 1)
    changeTotalLabel(totalForTwoLabel, total: total, numberOfPeople: 2)
    changeTotalLabel(totalForThreeLabel, total: total, numberOfPeople: 3)
    changeTotalLabel(totalForFourLabel, total: total, numberOfPeople: 4)
  }
  
  func changeTotalLabel(label:UILabel, total:Double, numberOfPeople:Int){
    label.text = formatter.stringFromNumber(total / Double(numberOfPeople))
  }
  
  func hideAllField(){
    tipRateView.alpha = 0
    tipAmountView.alpha = 0
    totalView.alpha = 0
    totalForTwoView.alpha = 0
    totalForThreeView.alpha = 0
    totalForFourView.alpha = 0
  }
  
  func showAllField(){
    tipRateView.alpha = 1
    tipAmountView.alpha = 1
    totalView.alpha = 1
    totalForTwoView.alpha = 1
    totalForThreeView.alpha = 1
    totalForFourView.alpha = 1
  }
  
  func resizeBillFieldToSmall(){
    billFieldView.frame.size.height = 104
    billField.frame.size.height = 104
    billFieldView.backgroundColor = UIColor.greenColor()
  }
  
  func resizeBillFieldToBig(){
    billFieldView.frame.size.height = 294
    billField.frame.size.height = 294
    billFieldView.backgroundColor = UIColor.whiteColor()
  }
  
  
}

