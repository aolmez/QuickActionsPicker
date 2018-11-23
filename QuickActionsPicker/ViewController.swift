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

    @IBAction func buttonTapped() {
        // Prepare data for putting into pickers.
        var rows = [String]()
        for num in stride(from: 10, through: 95, by: 5) {
            rows.append("\(num) g")
        }
        for num in stride(from: 100, through: 200, by: 10) {
            rows.append("\(num) g")
        }
        let quickActions = ["10 g", "20 g", "50 g", "200 g"]
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Avenir", size: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize) as Any
        ]

        /// Declare a picker var to be used in the Quick Actions closure.
        var asPicker: ActionSheetStringPicker?

        let quickPanel = QuickActionsPicker(items: quickActions, separator: "|", fontAttributes: attrs) { [weak self] qap, item in
            self?.button.setTitle(String(describing: item), for: UIControl.State.normal)
            // We probably want to hide the quick actions picker for now
            // because it doesn't animate too well along the action sheet.
            qap.isHidden = true
            // Tapping on a quick action is equivalent to dismissing the picker.
            asPicker?.hideWithCancelAction()
        }
        quickPanel.backgroundColor = UIColor.lightGray

        asPicker = ActionSheetStringPicker.init(
            title: "Tomato",
            rows: rows,
            initialSelection: 18,
            doneBlock: { [weak self] picker, index, value in
                quickPanel.isHidden = true
                self?.button.setTitle(rows[index], for: UIControl.State.normal)
            },
            cancel: { picker in
                quickPanel.isHidden = true
            },
            origin: button
        )

        /// Quick Actions Picker's extension for ActionSheetPicker in action.
        quickPanel.attachAndShow(picker: asPicker)
    }
}

