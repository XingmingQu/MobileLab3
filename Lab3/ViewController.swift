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
    
    // --------All the labels---------
    @IBOutlet weak var todayStepLabel: UILabel!
    @IBOutlet weak var yesterdayStepLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var goalStepLabel: UILabel!
    @IBOutlet weak var goalAchievedStack: UIStackView!
    
    // --------All the lazy vars---------
    lazy var Activity = ""
    lazy var stepsOfToday = 0
    lazy var numStepsYesterday = 0
    lazy var goalSteps = 0
    
    //---------All the  CM things -------------
    let pedometer = CMPedometer()
    let activityManager = CMMotionActivityManager()
    let customQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.goalAchievedStack.isHidden=true
        
        // set up the montion activity
        if CMMotionActivityManager.isActivityAvailable(){ self.activityManager.startActivityUpdates(to: customQueue) { (activity:CMMotionActivity?) -> Void in
            //            NSLog("%@",activity!.description)
            self.Activity = self.getActivity(activity: activity!)
            //            NSLog("%@",self.Activity)
            //            NSLog("%@","Current activity: "+self.Activity)
            DispatchQueue.main.async{
                self.activityLabel.text="Current activity: "+self.Activity
            }
            }
        }
        
        // set up the pedometer
        if CMPedometer.isStepCountingAvailable() {
            self.pedometer.startUpdates(from: Date()) {
                (pedData: CMPedometerData?, error: Error?) -> Void in
                NSLog("%@",pedData!.numberOfSteps)
                DispatchQueue.main.async{
                    self.todayStepLabel.text="Steps of Today: "+String(pedData!.numberOfSteps.intValue)
                }
            }
        }
        
        
        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let rounded = Int(sender.value)/100 * 100
        self.goalStepLabel.text=String(rounded)
    }
    
    func getActivity(activity: CMMotionActivity) -> String {
        if activity.walking {
            return "Walking"
        }
        else if activity.running {
            return "Running"
        }
        else if activity.cycling {
            return "Cycling"
        }
        else if activity.automotive {
            return "Driving"
        }
        else if activity.stationary {
            return "Stationary"
        }
        return "Unknown"
    }
    
    
}

