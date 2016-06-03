# iProgress

![iOS-UI](https://img.shields.io/badge/iOS-UI%20%2F%20UX-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

`iProgress` is an easy way of displaying the progress of an ongoing task on iOS.

`iProgress` is inspired by [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD). This library is specifically designed for iOS and fully respects Apple design and interface guidelines regarding iOS. It is written using Swift 2.2.

## Demo		

Try `iProgress` with the demo project available in this repo.

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate `iProgress` into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "sweebi/iProgress"
```

Run `carthage update` to build the framework and drag the built `iProgress.framework` (in Carthage/Build/tvOS folder) into your Xcode project (Linked Frameworks and Libraries in `Targets`).


### Manually

* Drag the `iProgress.xcodeproj` file into your project.
* Add the `iProgress` framework into `Embedded Binaries`.
* Near `Run` button, select `Manage scheme`.
* Select your app scheme.
* Click on `Edit`.
* Select `Build` on the left menu.
* Uncheck `Find Implicit Dependencies`. This will prevent Xcode from compiling library each time you compile your app.

## Usage

(see sample Xcode project in `/Demo`)

`iProgress` is created as a singleton (i.e. it doesn't need to be explicitly allocated and instantiated; you directly call `iProgress.method`).

**iProgress usage will block the user while loading content. Use it when you need to.**

Using iProgress is very easy. You can use it doing some very simple operations such as :

```swift
iProgress.show()
//add your code here
iProgress.dismiss()
```

You can test if `iProgress` is visble with the following property :
```swift
public var isVisible: Bool { get }
```

### Showing the HUD

You can show the status of indeterminate tasks using this method:

```swift
public static func show(status: String? = .None, contentView: UIView? = .None, loaderType lt: tvLoaderType? = .None, style: iProgressStyle? = .None, withBlurView addBlurView: Bool = true, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None) -> Void
```

Each parameter is optional.
You can either :
* simply call `show()` method to display a simple animation
* specify a status to display a text
* specify a contentView to display the loader on a specific UIView
* specify a loader to change the animation using `tvLoaderType` enum
* specify a style using `iProgressStyle` enum
* specify if you want the background Blur View via the addBlurView parameter
* specify a closure to be executed when the user press the `Menu` button while `iProgress` is displayed
* specify a closure to be executed when the user press the `Play/Pause` button while `iProgress` is displayed

### Showing a progress animation

```swift
static public func showProgress(progress: Double = 0, status: String? = .None, contentView: UIView? = .None, progressType pt: iProgressType? = .None, style: iProgressStyle? = .None, withBlurView addBlurView: Bool = true, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None) -> Void
```

Each parameter is optional.
You can either :
* simply call `showProgress()` method to display a simple progress animation
* specify the progress value (must be between 0 and 1)
* specify a status to display a text
* specify a contentView to display the loader on a specific UIView
* specify a loader to change the animation using `iProgressType` enum
* specify a style using `iProgressStyle` enum
* specify if you want the background Blur View via the addBlurView parameter
* specify a closure to be executed when the user press the `Menu` button while `iProgress` is displayed
* specify a closure to be executed when the user press the `Play/Pause` button while `iProgress` is displayed

### Dismissing the HUD

The HUD can be dismissed using:

```swift
public static func dismiss(delay: Double = 0) -> Void
```

`Delay` parameter is optional.

### Displaying Success or Error

If your loading success or fails, you can display a message that gives information about what happened to the user.

```swift
public static func showSuccessWithStatus(status: String? = .None, andSuccessImage successImage: UIImage? = .None, andStyle style: iProgressStyle? = .None, andAction action: (label: String, closure: (Void -> Void))? = .None, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None) -> Void
public static func showErrorWithStatus(status: String? = .None, andErrorImage errorImage: UIImage? = .None, andStyle style: iProgressStyle? = .None, andAction action: (label: String, closure: (Void -> Void))? = .None, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None) -> Void
```

As it was for showing and dismissing `iProgress`, each parameter is optional so that you can fully customize your success or error displaying.
Following parameters are specific to success / error display :
* You can specify an image to be displayed instead of the default image
* You can specify an `action`. This action is a tuple that contains a label and a closure. If you specify an `action`, the label will be use to generate a button while the closure will be executed when the user presses the button.

If you specify and `action`, `iProgress` won't dismiss. You have to call the dismiss method in your closure. If you don't specify an `action`, `iProgress` will automatically dismiss the same way [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) handles it, that means computing a display time considering the message to be displayed length or 5 seconds if no message is present.

## Customization

We just saw that customization is available in every `iProgress` method call. You also can globally customize `iProgress` using the following properties :

```swift
public var loaderType: tvLoaderType!
public var progressType: iProgressType!
public var style: iProgressStyle!
public var font: UIFont!
public var successImage: UIImage!
public var errorImage: UIImage!
public var minimumDismissDuration: Double!
public var fadeInAnimationDuration: Double!
public var fadeOutAnimationDuration: Double!
```

Each of these properties has to be called on `iProgress.sharedInstance`

### iProgressStyle Enum

`iProgressStyle` is an enum that allows you to customize the appearance of `iProgress`

```swift
public enum iProgressStyle {
    case Dark
    case Light
    case Custom(mainColor: UIColor, secondaryColor: UIColor, blurStyle: UIBlurEffectStyle)
}
```

* Dark style displays `iProgress` on a dark blurStyle background
* Light style displays `iProgress` on a light blurStyle background
* Custom allows you to specify mainColor, secondaryColor and a UIBlurEffectStyle

### tvLoaderType Enum

`tvLoaderType` is an enum that allows you to customize the appearance of the loader when `iProgress` is displayed.

```swift
public enum tvLoaderType {
    case Default()
    case AndroidStyle()
    case Custom(cl: tvLoaderAnimatable.Type)
}
```

The enum has 3 different cases :
* `Default` case that allows you to display a simple animated circle
* `AndroidStyle` case that allows you to display a animated circle which start point is moving
* `Custom` case is here to allow you to add your own animation. You have to pass a parameter that is a class type confirming to `tvLoaderAnimatable` protocol.

### iProgressType Enum

`iProgressType` is an enum that allows you to customize the appearance of the progress animation when `iProgress` is displayed.

```swift
public enum iProgressType {
    case FlatCircle()
    case Custom(cp: iProgressAnimatable.Type)
}
```

The enum has 2 different cases :
* `FlatCircle` case that allows you to display a simple animated circle
* `Custom` case is here to allow you to add your own animation. You have to pass a parameter that is a class type confirming to `iProgressAnimatable` protocol.

### tvLoaderAnimatable Protocol

You can implement your own class to customize the loader appearance. You can refer to the `Demo` app to see how you can implement your own tvLoaderAnimatable class.

```swift
public protocol tvLoaderAnimatable: class {
    init()
    func configureWithStyle(style: iProgressStyle) -> (view: UIView, completion: () -> Void)
}
```

`configureWithStyle` method is the main method you have to implement. This is where you are going to create a view that is animated. You have to return a tuple that contains the view and a closure. The closure will allow us to remove animations when we dismiss `iProgress`.

### iProgressAnimatable Protocol

You can implement your own class to customize the progress animation appearance. You can refer to the `Demo` app to see how you can implement your own iProgressAnimatable class.

```swift
public protocol iProgressAnimatable: tvLoaderAnimatable {
    func updateProgress(progress: Double) -> Void
}
```

`updateProgress` method is called when a progress animation is already show with the `iProgress.showProgress` method. You can update your current progress animation view with the new progress value.

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/sweebi/iProgress/issues/new).

## License

`iProgress` is distributed under the terms and conditions of the [MIT license](https://github.com/sweebi/iProgress/blob/master/LICENSE). The success and error icons are made by [Freepik](http://www.freepik.com) from [Flaticon](http://www.flaticon.com) and are licensed under [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0/).

## Credits

`iProgress` is brought to you by [Cédric Eugeni](https://github.com/CedricEugeni), [Antoine Cormery](https://github.com/legomanfish) and [contributors to the project](https://github.com/sweebi/iProgress/graphs/contributors). If you're using `iProgress` in your project, attribution would be very appreciated.
