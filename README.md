
# FlexSheet

FlexSheet is a flexible and customizable bottom sheet library for SwiftUI that provides both fixed and dynamic height bottom sheets with smooth animations and gesture interactions.

## Demo

# FlexSheet

FlexSheet is a flexible and customizable bottom sheet library for SwiftUI that provides both fixed and dynamic height bottom sheets with smooth animations and gesture interactions.

## Demo

| Flexible Bottom Sheet | Fixed Bottom Sheet |
|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/6085e733-df9e-4b7c-a74a-7cc0d67e77ae" width="200"> | <img src="https://github.com/user-attachments/assets/5afc30ec-237a-46b2-b699-730c6077b0e1" width="200"> |
| Features multiple snap points (90%, 50%, 25%) with smooth gesture interactions | Maintains constant height with spring animations |


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
3. Select version: 1.2.21 or higher

## Usage

### Fixed Bottom Sheet
A simple bottom sheet with a constant height (default 40% of screen height)

```swift
import SwiftUI
import FlexSheet

struct ContentView: View {
    var body: some View {
        ZStack {
            // Using default fixed style
            FixedBottomSheet(style: .defaultFixed) {
                Text("Fixed Bottom Sheet")
            }
        }
    }
}
```

### Flexible Bottom Sheet
A bottom sheet with three snap points (90%, 50%, 25%) that can be dragged between positions.

```swift
import SwiftUI
import FlexSheet

struct ContentView: View {
    @State private var sheetStyle: BottomSheetStyle = .minimal
    
    var body: some View {
        ZStack {
            // Using default flexible style
            FlexibleBottomSheet(
                currentStyle: $sheetStyle,
                style: .defaultFlex
            ) {
                Text("Flexible Bottom Sheet")
            }
        }
    }
}
```

### Predefined Styles
FlexSheet provides three predefined styles for common use cases:

```swift
// Default fixed style - Standard fixed height sheet (40% of screen)
.defaultFixed

// Default flexible style - Basic animations and gestures
.defaultFlex

// Interactive flexible style - More responsive animations
.interactiveFlex
```

### Custom Styles
You can create custom styles for more control:

```swift
// Custom fixed style
let customFixedStyle = FlexSheetStyle(
    animation: .spring(response: 0.3, dampingFraction: 0.7),
    dragSensitivity: 500,
    allowHide: false,
    fixedHeight: UIScreen.main.bounds.height * 0.3
)

// Custom flexible style
let customFlexStyle = FlexSheetStyle(
    animation: .spring(response: 0.4, dampingFraction: 0.9),
    dragSensitivity: 400,
    allowHide: true,
    sheetSize: .half
)
```

### Sheet Heights
Available heights for flexible bottom sheets:
- `.full` - 90% of screen height
- `.half` - 50% of screen height
- `.minimal` - 25% of screen height
- `.notShow` - Completely hidde
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

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fhooni0918%2FFlexSheet&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
