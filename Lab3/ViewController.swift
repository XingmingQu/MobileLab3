//
//  ViewController.swift
//  Lab3
//
//  Created by Xingming on 10/8/19.
//  Copyright © 2019 Southern Methodist University. All rights reserved.
//
import CoreMotion
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todayStepLabel: UILabel!
    @IBOutlet weak var yesterdayStepLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var goalStepLabel: UILabel!
    @IBOutlet weak var goalAchievedStack: UIStackView!
    
    
    
    let activityManager = CMMotionActivityManager()
    let customQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.goalAchievedStack.isHidden=true
        
        if CMMotionActivityManager.isActivityAvailable(){ self.activityManager.startActivityUpdates(to: customQueue) { (activity:CMMotionActivity?) -> Void in NSLog("%@",activity!.description)

        } }
        // Do any additional setup after loading the view.
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let rounded = Int(sender.value)/100 * 100
        self.goalStepLabel.text=String(rounded)
    }
    
}

