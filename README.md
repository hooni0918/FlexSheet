# FlexSheet

FlexSheet is a flexible and customizable bottom sheet library for SwiftUI that provides both fixed and dynamic height bottom sheets with smooth animations and gesture interactions.

![iOS](https://img.shields.io/badge/iOS-14.0%2B-blue)
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

### Fixed Height Bottom Sheet

```swift
import SwiftUI
import FlexSheet

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            FixedBottomSheet(height: 300) {
                VStack {
                    Text("Fixed Height Sheet")
                        .font(.title)
                    Text("Content goes here")
                }
                .padding()
            }
        }
    }
}
```

### Flexible Bottom Sheet

```swift
import SwiftUI
import FlexSheet

struct ContentView: View {
    @State private var sheetStyle: BottomSheetStyle = .minimal
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            FlexibleBottomSheet(currentStyle: $sheetStyle) {
                VStack {
                    Text("Flexible Sheet")
                        .font(.title)
                    Text("Drag to resize")
                    
                    Button("Toggle Full Sheet") {
                        withAnimation {
                            sheetStyle = .full
                        }
                    }
                }
                .padding()
            }
        }
    }
}
```

### Sheet Styles

The FlexibleBottomSheet supports three different heights:
- `.full` - 90% of screen height
- `.half` - 50% of screen height
- `.minimal` - 25% of screen height
- `.notShow` - Completely hidden (0% height)

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

- iOS 14.0+
- Swift 6.0+
- Xcode 15.0+

## License

FlexSheet is available under the MIT license. See the LICENSE file for more info.

## Author

Ji-hoon Lee (이지훈)

## Support

If you have any questions or need help, please open an issue on GitHub.
