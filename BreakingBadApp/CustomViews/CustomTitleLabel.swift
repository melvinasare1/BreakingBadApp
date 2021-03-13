//
//  CustomTitleLabel.swift
//  BreakingBadApp
//
//  Created by Melvin Asare on 12/03/2021.
//

import UIKit

class CustomTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(labelText: String, textAlignment: NSTextAlignment, fontSize: CGFloat, fontColor: UIColor, fontWeight:  UIFont.Weight) {
        self.text = labelText
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = fontColor
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
