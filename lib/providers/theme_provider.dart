import 'package:flutter/material.dart';
import '../models/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  );
  
  ThemeData _darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
    useMaterial3: true,
  );

  ThemeMode _themeMode = ThemeMode.light;
  String _themeName = 'Custom Theme';
  String _themeDescription = 'Custom Material Design 3 theme';

  // Getters
  ThemeData get currentTheme => _currentTheme;
  ThemeData get darkTheme => _darkTheme;
  ThemeMode get themeMode => _themeMode;
  String get themeName => _themeName;
  String get themeDescription => _themeDescription;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Update theme name and description
  void updateThemeInfo(String name, String description) {
    _themeName = name;
    _themeDescription = description;
    notifyListeners();
  }

  // Toggle between light and dark mode
  void toggleThemeMode() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Update color scheme
  void updateColorScheme(ColorScheme colorScheme, {bool isDark = false}) {
    final theme = ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
    );
    
    if (isDark) {
      _darkTheme = theme;
    } else {
      _currentTheme = theme;
    }
    notifyListeners();
  }

  // Update single color in the scheme
  void updateSingleColor(String colorRole, Color color) {
    final currentScheme = isDarkMode ? _darkTheme.colorScheme : _currentTheme.colorScheme;
    ColorScheme newScheme;
    
    switch (colorRole) {
      case 'primary':
        newScheme = currentScheme.copyWith(primary: color);
        break;
      case 'secondary':
        newScheme = currentScheme.copyWith(secondary: color);
        break;
      case 'tertiary':
        newScheme = currentScheme.copyWith(tertiary: color);
        break;
      case 'surface':
        newScheme = currentScheme.copyWith(surface: color);
        break;
      case 'background':
        newScheme = currentScheme.copyWith(background: color);
        break;
      case 'error':
        newScheme = currentScheme.copyWith(error: color);
        break;
      default:
        return;
    }
    
    updateColorScheme(newScheme, isDark: isDarkMode);
  }

  // Update typography
  void updateTypography(String fontFamily) {
    final textTheme = ThemeData().textTheme.apply(fontFamily: fontFamily);
    
    _currentTheme = _currentTheme.copyWith(textTheme: textTheme);
    _darkTheme = _darkTheme.copyWith(textTheme: textTheme);
    notifyListeners();
  }

  // Apply theme preset
  void applyThemePreset(ThemeModel themeModel) {
    _themeName = themeModel.name;
    _themeDescription = themeModel.description;
    _currentTheme = themeModel.toThemeData();
    
    // Create dark version
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: Color(themeModel.colorScheme.primary),
      brightness: Brightness.dark,
    );
    _darkTheme = ThemeData(
      colorScheme: darkColorScheme,
      textTheme: themeModel.typography.toTextTheme(),
      useMaterial3: true,
    );
    
    notifyListeners();
  }

  // Get current theme as model for export
  ThemeModel getCurrentThemeModel() {
    final scheme = isDarkMode ? _darkTheme.colorScheme : _currentTheme.colorScheme;
    return ThemeModel(
      name: _themeName,
      description: _themeDescription,
      colorScheme: ColorSchemeModel.fromColorScheme(scheme),
      typography: TypographyModel(
        fontFamily: _currentTheme.textTheme.bodyMedium?.fontFamily ?? 'Roboto',
      ),
      isDark: isDarkMode,
    );
  }
}
