# FlexSheet

FlexSheet is a flexible and customizable bottom sheet library for SwiftUI that provides both fixed and dynamic height bottom sheets with smooth animations and gesture interactions.

![iOS](https://img.shields.io/badge/iOS-15.0%2B-blue)
![Swift](https://img.shields.io/badge/Swift-6.0-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-2.0%2B-green)
![License](https://img.shields.io/badge/license-MIT-blue)

## Features

- 🎯 Fixed height bottom sheets
- 📏 Flexible height bottom sheets with three snap points
- 💫 Smooth spring animations
- 🎨 Customizable appearance
- 🔄 Gesture-based interactions
- ♿️ Accessibility support
- 📱 iOS 15.0+ support

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
https://github.com/hooni0918/FlexSheet.git
```

Or add it through Xcode:
1. File > Add Packages
2. Enter package URL: `https://github.com/hooni0918/FlexSheet.git`
3. Select version: 1.0.0 or higher

## Usage
Flexible Bottom Sheet

The flexible bottom sheet supports multiple snap points and can be customized using predefined or custom styles.
```swift
import SwiftUI
import FlexSheet

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            // Using default style
            FlexibleBottomSheet(style: .defaultFlex) {
                VStack {
                    Text("Flexible Sheet")
                        .font(.title)
                    Text("Drag to resize")
                }
                .padding()
            }
            
            // Using interactive style
            FlexibleBottomSheet(style: .interactiveFlex) {
                SheetContent()
            }
            
            // Using custom style
            FlexibleBottomSheet(style: customStyle) {
                SheetContent()
            }
        }
    }
}

// Custom style definition
let customStyle = FlexSheetStyle(
    animation: .spring(response: 0.4, dampingFraction: 0.9),
    dragSensitivity: 400,
    allowHide: true,
    sheetSize: .half,
    fixedHeight: 0
)
```

**Fixed Bottom Sheet**

The fixed bottom sheet maintains a constant height and comes with predefined styles.

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            // Using default fixed style
            FixedBottomSheet(style: .defaultFixed) {
                VStack {
                    Text("Fixed Height Sheet")
                        .font(.title)
                    Text("Content goes here")
                }
                .padding()
            }
            
            // Using custom fixed style
            let customFixedStyle = FlexSheetStyle(
                animation: .spring(response: 0.3, dampingFraction: 0.7),
                dragSensitivity: 500,
                allowHide: false,
                fixedHeight: UIScreen.main.bounds.height * 0.3
            )
            
            FixedBottomSheet(style: customFixedStyle) {
                SheetContent()
            }
        }
    }
}
```
**Predefined Styles**
FlexSheet comes with several predefined styles:

```swift
// Default flexible style - Basic animations and gestures
.defaultFlex

// Interactive flexible style - More responsive animations
.interactiveFlex

// Default fixed style - Standard fixed height sheet
.defaultFixed
```
**Style Properties**

animation: Customizes the sheet transition animation
dragSensitivity: Adjusts how responsive the sheet is to drag gestures
allowHide: Enables/disables complete hiding of the sheet
sheetSize: Sets initial sheet size for flexible sheets

.full - 90% of screen height <br>
.half - 50% of screen height <br>
.minimal - 25% of screen height <br>
.notShow - Completely hidden

fixedHeight: Defines height for fixed sheets

### Customization

You can customize the animation and drag sensitivity:

```swift
FlexibleBottomSheet(
    currentStyle: $sheetStyle,
    animation: .spring(response: 0.3, dampingFraction: 0.7),
    dragSensitivity: 500
) {
    // Your content here
}
```

## Requirements

- iOS 15.0+
- Swift 6.0+
- Xcode 15.0+

## License

FlexSheet is available under the MIT license. See the LICENSE file for more info.

## Author

Ji-hoon Lee (이지훈)

## Support

If you have any questions or need help, please open an issue on GitHub.
