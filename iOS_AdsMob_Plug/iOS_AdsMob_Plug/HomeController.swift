//
//  ViewController.swift
//  iOS_AdsMob_Plug
//
//  Created by macbook pro on 01/12/18.
//  Copyright © 2018 Omni-Bridge. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    // MARK:- variable declaration
    var strAdsInfoName = ""
    // MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdsInfoSegue"{
            let infoVc = segue.destination as! InfoViewController
            infoVc.strAdsName = self.strAdsInfoName
        }
    }
    // MARK:- Button action methods
    @IBAction func adsInfoPressed(sender : UIButton){
        switch sender.tag {
        case 1:
            strAdsInfoName = "Banner"
        case 2:
            strAdsInfoName = "Interstitial"
        case 3:
            strAdsInfoName = "Native"
        case 4:
            strAdsInfoName = "Rewarded video"
        default:
            print("Nothing to select")
        }
        self.performSegue(withIdentifier: "AdsInfoSegue", sender: self)
    }
    
}

