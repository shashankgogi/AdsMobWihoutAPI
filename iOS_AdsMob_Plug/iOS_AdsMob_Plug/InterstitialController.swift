//
//  InterstitialController .swift
//  iOS_AdsMob_Plug
//
//  Created by macbook pro on 01/12/18.
//  Copyright © 2018 Omni-Bridge. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InterstitialController: UIViewController {
    // MARK:- variable declaration
    var interstitial: GADInterstitial!
    // MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Interstitial AdMob"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if General.isConnectedToNetwork(){
            interstitial = GADInterstitial(adUnitID: Constants.INTERSTITIAL_ADS_ID.rawValue)
            interstitial.delegate = self
            interstitial.load(GADRequest())
        }else{
            General.addNoInternetChildView(viewCont: self)
        }
    }
    // MARK:- Button action
    @IBAction func loadInterstitialAds(_ sender: Any) {
        if interstitial.isReady{
            interstitial.present(fromRootViewController: self)
        }else{
            print("Not ready yes")
        }
    }
}
// MARK: - NetworkChangesDelegates
extension InterstitialController : NetworkChangesDelegates{
    func callBackToCalledViewController() {
        self.viewWillAppear(true)
    }
}

// MARK: - GADInterstitialDelegate
extension InterstitialController : GADInterstitialDelegate{
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
