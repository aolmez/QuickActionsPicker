# QuickActionsPicker
A simple Quick Actions panel with support for ActionSheetPicker-3.0.

![QuickActionsPicker
screenshot](https://github.com/karabatov/QuickActionsPicker/blob/master/screenshot.png?raw=true)

### Running the example app
* Clone the repo
* Run `pod install`
* Open `QuickActionsPicker.xcworkspace`
* No signing or team necessary to run on the simulator

### Features
* Supports, but does not require `ActionSheetPicker-3.0`, via extension.
* Displays up to 4 items horizontally.
* Provides an auto-sizing panel which you can put anywhere with left, right and
    bottom Auto Layout anchors.
* Supports any data type which is `CustomStringConvertible`, not just strings.
* Supports character-based separators between items. Set to empty to disable
    them.
* Uses provided font attributes so the items can be styled in any way you want.
* Provides a single callback that returns a data item you provided.
* Returns a simple `UIView` so you can style it any way you want.

### TODO
* Make a CocoaPod. Does anyone want it?
