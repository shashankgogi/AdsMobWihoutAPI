//
//  NoInternetController.swift
//  iOS_UniversalNoInternetPlug
//
//  Created by macbook pro on 19/07/18.
//  Copyright © 2018 Omni-Bridge. All rights reserved.
//

import SystemConfiguration
import UIKit

/// BookmarkDelegates protocol for sending back data to VC
protocol NetworkChangesDelegates {
    func callBackToCalledViewController()
}


class NoInternetController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblForTitleMessage: UILabel!
    @IBOutlet weak var lblForTitleDesc: UILabel!
    @IBOutlet weak var lblForOR: UILabel!
    @IBOutlet weak var btnForOfflineMode: UIButton!
    var delegate : NetworkChangesDelegates?
    
    // MARK:- view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnForOfflineMode.isHidden = true
        self.lblForOR.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Used tp present alert view
    ///
    /// - Parameter sender: Uibutton
    @IBAction func tryAgainPressed(_ sender: Any) {
        if General.isConnectedToNetwork(){
            self.view.removeFromSuperview()
            delegate?.callBackToCalledViewController()
        }
    }
    
    @IBAction func contOfflinePressed(_ sender: Any) {
        self.view.removeFromSuperview()
        delegate?.callBackToCalledViewController()
    }
}
