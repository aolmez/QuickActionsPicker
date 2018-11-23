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

        let quickActions = ["10 g", "20 g", "50 g", "200 g"]

        let quickPanel = QuickActionsPicker(items: quickActions) { [weak self] item in
            self?.button.setTitle(String(describing: item), for: UIControl.State.normal)
        }
        quickPanel.backgroundColor = UIColor.red
        quickPanel.translatesAutoresizingMaskIntoConstraints = false

        // Picker subviews are created only after we try to show it.
        picker.show()

        // We will add our panel to the toolbar's superview and constrain it
        // to the top of the toolbar.
        guard let canvas = picker.toolbar.superview else { return }

        canvas.addSubview(quickPanel)
        canvas.addConstraints([
            quickPanel.bottomAnchor.constraint(equalTo: picker.toolbar.topAnchor),
            quickPanel.leftAnchor.constraint(equalTo: picker.toolbar.leftAnchor),
            quickPanel.rightAnchor.constraint(equalTo: picker.toolbar.rightAnchor)
        ])
    }
}

