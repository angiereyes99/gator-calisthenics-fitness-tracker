# gator_calisthenics_fitness_tracker

Full stack iOS mobile application using Flutter, Dart, and Firebase's Cloud Firestore.

## Special Thanks

Thank you Rebecca Zumaeta for designing an amazing app logo! <br>
Feel free to check her our on her github: [rezum](https://github.com/rezum)

## How To Run Application

### Dependencies
- [Dart](https://dart.dev/get-dart)
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Cocoapods](https://guides.cocoapods.org/using/getting-started.html)
- [Xcode](https://developer.apple.com/xcode/)

## Building and Running Application



#### APPLICATION RUNS BEST ON VISUAL STUDIO CODE
```
- git clone the repo
- cd to gator_calisthenics_fitness_tracker/gator_calisthenics_fitness_tracker
- open iOS emulator device

In project directory in the terminal run:

- flutter pub get 
- flutter run or run 'F5'
- At this point, the project should be running pod install and Xcode build and once its finished the app will launch!
```
#### DISCLAIMER: Depending on your Mac and wifi, the wait time may vary! Dont stop it from running and let it load!


## Application Structure
```bash
.
├── lib
│    ├── models
│    │      ├── theme_model.dart
│    │      └── workouts_model.dart
│    ├── pages
│    │      ├── login_page.dart
│    │      ├── about_page.dart
│    │      ├── profile_page.dart
│    │      ├── workouts_page.dart
│    │      ├── goals_page.dart
│    │      ├── favorites_page.dart
│    │      └── running_tracker_page.dart
│    │
│    ├── services
│    │      ├── google_signin_service.dart
│    │      └── main_navigation.dart
│    │
│    ├── utils
│    │      └── constants.dart
│    ├── main.dart
└── README.md
```



## Firebase and Firestore
Data is stored in Firebase's Firestore in real-time through my personal console. <br>
If you would like to use your own Firebase console to view your data feel free to visit
[adding Firebase to Flutter here](https://firebase.google.com/docs/flutter/setup). <br> Keep in mind the field names and structures when handling your new database.



## Firestore Structure
```bash
.
├── 'todos':
│       ├── 'email': string
│       ├── 'todo_item': string
│       ├── 'is_me':  boolean
│       ├── 'has_completed': boolean
│       └── 'datetime': datetime
│ 
├── 'favorites':
│       ├── 'email': string
│       ├── 'workout': string
│       ├── 'is_favorite':  boolean
│       └── 'datetime': datetime
│
├── 'running_times':
│       ├── 'email': string
│       ├── 'duration': string
│       └── 'has_completed': boolean

```



## Help
For help getting started with Flutter, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.