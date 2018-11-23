import ActionSheetPicker_3_0

extension QuickActionsPicker {
    /// Attach the Quick Actions Picker to the specified ActionSheetPicker and show it.
    /// - Parameter picker: Initialized ActionSheetPicker of any type.
    func attachAndShow(picker: AbstractActionSheetPicker?) {
        guard let picker = picker else { return }

        // Picker subviews are created only after we try to show it.
        picker.show()

        translatesAutoresizingMaskIntoConstraints = false

        // We can't add QAP directly to the picker because then the control
        // would be unresponsive: it would be out of view bounds.
        guard
            /// The container view of the picker to which we will align.
            let masterView = picker.toolbar.superview,
            /// The canvas view of the picker where we'll add quick actions as subview.
            let canvas = masterView.superview
        else { return }

        canvas.addSubview(self)
        canvas.addConstraints([
            // We have to adjust by `frame.origin` because of ActionSheetPicker construction.
            // If we don't do that, the Quick Actions panel would be on the bottom of the screen.
            bottomAnchor.constraint(equalTo: masterView.topAnchor, constant: canvas.frame.origin.y),
            leftAnchor.constraint(equalTo: masterView.leftAnchor),
            rightAnchor.constraint(equalTo: masterView.rightAnchor)
        ])
    }
}
