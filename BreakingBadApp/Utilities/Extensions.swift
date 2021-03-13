//
//  Extensions.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 12/03/2021.
//

import UIKit

extension UIViewController {

    func presentCustomAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = CustomAlertView(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
}
