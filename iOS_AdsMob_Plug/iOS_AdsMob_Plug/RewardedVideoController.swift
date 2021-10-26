//
//  RewardedVideoController.swift
//  iOS_AdsMob_Plug
//
//  Created by macbook pro on 01/12/18.
//  Copyright © 2018 Omni-Bridge. All rights reserved.
//

import UIKit
import GoogleMobileAds

class RewardedVideoController : UIViewController{
    // MARK:- Outlet declaration
    var rewardedVideoAd : GADRewardBasedVideoAd! = nil
    @IBOutlet var btnForVideoAds: UIButton!
    @IBOutlet var lblForDesc: UILabel!
    // MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Rewarded Video"
        self.btnForVideoAds.isEnabled = false
        self.btnForVideoAds.backgroundColor = UIColor.gray
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadRewardVideo()
    }
    // MARK:- Button methods
    @IBAction func videoAdsPressed(_ sender: Any) {
        if self.rewardedVideoAd.isReady{
            self.rewardedVideoAd.present(fromRootViewController: self)
        }
    }
    
    func loadRewardVideo() {
        if General.isConnectedToNetwork(){
            rewardedVideoAd = GADRewardBasedVideoAd.sharedInstance()
            rewardedVideoAd.delegate = self
            rewardedVideoAd.load(GADRequest(), withAdUnitID: Constants.REWARDEDVIDEO_ADS_ID.rawValue)
        }else{
            General.addNoInternetChildView(viewCont: self)
        }
    }
}

// MARK: - GADRewardBasedVideoAdDelegate
extension RewardedVideoController : GADRewardBasedVideoAdDelegate{
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        self.lblForDesc.text = "You have total \(reward.amount) coins."
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
        self.btnForVideoAds.setTitle("Watch Video", for: .normal)
        self.btnForVideoAds.backgroundColor = UIColor(hex: "#5B00AF")
        self.btnForVideoAds.isEnabled = true
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad has completed.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        self.btnForVideoAds.isHidden = true
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }
}

// MARK: - NetworkChangesDelegates
extension RewardedVideoController : NetworkChangesDelegates{
    func callBackToCalledViewController() {
        self.viewWillAppear(true)
    }
}
