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

        let quickActions = ["10 g", "20 g", "50 g", "200 g"]

        let quickPanel = QuickActionsPicker(items: quickActions) { [weak self] item in
            self?.button.setTitle(String(describing: item), for: UIControl.State.normal)
            // Tapping on a quick action is equivalent to dismissing the picker.
            asPicker?.hideWithCancelAction()
        }
        quickPanel.backgroundColor = UIColor.lightGray

        quickPanel.attachAndShow(picker: asPicker)
    }
}

