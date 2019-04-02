//
//  AlertUtil.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-18.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit

class AlertUtil {
    
    static func showAlert(in vc:UIViewController, msg:String, title:String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title:ALERT.OK_BUTTON, style: .default, handler: nil)
        alertController.addAction(action)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    
}



