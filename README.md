# Campus Vaults

Campus Vaults is an offline learning mobile application developed using Flutter. The application is designed to provide students with access to learning materials, courses, downloads, notifications, and profile information, particularly in areas with limited or unreliable internet access.

## Features

* Student registration and login
* Forgot password functionality
* Student dashboard
* My Courses
* Learning Materials
* Offline downloads
* Notifications
* Student profile
* Bottom navigation
* Local data storage
* Responsive Flutter user interface

## Requirements

Before running the application, make sure the following are installed:

* Flutter SDK
* Dart SDK
* Android Studio
* Android SDK
* Android Emulator or a physical Android device
* Visual Studio Code or another Flutter-compatible IDE

## Setup Instructions

1. Extract or copy the `campus_vaults` project folder to your computer.
2. Open the project folder in Visual Studio Code.
3. Open a terminal in the project folder.
4. Check that Flutter is installed by running:

```bash
flutter --version using power shell
```

5. Get the required Flutter packages by running:

```bash
flutter pub get using powershell
```

6. Check the available devices by running:

```bash
flutter devices using power shell
```

7. Start an Android emulator or connect a physical Android device.

8. Run the application using:

```bash
flutter run using powershell and also in android emulator
```

## Project Structure

```text
campus_vaults/
├── android/
├── assets/
├── ios/
├── lib/
├── test/
├── web/
├── windows/
├── pubspec.yaml
└── README.md
```

The main application code is located in the `lib` folder. Assets such as images and learning resources are stored in the `assets` folder.

## Testing

The application was functionally tested for application launch, registration, login, navigation, learning materials, courses, notifications, profile information, and other implemented user flows.

## Development Notes

This project was developed as an educational prototype. Some features use local or mock data rather than a live backend.

For a production release, the application would require a secure backend, proper authentication, encrypted data handling, cloud-based learning resources, online and offline data synchronization, stronger error handling, and testing on a wider range of physical Android devices.

## Author

Campus Vaults Flutter Project
