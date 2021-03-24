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

    func showEmptyStateView(in view: UIView, isHidden: Bool) {
        let emptyStateView = EmptyStateView()
        emptyStateView.isHidden = isHidden
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

extension UIView {

    func constrain(to view: UIView, useSafeArea: Bool = false) {
        if useSafeArea {
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }

    
}

extension String {

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }

    var hasSpecialCharacters: Bool {
        var invalidChars = CharacterSet.letters
        invalidChars.insert(charactersIn: " ")
        invalidChars.invert()
        let acceptedChars = self.trimmingCharacters(in: invalidChars)
        return acceptedChars.count < self.count
    }
}
