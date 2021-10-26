//
//  NativeController.swift
//  iOS_AdsMob_Plug
//
//  Created by macbook pro on 01/12/18.
//  Copyright © 2018 Omni-Bridge. All rights reserved.
//

import UIKit
import GoogleMobileAds

class NativeController: UIViewController {
    
    /// The view that holds the native ad.
    @IBOutlet weak var nativeAdPlaceholder: UIView!
    /// The refresh ad button.
    @IBOutlet weak var refreshAdButton: UIButton!
    /// Displays the current status of video assets.
    @IBOutlet weak var videoStatusLabel: UILabel!
    /// The ad loader. You must keep a strong reference to the GADAdLoader during the ad loading
    /// process.
    var adLoader: GADAdLoader!
    /// The native ad view that is being presented.
    var nativeAdView: GADUnifiedNativeAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Native AdMob"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if General.isConnectedToNetwork(){
            guard let nibObjects = Bundle.main.loadNibNamed("UnifiedNativeAdView", owner: nil, options: nil),
                let adView = nibObjects.first as? GADUnifiedNativeAdView else {
                    assert(false, "Could not load nib file for adView")
            }
            setAdView(adView)
            refreshAd(nil)
        }else{
            General.addNoInternetChildView(viewCont: self)
        }
    }
    func setAdView(_ view: GADUnifiedNativeAdView) {
        // Remove the previous ad view.
        nativeAdView = view
        nativeAdPlaceholder.addSubview(nativeAdView)
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        // Layout constraints for positioning the native ad view to stretch the entire width and height
        // of the nativeAdPlaceholder.
        let viewDictionary = ["_nativeAdView": nativeAdView!]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[_nativeAdView]|",
                                                                options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[_nativeAdView]|",
                                                                options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDictionary))
    }
    
    func imagesOfStar(starRating : NSDecimalNumber?) -> UIImage?{
        guard let rating = starRating?.decimalValue else{
            return nil
        }
        if rating >= 5 {
            return UIImage(named: "stars_5")
        } else if rating >= 4.5 {
            return UIImage(named: "stars_4_5")
        } else if rating >= 4 {
            return UIImage(named: "stars_4")
        } else if rating >= 3.5 {
            return UIImage(named: "stars_3_5")
        } else {
            return nil
        }
    }
    // MARK:- Button Actions
    
    /// Refreshes the native ad.
    @IBAction func refreshAd(_ sender: AnyObject!) {
        refreshAdButton.isEnabled = false
        videoStatusLabel.text = ""
        adLoader = GADAdLoader(adUnitID: Constants.NATIVE_ADS_ID.rawValue, rootViewController: self,
                               adTypes: [ .unifiedNative ], options: nil)
        adLoader.delegate = self
        adLoader.load(GADRequest())
    }
}

// MARK: - GADUnifiedNativeAdLoaderDelegate
extension NativeController : GADUnifiedNativeAdLoaderDelegate{
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        nativeAdView.nativeAd = nativeAd
        refreshAdButton.isEnabled = true
        // Populate the native ad view with the native ad assets.
        
        // The headline is guaranteed to be present in every native ad.
        (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
        
        // Some native ads will include a video asset, while others do not. Apps can use the
        // GADVideoController's hasVideoContent property to determine if one is present, and adjust their
        // UI accordingly.
        if let controller = nativeAd.videoController , controller.hasVideoContent(){
            self.videoStatusLabel.text = "Ad contain a video."
        }else{
            self.videoStatusLabel.text = "Ad does not contain a video."
        }
        // These assets are not guaranteed to be present. Check that they are before
        // showing or hiding them.
        
        (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        
        (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        
        (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        
        (nativeAdView.priceView as? UILabel)?.text = nativeAd.price
        
        (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
        
        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        
        (nativeAdView.starRatingView as? UIImageView)?.image = self.imagesOfStar(starRating: nativeAd.starRating)
        
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print("didFailToReceiveAdWithError")
    }
}

// MARK: - NetworkChangesDelegates
extension NativeController : NetworkChangesDelegates{
    func callBackToCalledViewController() {
        self.viewWillAppear(true)
    }
}
