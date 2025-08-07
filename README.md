# AppPainter Minimal

A minimal Flutter application for creating and customizing Material Design 3 themes, inspired by the original AppPainter project.

## Features

✅ **Theme Export/Import Functionality**
- Export themes as JSON files with a single click
- Import existing themes from your computer
- Full theme data preservation including colors and typography

✅ **Enhanced Color Management**
- Real-time color editing with visual color picker
- Hex code display and RGB values
- Automatic contrast calculation for text colors
- Support for all Material Design 3 color roles:
  - Primary, Secondary, Tertiary colors
  - Surface and Background colors
  - Error colors with proper contrast
  - Outline colors for borders

✅ **Typography Controls**
- Google Fonts integration with popular font selection
- Real-time font preview across all theme components
- Typography scale samples showing different text styles

✅ **Theme Presets**
- 5 built-in professional theme presets:
  - Material Blue - Classic Material Design
  - Dark Professional - Modern dark theme
  - Royal Purple - Elegant purple palette
  - Nature Green - Fresh green theme
  - Sunset Orange - Warm orange theme
- One-click preset loading

✅ **Real-time Preview**
- Side-by-side editor and preview layout
- Live preview of all Material Design components:
  - App bars and navigation
  - Buttons and form controls
  - Cards and surfaces
  - Typography samples
  - Color swatches

✅ **Additional Features**
- Dark/Light mode toggle with automatic color adjustments
- Theme naming and metadata management
- Responsive two-panel layout
- Professional Material Design 3 implementation

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone this repository or download the source code
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

### Development

To generate the JSON serialization code (if you make changes to the models):
```bash
flutter packages pub run build_runner build
```

## Project Structure

```
lib/
├── main.dart                      # Application entry point
├── models/
│   ├── theme_model.dart           # Theme data models
│   └── theme_model.g.dart         # Generated JSON serialization
├── providers/
│   └── theme_provider.dart        # Theme state management
├── screens/
│   └── main_screen.dart           # Main application screen
├── services/
│   └── theme_service.dart         # Theme import/export service
└── widgets/
    ├── theme_editor_panel.dart    # Theme editing interface
    └── theme_preview_panel.dart   # Live theme preview
```

## Dependencies

- **flutter**: Flutter SDK
- **material_color_utilities**: Material Design color utilities
- **file_picker**: File import/export functionality
- **google_fonts**: Google Fonts integration
- **flutter_colorpicker**: Color picker widget
- **provider**: State management
- **json_annotation**: JSON serialization annotations
- **build_runner**: Code generation
- **json_serializable**: JSON serialization code generation

## Usage

1. **Creating a Theme**: Start with one of the built-in presets or create your own from scratch
2. **Editing Colors**: Use the Colors tab to modify individual color roles with the visual color picker
3. **Typography**: Select from popular Google Fonts in the Typography tab
4. **Preview**: View your changes in real-time in the Preview panel
5. **Export**: Save your theme as a JSON file using the Export button
6. **Import**: Load previously saved themes using the Import button

## Building for Release

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Windows
```bash
flutter build windows --release
```

### macOS
```bash
flutter build macos --release
```

### Linux
```bash
flutter build linux --release
```

## License

This project is inspired by the original AppPainter by zeshuaro and is created for educational purposes.

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request
