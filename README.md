# Vungle's iOS-SDK-Swift
[![Version](https://img.shields.io/cocoapods/v/VungleSDK-iOS.svg?style=flat)](http://cocoapods.org/pods/VungleSDK-iOS)
[![License](https://img.shields.io/cocoapods/l/VungleSDK-iOS.svg?style=flat)](http://cocoapods.org/pods/VungleSDK-iOS)
[![Platform](https://img.shields.io/cocoapods/p/VungleSDK-iOS.svg?style=flat)](http://cocoapods.org/pods/VungleSDK-iOS)

## Getting Started
Please refer to https://support.vungle.com/hc/en-us/articles/115000816572


### Version Info
The Vungle iOS SDK supports iOS 8+, both 32bit and 64bit apps.  

Our newest iOS SDK (5.1.0) was released on July 5th, 2017. Please ensure you are using Xcode 8.0 or higher to ensure smooth integration. This sample app has been tested on XCode 8.3.3 with Swift 3.1

## Release Notes
### 5.1.0
* Launched new Placements feature.
* Added Native Flex View ad unit. 
* Added Moat Viewability technology.
* Added GZIP for faster network transfers.
* Migrate MRAID to WKWebView on iOS 9 and 10 to address memory leak in UIWebView.
* Disabled iOS 7 support.

### 4.1.0
* Fix for occurrence of a black screen at the end of video
* Cache improvements
* Migrate to UIWebView for end cards on iOS 9 and 10 to address memory leak in UIWebView
* Set user-agent in HTTP header to platform user agent for all external requests
* StoreKit support for MRAID ads

## License
The Vungle iOS-SDK is available under a commercial license. See the LICENSE file for more info.
