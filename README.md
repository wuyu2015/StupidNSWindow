# StupidNSWindow

StupidNSWindow is a Swift package that empowers developers with enhanced customization capabilities for macOS window titlebars. It offers flexibility in adjusting the titlebar height, repositioning window controls such as close, minimize, and maximize buttons.

## Features

- **Customizable Titlebar Height:** Easily adjust the height of the window titlebar to fit your application's layout requirements.
- **Flexible Button Placement:** Move and reposition close, minimize, and maximize buttons within the titlebar according to your preferences.

## Installation

You can integrate StupidNSWindow into your Xcode project using Swift Package Manager:

1. In Xcode, select "File" -> "Swift Packages" -> "Add Package Dependency..."
2. Enter the URL of this repository: https://github.com/wuyu2015/StupidNSWindow.git
3. Follow the prompts to complete the integration process.

## Usage

```swift
import Cocoa
import StupidNSWindow

// Subclass StupidNSWindow instead of NSWindow
class CustomWindow: StupidNSWindow {
    // Continuing to improve the class
}

let window = CustomWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 300), styleMask: [.titled, .closable, .miniaturizable, .resizable], backing: .buffered, defer: false)

// Customize titlebar height
window.titlebarHeight = 38
```

## License

StupidNSWindow is available under the MIT license.

---

# StupidNSWindow

StupidNSWindow 是一个 Swift Package，为 macOS 窗口标题栏提供了增强的定制能力。它可以灵活调整标题栏高度、重新定位关闭、最小化和最大化按钮。

## 特点

- **可定制的标题栏高度：** 调整窗口标题栏的高度，以适应您应用的布局需求。
- **灵活的按钮位置：** 根据需要移动和重新定位关闭、最小化和最大化按钮。

## 安装

您可以使用 Swift Package Manager 将 StupidNSWindow 集成到您的 Xcode 项目中：

1. 在 Xcode 中，选择 "File" -> Swift Packages" -> ""Add Package Dependency..."
2. 输入此 URL：https://github.com/wuyu2015/StupidNSWindow.git
3. 按照提示完成集成过程。

## 使用

```swift
import Cocoa
import StupidNSWindow

// 不要再直接继承 NSWindow，而是继承 StupidNSWindow
class CustomWindow: StupidNSWindow {
    // 继续完善类
}

let window = CustomWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 300), styleMask: [.titled, .closable, .miniaturizable, .resizable], backing: .buffered, defer: false)

// 自定义标题栏高度
window.titlebarHeight = 38
```

## 许可证

StupidNSWindow 使用 MIT 许可证。
