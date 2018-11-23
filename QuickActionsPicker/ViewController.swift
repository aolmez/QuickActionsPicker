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

        guard
            /// The container view of the picker to which we will align.
            let masterView = picker.toolbar.superview,
            /// The canvas view of the picker where we'll add quick actions as subview.
            let canvas = masterView.superview
        else { return }

        canvas.addSubview(quickPanel)
        canvas.addConstraints([
            quickPanel.bottomAnchor.constraint(equalTo: masterView.topAnchor, constant: canvas.frame.origin.y),
            quickPanel.leftAnchor.constraint(equalTo: masterView.leftAnchor),
            quickPanel.rightAnchor.constraint(equalTo: masterView.rightAnchor)
        ])
    }
}

