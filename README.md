# HPKeyboard

HPKeyboard is an emoji keyboard =D 
- Support switch between iOS Keyboard and emoji keyboard. 
- Updating...

Author is a crazy boy =D, he also wrote some open source [HPCollectionLayout] and [HPTabbarController].

### Version
1.0.0

### Installation 

With CocoaPods. ([CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C.)

```ruby
platform :ios, '6.0'
pod "HPKeyboard", "~> 1.0.0"
```

Or copy over the `Classes` folder to your project folder.
### Usage
Import HPKeybopard header file
`#import "HPKeyboard.h"`
```objective-c
...
   UITextView *_textView;
...
  // switch to emoji keyboard.
  [_textView switchToKeyboardType:HPKeyboardStandard];
...
  // switch to original keyboard.
  [_textView switchToKeyboardType:HPKeyboardDefault];
```
[HPCollectionLayout]:https://github.com/huyphams/HPCollectionLayout
[HPTabBarController]:https://github.com/huyphams/HPTabBarController

## Contact

- [@duchuykun@gmail.com](http://facebook.com/huyphams)

If you use/enjoy `HPKeyboard`, let me know!

## License

HPKeyboard is available under the MIT license. See the LICENSE file for more info.
