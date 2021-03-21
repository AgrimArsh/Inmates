# Inmates: Finding Hostel Roommates
<a href='https://github.com/AgrimArsh/Inmates' align=center>![Alt text](https://github.com/AgrimArsh/Inmates/blob/main/logo.jpg?raw=true "Title")</a>

Inmates is a mobile app for finding suitable roommates for your next semester/year of college. It can be used to find suitable roommates with similar interests and hobbies to get better coordination and friendships with your roommates, which are a quintessial part of hostel life of every college student. 

Note that one can also find the direct apk file for this app as `base.apk` in the `application` folder in the repository, which is a pre-compiled version aimed at those, who are intermediate at GitHub and Flutter.

## System Requirements
Running this system requires the latest version of Flutter SDK, which can be downloaded from the official website <a href='https://flutter.dev/docs/get-started/install'>here</a> and Android SDK, which can be downloaded from the official website <a href=' https://developer.android.com/studio'>here</a>. The user is free to use any IDLE as long as Android SDK and Flutter are supported. Android Studio is preferred.

## Installation

### Direct Installation on Android Device
One can find the direct APK file for this app, which is a pre-compiled version and which can be imported and thereby installed directly on the phone through the local installer. The steps to do so are given below.

1. Download the `base.apk` from the `application` folder in the repository to your Android device.
2. Open the file once its downloaded.
3. Click on `Install` in the window that follows.
4. The application should be downloaded onto your system by the name, 'Inmates'.

### Installation on Windows
1. Fork or Import this repository into your local system.
2. Create a new Flutter project.
3. Write the package name as `com.room.roommates`.
4. Select `Create Project`.
5. Delete the `lib`, `test` and `android` folders and `pubspec.yaml` file from your directory.
6. Copy all the imported files and folders into the project root except `key1.jks`.
7. In the terminal, go to the project root directory.
8. Run the following commands-
  ``` dart
  flutter pub get
  flutter pub run flutter_native_splash:create
  flutter pub run flutter_launcher_icons:main
  ```
 9. Put the `key1.jks` into `C:/Users/Username/key1.jks`.
 10. Open the `android/key.properties` and change the StoreFile variable to `C:/Users/Username/key1.jks`.
 11. You can run `flutter build apk --split-per-abi`
 12. This should compile the APK for you. 
