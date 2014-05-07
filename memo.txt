

plugin -> service


straw-ios-http-service
straw-ios-http-service.js

----

A service can be either stateful or stateless.
That's why the naming of `Straw Service Method`.
Reusable services should be most likely stateless.
Application specific services can be stateful.


Service - a bundle of series of functions.
Service Method - a functionality of a service.
Service Call - a call of Service Method.
Service Call Context - a context of a call of Service Method

Service Repository - repository of services
Service Call Factory - factory of service call object

----

The Domain Services should never touch the Application layer.
(But specific service implementations can touch the application layey,
because they are half-application.)

Do people really want stateful services?

----

TODO:
- straw-ios.js
  - ci using gulp
  - bower
  - npm

- experiment on ios-exercise - doing

- STWWebView, STWViewController (in Wrapper group)

- infra
  - straw service registry
    - mongodb, heroku

- http service
  - straw-ios-service-http-native
  - straw-ios-service-http-js

- hud servcie (corresponding to toast service of straw-android)
  - straw-ios-service-hud-native
  - straw-ios-service-hud-js
  - based on MPProgressHUD

- kvdb service (corresponding to sharedPreferences service of straw-android)
  - straw-ios-service-kvdb-native
  - straw-ios-service-kvdb-js
  - based on https://github.com/colinyoung/kvdb

- log servcie
  - straw-ios-service-log-native
  - straw-ios-service-log-js
  - log on each level

- whatsmyip-ios
  - implement existing feature
  - add achievements feature
    - record n times (n=1,5,10,20,30,100,200,300,1000)
    - different n Addresses (n=1,5,10,20,30,100,200,300,1000)

- refactor straw-android
  - rename `plugin` to `service`
  - separate domain and application according to straw-ios
  - remove StrawDrink and instead of that create StrawCallContext interface and StrawCallOperation class (which implements StrawCallContext)

- next application!

DONE:
- Straw.podspec of straw-ios - done
- LogError on call factory failures. - done
- implementation - done
- tests - done
- define interfaces - almost done
- build on xcode 5.1
- STWServiceFactory
- log - done

[END]
