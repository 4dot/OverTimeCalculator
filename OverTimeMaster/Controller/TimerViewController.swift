//
//  TimerViewController.swift
//  OverTimeMaster
//
//  Created by chanick park on 2/19/19.
//  Copyright © 2019 4Dot. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    
    lazy var timerStatusMgr = TimerStatusManager(OTSetting.defaultTimerStatus)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    // MARK: - private
    
    fileprivate func setTitle(date: Date, options: [String]) {
        
    }
}

extension TimerViewController {
    // MARK: - status buttons
    fileprivate func addStatus(_ status: TimerStatus) {
        timerStatusMgr.addStatus(status)
    }
    
    fileprivate func removeStatus(_ status: TimerStatus) {
        timerStatusMgr.removeStatus(status)
    }
}

