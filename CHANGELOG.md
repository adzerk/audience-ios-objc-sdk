# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
nd this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed
- Change iOS Deployment target version to 10.0 ([#45](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/45)).
- Prevent warnings thrown from Pods ([#45](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/45)).
- Require all user ids explicitly in the API ([#44](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/44)).

### Deprecated

### Removed

### Fixed

### Security

### Infrastructural

## [0.3.2] - 2020-09-10
### Changed
- Use version number instead of build number for the User-Agent ([#33](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/33)).

## [0.3.1] - 2020-08-14
### Fixed
- Makes JSONModel usage compatible with Swift 3 ([#29](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/29)).

## [0.3.0] - 2020-07-28
### Added
 - Tracking events model classes `VSDKOrderPlace`, `VSDKOrder`, `VSDKLineItem`, and `VSDKDiscount` ([#26](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/26))
### Removed
 - Tracking events model classes `VSDKPurchase`, `VSDKRefund`, `VSDKPartialRefund`, `VSDKTotalRefund`,`VSDKSubscription`, `VSDKVoucher`, and `VSDKTransaction` ([#26](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/26))

## [0.2.0] - 2020-07-22
### Added
- Specific classes for Partial and Total refunds ([#21](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/21)).
- New AppView tracking event type ([#25](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/25)).
### Changed
- Add `duration` field to Subscription event([#25](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/25)).

## [0.1.0] - 2019-07-16
### Added
- Support for track requests ([#3](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/3))
- Support for match requests ([#9](https://github.com/velocidi/velocidi-ios-objc-sdk/pull/9))
