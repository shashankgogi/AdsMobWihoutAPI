//
//  InfoViewController.swift
//  iOS_AdsMob_Plug
//
//  Created by macbook pro on 01/12/18.
//  Copyright © 2018 Omni-Bridge. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    // MARK:- variable & outlets declaration
    @IBOutlet weak var imgViewForAds: UIImageView!
    @IBOutlet weak var txtViewForDesc: UITextView!
    @IBOutlet weak var lblForAdsTitle : UILabel!
    var strAdsName = ""
    let infoDict = ["Banner":"Banner ads are rectangular image or text ads that occupy a spot within an app's layout. They stay on screen while users are interacting with the app, and can refresh automatically after a certain period of time",
                    "Interstitial":"Interstitials are full-screen ads that cover the interface of an app until closed by the user. They're best used at natural pauses in the flow of an app's execution, such as in between levels of a game or just after completing a task.",
                    "Native":"Native is a component-based ad format that gives you the freedom to customize the way assets like headlines and calls to action are presented in their apps. By choosing fonts, colors, and other details for yourself, you can create natural, unobtrusive ad presentations that can add to a rich user experience.",
                    "Rewarded video":"Rewarded video ads are full screen video ads that users have the option of watching in full in exchange for in-app rewards."]
    // MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtViewForDesc.isEditable = false
        self.lblForAdsTitle.text = self.strAdsName
        self.navigationItem.title = "AdMob Information"
        if let desc = infoDict[strAdsName]{
            self.txtViewForDesc.text = desc
            imgViewForAds.image = UIImage(named: self.strAdsName)
        }
    }
}
