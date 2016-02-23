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
  
  override func viewDidLoad() {
      super.viewDidLoad()
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  @IBAction func onTipRateSliderChanged(sender: UISlider) {
    let value = Int(sender.value)
    tipRateLabel.text = "\(value)%"
    userDefaults.setInteger(value, forKey: "defaultTipRate")
    userDefaults.synchronize()
  }
  
  @IBAction func onThousandSeparatorToggleChanged(sender: UISwitch) {
      userDefaults.setBool(thousandSeparatorSwitch.on, forKey: "thousandSeparator")
      userDefaults.synchronize()

  }
  
}
