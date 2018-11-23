//
//  QuickActionsPicker.swift
//  QuickActionsPicker
//
//  Created by Yuri Karabatov on 23/11/2018.
//  Copyright © 2018 Yuri Karabatov. All rights reserved.
//

import UIKit

final class QuickActionsPicker: UIView {
    /// When an action is selected, we return the underlying item. The user
    /// is then free to convert it back to an object of their choice.
    typealias ActionSelected = (QuickActionsPicker, CustomStringConvertible) -> Void

    private let actionStack = UIStackView()

    /// This is a simple static list of suggestions. We don't want to change it
    /// after the picker has been created. If you need to, recreate the picker.
    private let items: [CustomStringConvertible]
    private let separator: String
    private let actionSelected: ActionSelected?
    private let fontAttributes: [NSAttributedString.Key: Any]

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(items: [CustomStringConvertible], separator: Character = "|", fontAttributes: [NSAttributedString.Key: Any]? = nil, actionSelected: ActionSelected?) {
        // Only take a maximum of four items (more would likely not fit).
        self.items = Array(items.prefix(4))
        self.separator = String(separator)
        self.fontAttributes = fontAttributes ?? QuickActionsPicker.defaultFontAttributes()
        self.actionSelected = actionSelected

        super.init(frame: CGRect.zero)

        configureStackView()
    }

    private func configureStackView() {
        actionStack.axis = .horizontal
        actionStack.distribution = .fill
        actionStack.translatesAutoresizingMaskIntoConstraints = false

        let attrSeparator = NSAttributedString(string: separator, attributes: fontAttributes)

        for (idx, action) in items.prefix(4).enumerated() {
            if !actionStack.arrangedSubviews.isEmpty {
                let sepLabel = UILabel()
                sepLabel.attributedText = attrSeparator
                sepLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
                actionStack.addArrangedSubview(sepLabel)
            }

            let attrTitle = NSAttributedString(string: String(describing: action), attributes: fontAttributes)

            let button = UIButton(type: UIButton.ButtonType.custom)
            button.setAttributedTitle(attrTitle, for: UIControl.State.normal)
            button.addTarget(self, action: #selector(QuickActionsPicker.buttonTapped(sender:)), for: UIControl.Event.touchUpInside)
            button.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
            button.tag = idx
            actionStack.addArrangedSubview(button)

            if let firstButton = actionStack.arrangedSubviews.first as? UIButton {
                button.widthAnchor.constraint(equalTo: firstButton.widthAnchor).isActive = true
            }
        }

        addSubview(actionStack)
        addConstraints([
            actionStack.topAnchor.constraint(equalTo: topAnchor),
            actionStack.leftAnchor.constraint(equalTo: leftAnchor),
            actionStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            actionStack.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }

    /// I would usually use RxSwift for button taps because then
    /// there is no need to expose an `@objc` func. You can't make it private!
    @objc func buttonTapped(sender: UIButton) {
        guard
            // Make sure that it's our button, because the method is public.
            sender.superview == actionStack,
            sender.tag >= items.startIndex && sender.tag <= items.endIndex
        else {
            return
        }

        actionSelected?(self, items[sender.tag])
    }

    private static func defaultFontAttributes() -> [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
