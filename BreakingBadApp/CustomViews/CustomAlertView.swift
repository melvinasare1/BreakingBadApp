//
//  CustomAlertView.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 12/03/2021.
//

import UIKit

class CustomAlertView: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()

    private lazy var titleLabel: CustomTitleLabel = {
        let label = CustomTitleLabel()
        label.configure(textAlignment: .center,
                        fontSize: 30,
                        fontColor: .darkGray,
                        fontWeight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = alertTitle
        return label
    }()

    private lazy var messageLabel: CustomTitleLabel = {
        let label = CustomTitleLabel()
        label.configure(textAlignment: .center,
                        fontSize: 20,
                        fontColor: .lightGray,
                        fontWeight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.text = message
        return label
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.setTitle(buttonTitle, for: .normal)
        return button
    }()

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?

    override func viewDidLoad() {
        setup()
    }

    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomAlertView {

    struct Constants {
        static let padding: CGFloat = 20
    }

    func setup() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(actionButton)

        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 220).isActive = true

        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.padding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true

        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12).isActive = true

        actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.padding).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.padding).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.padding).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
