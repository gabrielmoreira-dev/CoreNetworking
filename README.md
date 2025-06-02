# CoreNetworking

CoreNetworking is a Swift library that provides essential functionality for performing network operations in a simple and efficient way.

## Installation

### Using Swift Package Manager (SPM)

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

## License

This project is licensed under the [MIT License](https://github.com/gabrielmoreira-dev/CoreNetworking/blob/main/LICENSE).
