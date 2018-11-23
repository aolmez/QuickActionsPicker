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
    typealias ActionSelected = (CustomStringConvertible) -> Void

    private let actionStack = UIStackView()

    /// This is a simple static list of suggestions. We don't want to change it
    /// after the picker has been created. If you need to, recreate the picker.
    private let items: [CustomStringConvertible]
    private let separator: String
    private let actionSelected: ActionSelected?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(items: [CustomStringConvertible], separator: Character = "|", actionSelected: ActionSelected?) {
        // Only take a maximum of four items (more would likely not fit).
        self.items = Array(items.prefix(4))
        self.separator = String(separator)
        self.actionSelected = actionSelected

        super.init(frame: CGRect.zero)

        configureStackView()
    }

    private func configureStackView() {
        actionStack.axis = .horizontal
        actionStack.distribution = .fill
        actionStack.translatesAutoresizingMaskIntoConstraints = false

        for (idx, action) in items.prefix(4).enumerated() {
            if !actionStack.arrangedSubviews.isEmpty {
                let sepLabel = UILabel()
                sepLabel.text = separator
                sepLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
                actionStack.addArrangedSubview(sepLabel)
            }

            let button = UIButton(type: UIButton.ButtonType.custom)
            button.setTitle(String(describing: action), for: UIControl.State.normal)
            button.addTarget(self, action: #selector(QuickActionsPicker.buttonTapped(sender:)), for: UIControl.Event.touchUpInside)
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

    @objc func buttonTapped(sender: UIButton) {
        print("button")
        guard
            // Make sure that it's our button, because the method is public.
            sender.superview == actionStack,
            sender.tag >= items.startIndex && sender.tag <= items.endIndex
        else {
            return
        }

        actionSelected?(items[sender.tag])
    }
}
