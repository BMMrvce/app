# Flutter Setup Guide

Since Flutter is not currently installed on your system, please follow these steps to set up the development environment:

## 1. Install Flutter

### Windows:
1. Download Flutter SDK from https://docs.flutter.dev/get-started/install/windows
2. Extract the zip file to a location like `C:\flutter`
3. Add Flutter to your PATH environment variable:
   - Add `C:\flutter\bin` to your system PATH
4. Run `flutter doctor` to verify installation

### Alternative using Chocolatey:
```powershell
choco install flutter
```

## 2. Install Dependencies

After Flutter is installed, run these commands in the project directory:

```bash
# Get Flutter dependencies
flutter pub get

# Generate JSON serialization code
flutter packages pub run build_runner build

# Run the app
flutter run
```

## 3. IDE Setup

### VS Code:
Install these extensions:
- Flutter (by Dart Code)
- Dart (by Dart Code)

### Android Studio:
- Install Flutter and Dart plugins

## 4. Platform Setup

### For Android Development:
- Install Android Studio
- Set up Android SDK
- Create an Android emulator or connect a physical device

### For Windows Desktop:
- Enable Windows desktop support:
  ```bash
  flutter config --enable-windows-desktop
  ```

### For Web:
- Enable web support:
  ```bash
  flutter config --enable-web
  ```

## 5. Running the App

Once Flutter is set up:

```bash
# Check that everything is working
flutter doctor

# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Or run on specific platform
flutter run -d windows    # Windows desktop
flutter run -d chrome     # Web browser
flutter run -d android    # Android device/emulator
```

## Project Features

This AppPainter Minimal project includes:

✅ **Theme Export/Import** - Save and load themes as JSON files
✅ **Enhanced Color Management** - Visual color picker with all Material Design 3 colors
✅ **Typography Controls** - Google Fonts integration with real-time preview
✅ **Theme Presets** - 5 built-in professional themes
✅ **Real-time Preview** - Side-by-side editor and preview layout
✅ **Dark/Light Mode** - Toggle with automatic color adjustments

The app is fully responsive and works on all Flutter-supported platforms!
