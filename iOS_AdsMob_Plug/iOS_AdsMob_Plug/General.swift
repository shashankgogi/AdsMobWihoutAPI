//
//  General.swift
//  iOS_API_UpswingPlug
//
//  Created by macbook pro on 27/07/18.
//  Copyright © 2018 Omni-Bridge. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class General : UIViewController {
    
    /// Used to check connectivity
    ///
    /// - Returns: flag
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let isConnected = (isReachable && !needsConnection)
        
        return isConnected
    }
    
    /// Used to create alert
    ///
    /// - Parameters:
    ///   - title: titke
    ///   - message: message
    /// - Returns: alertview
    static func createAlert(title : String , message : String) -> UIAlertController{
        let alertVC = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler: nil)
        alertVC.addAction(okAction)
        return alertVC
    }
    
    /// Used to present request alert message
    ///
    /// - Parameters:
    ///   - vc: viewcontroller
    ///   - message: message
    static func presenrRequestErrorAlert(vc : UIViewController , message : String){
        let alertVC = UIAlertController(title: "Opps" , message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler: nil)
        alertVC.addAction(okAction)
        vc.present(alertVC, animated: true, completion: nil)
    }
    
    /// Used to add no internet view controller
    ///
    /// - Parameter viewCont: viewcontroller
    static func addNoInternetChildView(viewCont : UIViewController){
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoInternetController") as! NoInternetController
        controller.delegate = viewCont as? NetworkChangesDelegates
        viewCont.addChildViewController(controller)
        viewCont.view.addSubview(controller.view)
        controller.didMove(toParentViewController: viewCont)
    }
    
    /// Used to check for null value
    ///
    /// - Parameter value: value
    /// - Returns: result
    static func Check_null_values(value:Any!) -> Bool {
        if value is NSNull {
            return true
        }
        if value == nil {
            return true
        }
        if value is String && ((value as! String) == "(null)" || (value as! String) == "<null>"  || (value as! String) == "" || (value as! String) == "null") {
            return true
        }
        return false
    }
    
    /// Used to get formated date
    ///
    /// - Parameters:
    ///   - timeStamp: timeStamp
    ///   - formator: formator type
    /// - Returns: formated date
    class func getDateFromTimeStamp(timeStamp : Double , formator : String) -> String {
        let date = NSDate(timeIntervalSince1970: timeStamp)
        if formator == ".Short"{
            let messageDate = Date.init(timeIntervalSince1970: TimeInterval(timeStamp))
            let dataformatter = DateFormatter.init()
            dataformatter.timeStyle = .short
            let date = dataformatter.string(from: messageDate)
            return date
        }
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = formator
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}

// MARK: - Extension user to covert Hex string into UIcolor
extension UIColor {
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

// MARK: - String Extension to identify backspace
extension String {
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
}

/// Constant class with ads Id
enum Constants : String   {
    case BANNER_ADS_ID = "ca-app-pub-3940256099942544/2934735716"
    case INTERSTITIAL_ADS_ID = "ca-app-pub-3940256099942544/4411468910"
    case NATIVE_ADS_ID = "ca-app-pub-3940256099942544/3986624511"
    case REWARDEDVIDEO_ADS_ID = "ca-app-pub-3940256099942544/1712485313"
}
