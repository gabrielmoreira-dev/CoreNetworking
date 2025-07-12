# CoreNetworking

CoreNetworking is a Swift library that provides essential functionality for performing network operations in a simple and efficient way.

## ⚙️ Installation

### 📦 Using Swift Package Manager (SPM)

You can add `CoreNetworking` as a dependency in your project in two ways:

#### 1. In an Xcode Project

1. Open your project in Xcode.
2. Go to `File > Add Packages...`.
3. Enter the repository URL:
```https://github.com/gabrielmoreira-dev/CoreNetworking.git```
4. Choose the version you want to install and add the package to your project.


#### 2. In a Swift Package

Add `CoreNetworking` to the dependencies section of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/gabrielmoreira-dev/CoreNetworking.git", from: "1.0.0")
]
```

Then include it in your target’s dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        "CoreNetworking"
    ]
)
```

### 🧪 Test Utils

If you are writing unit tests and need to mock or spy on networking behavior, the `CoreNetworkingTestUtils` target provides helper classes specifically designed for testing purposes.

To use it in your own test target, add `CoreNetworkingTestUtils` as a dependency only in your test target.

#### 1. In an Xcode Project

1. Open your Xcode project.
2. Go to your test target's **Build Phases → Link Binary With Libraries**.
3. Add both `CoreNetworking` and `CoreNetworkingTestUtils` as dependencies to your test target.

#### 2. In a Swift Package

Add `CoreNetworking` and `CoreNetworkingTestUtils` in your test target's dependencies:

```swift
.target(
    name: "YourTargetTests",
    dependencies: [
        .product(name: "CoreNetworking", package: "CoreNetworking"),
        .product(name: "CoreNetworkingTestUtils", package: "CoreNetworking")
    ]
)
```

## 👤 Author

This package was created and is maintained by [Gabriel Moreira](https://github.com/gabrielmoreira-dev).

If you have questions, suggestions, or find any issues, feel free to open an [issue](https://github.com/gabrielmoreira-dev/CoreNetworking/issues) or submit a [pull request](https://github.com/gabrielmoreira-dev/CoreNetworking/pulls).

## 📄 License

This project is licensed under the [MIT License](https://github.com/gabrielmoreira-dev/CoreNetworking/blob/main/LICENSE).
