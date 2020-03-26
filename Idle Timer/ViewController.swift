//
//  ViewController.swift
//  Idle Timer
//
//  Created by Ruben Vitt on 07.02.20.
//  Copyright © 2020 Rubeen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var treeImageWidthContraint: NSLayoutConstraint!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet var threeThumbs: [UIImageView]!
    var currentTree = 1
    var timer: Timer?
    var timePassed = 0
    let roundsNeeded = 1
    var grownTrees = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func buttonOnClickHandler(_ sender: UIButton)
    {
        switch button.titleLabel?.text {
        case "Start":
            resetApp()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerHandle), userInfo: nil, repeats: true)
            button.setTitle("Stop", for: .normal)
        case "Stop":
            stopTrees()
        default:
            break
        }
        
    }
    
    func updateTrees() {
        currentTree += 1
        if let image = UIImage(named: "Tree\(currentTree)") {
            treeImageWidthContraint.constant += treeImageWidthContraint.constant * 0.4
            UIView.transition(with: treeImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.treeImageView.image = image
            }, completion: nil)
            
            treeImageView.image = image
        } else {
            if grownTrees == threeThumbs.count - 1 {
                stopTrees()
            } else {
                currentTree = 0
                treeImageWidthContraint.constant = 100
                updateTrees()
            }
            threeThumbs[grownTrees].alpha = 1
            grownTrees += 1
        }
    }
    
    func resetApp() {
        timer?.invalidate()
        currentTree = 1
        timePassed = 0
        grownTrees = 0
        
        if let image = UIImage(named: "Tree1") {
            treeImageView.image = image
            treeImageWidthContraint.constant = 100
        }
        
        button.setTitle("Start", for: .normal)
        for treeImageView in threeThumbs {
            treeImageView.alpha = 0.4
        }
    }
    
    func stopTrees() {
        timer?.invalidate()
        button.setTitle("Start", for: .normal)
    }
    
    @objc func timerHandle() {
        timePassed += 1
        if timePassed % roundsNeeded == 0 {
            updateTrees()
        }
    }
}

