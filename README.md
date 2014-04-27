# straw-ios v0.0.1 (wip)

[![Build Status](https://travis-ci.org/strawjs/straw-ios.svg)](https://travis-ci.org/strawjs/straw-ios)
[![Coverage Status](https://coveralls.io/repos/strawjs/straw-ios/badge.png)](https://coveralls.io/r/strawjs/straw-ios)
[![MIT License](http://img.shields.io/badge/License-MIT-red.svg)]()

> Straw, the simpler native-webview bridge, for iOS (wip)

## TODO

- implementation
- cocoapods integration
- read whatsmyip-android and detect necessary services for implementing it
  - http service
  - kvdb service (corresponding to sharedPreferences service of straw-android)
  - hud servcie (corresponding to toast service of straw-android)
  - log servcie

- infra
  - straw service registry
    - couchbase, heroku

- refactor straw-android completely
  - separate domain and application according to straw-ios
    - remove StrawDrink and instead of that create StrawCallContext interface and StrawCallOperation class (which implements StrawCallContext)
  - rename `plugin` to `service`
