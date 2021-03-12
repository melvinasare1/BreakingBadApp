//
//  CustomAlertView.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 12/03/2021.
//

import UIKit

class CustomAlertView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: CustomTitleLabel = {
        let label = CustomTitleLabel()
        label.configure(labelText: "Error",
                        textAlignment: .center,
                        fontSize: 30,
                        fontColor: .darkGray,
                        fontWeight: .bold)
        return label
    }()

    private let subtitleLabel: CustomTitleLabel = {
        let label = CustomTitleLabel()
        label.configure(labelText: "There was an error, please check again",
                        textAlignment: .center,
                        fontSize: 20,
                        fontColor: .lightGray,
                        fontWeight: .medium)
        return label
    }()
}
