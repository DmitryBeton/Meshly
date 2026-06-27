# Meshly

**Meshly** is a social platform for creating and sharing 3D models captured with LiDAR on iPhone.

Turn real-world objects and spaces into detailed 3D meshes, publish them, and explore creations from people around the world.

---

## 🚀 Features

* 📱 LiDAR-based 3D scanning
* 🌐 Social feed with community models
* ❤️ Likes, comments, and profiles
* 🧊 High-quality 3D mesh visualization
* 🕶 AR preview of models in real space

---

## 🛠 Status

🚧 In development

---

### AnimatedTabView.swift (line 51)
`AnimatedTabView` retrieves the `UITabBarController` by traversing the internal UIKit view hierarchy (`superview?.superview`, `subviews.last`, `subviews.first?.next`). This approach is fragile and may break after future iOS or SwiftUI updates.

---

### AnimatedTabView.swift (line 79)

The current implementation matches a tab bar image using:
```swift
$0.description.contains(tab.symbolImage)
```
This is unreliable because description is not part of the public API contract and its output is not guaranteed to remain stable across iOS versions.
