//
//  ViewController.swift
//  QuickActionsPicker
//
//  Created by Yuri Karabatov on 23/11/2018.
//  Copyright © 2018 Yuri Karabatov. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

final class ViewController: UIViewController {
    @IBOutlet private var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped() {
        let rows = ["10 g", "100 g"]

        let asPicker = ActionSheetStringPicker.init(
            title: "Tomato",
            rows: rows,
            initialSelection: 1,
            doneBlock: { [weak self] picker, index, value in
                self?.button.setTitle(rows[index], for: UIControl.State.normal)
            },
            cancel: nil,
            origin: button
        )

        guard let picker = asPicker else { return }

        let quickPanel = UIView()
        quickPanel.backgroundColor = UIColor.red
        quickPanel.translatesAutoresizingMaskIntoConstraints = false

        let actionStack = UIStackView()
        actionStack.axis = .horizontal
        actionStack.distribution = .fill
        actionStack.translatesAutoresizingMaskIntoConstraints = false

        let quickActions = ["10 g", "20 g", "50 g", "200 g"]
        let separator = "|"

        // Only take the first four items.
        for action in quickActions.prefix(through: 3) {
            if !actionStack.arrangedSubviews.isEmpty {
                let sepLabel = UILabel()
                sepLabel.text = separator
                sepLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
                actionStack.addArrangedSubview(sepLabel)
            }

            let button = UIButton(type: UIButton.ButtonType.custom)
            button.setTitle(action, for: UIControl.State.normal)
            actionStack.addArrangedSubview(button)

            if let firstButton = actionStack.arrangedSubviews.first as? UIButton {
                button.widthAnchor.constraint(equalTo: firstButton.widthAnchor).isActive = true
            }
        }

        quickPanel.addSubview(actionStack)
        quickPanel.addConstraints([
            actionStack.topAnchor.constraint(equalTo: quickPanel.topAnchor),
            actionStack.leftAnchor.constraint(equalTo: quickPanel.leftAnchor),
            actionStack.bottomAnchor.constraint(equalTo: quickPanel.bottomAnchor),
            actionStack.rightAnchor.constraint(equalTo: quickPanel.rightAnchor),
        ])

        // Picker subviews are created only after we try to show it.
        picker.show()

        // We will add our panel to the toolbar's superview and constrain it
        // to the top of the toolbar.
        guard let canvas = picker.toolbar.superview else { return }

        canvas.addSubview(quickPanel)
        canvas.addConstraints([
            // quickPanel.heightAnchor.constraint(equalToConstant: 72.0),
            quickPanel.bottomAnchor.constraint(equalTo: picker.toolbar.topAnchor),
            quickPanel.leftAnchor.constraint(equalTo: picker.toolbar.leftAnchor),
            quickPanel.rightAnchor.constraint(equalTo: picker.toolbar.rightAnchor)
        ])
    }
}

