//
//  BannerAdsController.swift
//  iOS_AdsMob_Plug
//
//  Created by macbook pro on 01/12/18.
//  Copyright © 2018 Omni-Bridge. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BannerAdsController: UIViewController {
    // MARK:- Outlet declaration
    @IBOutlet var bannerView: GADBannerView!
    
    // MARK:- View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Banner AdMob"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if General.isConnectedToNetwork(){
            bannerView.adUnitID = Constants.BANNER_ADS_ID.rawValue
            bannerView.rootViewController = self
            bannerView.delegate = self
            bannerView.load(GADRequest())
        }else{
            General.addNoInternetChildView(viewCont: self)
        }
    }
}

// MARK: - NetworkChangesDelegates
extension BannerAdsController : NetworkChangesDelegates{
    func callBackToCalledViewController() {
        self.viewWillAppear(true)
    }
}

// MARK: - GADBannerViewDelegate
extension BannerAdsController : GADBannerViewDelegate{
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
