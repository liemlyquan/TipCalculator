//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Liem Ly Quan on 2/19/16.
//  Copyright © 2016 Liem Ly Quan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  @IBOutlet weak var tipRateLabel: UILabel!
  @IBOutlet weak var tipRateSlider: UISlider!
  @IBOutlet weak var thousandSeparatorSwitch: UISwitch!
  
  var userDefaults:NSUserDefaults!
  var tipRate:Int!
  var tipRateChanged:Bool = false
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.hidesBackButton = true
    let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "back:")
    self.navigationItem.leftBarButtonItem = newBackButton;
  }
  
  override func viewWillAppear(animated: Bool) {
    userDefaults = NSUserDefaults.standardUserDefaults()
    if (userDefaults.objectForKey("defaultTipRate") != nil){
      tipRate = userDefaults.integerForKey("defaultTipRate")
      tipRateSlider.setValue(Float(tipRate), animated: false)
      tipRateLabel.text = "\(tipRate)%"
    }
    if (userDefaults.objectForKey("thousandSeparator") != nil){ thousandSeparatorSwitch.setOn(userDefaults.boolForKey("thousandSeparator"), animated: false)
      
    }
  }
  
  
  override func viewWillDisappear(animated: Bool) {
    
  }
  
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  @IBAction func onTipRateSliderChanged(sender: UISlider) {
    let value = Int(sender.value)
    tipRateLabel.text = "\(value)%"
    userDefaults.setInteger(value, forKey: "defaultTipRate")
    userDefaults.synchronize()
    tipRateChanged = true
  }
  
  @IBAction func onThousandSeparatorToggleChanged(sender: UISwitch) {
    userDefaults.setBool(thousandSeparatorSwitch.on, forKey: "thousandSeparator")
    userDefaults.synchronize()
    
  }
  
  func back(sender: UIBarButtonItem) {
    if (tipRateChanged){
      let refreshAlert = UIAlertController(title: "Apply new tip rate", message: "Tip rate is changed. Would you like to apply that immediately?", preferredStyle: UIAlertControllerStyle.Alert)
      
      refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
        self.navigationController?.popViewControllerAnimated(true)
        
      }))
      
      refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
        self.navigationController?.popViewControllerAnimated(true)
        
      }))
      
      
      presentViewController(refreshAlert, animated: true, completion: nil)
    } else {
      self.navigationController?.popViewControllerAnimated(true)
      
    }
  }
}
