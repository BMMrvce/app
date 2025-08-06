import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String _currentFontFamily = 'Roboto'; // Track current font family

  // Getters
  ThemeData get currentTheme => _currentTheme;
  ThemeData get darkTheme => _darkTheme;
  ThemeMode get themeMode => _themeMode;
  String get themeName => _themeName;
  String get themeDescription => _themeDescription;
  String get currentFontFamily => _currentFontFamily;
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
    try {
      // Create a proper text theme using Google Fonts
      final textTheme = GoogleFonts.getTextTheme(fontFamily);
      
      _currentFontFamily = fontFamily;
      _currentTheme = _currentTheme.copyWith(textTheme: textTheme);
      _darkTheme = _darkTheme.copyWith(textTheme: textTheme);
      notifyListeners();
    } catch (e) {
      // Fallback to system font if Google Font fails
      print('Error loading font $fontFamily: $e');
      final textTheme = ThemeData().textTheme.apply(fontFamily: fontFamily);
      
      _currentFontFamily = fontFamily;
      _currentTheme = _currentTheme.copyWith(textTheme: textTheme);
      _darkTheme = _darkTheme.copyWith(textTheme: textTheme);
      notifyListeners();
    }
  }

  // Apply theme preset
  void applyThemePreset(ThemeModel themeModel) {
    _themeName = themeModel.name;
    _themeDescription = themeModel.description;
    _currentFontFamily = themeModel.typography.fontFamily;
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
    final textTheme = _currentTheme.textTheme;
    
    return ThemeModel(
      name: _themeName,
      description: _themeDescription,
      colorScheme: ColorSchemeModel.fromColorScheme(scheme),
      typography: TypographyModel(
        fontFamily: _currentFontFamily,
        displayLargeFontSize: textTheme.displayLarge?.fontSize ?? 57.0,
        displayMediumFontSize: textTheme.displayMedium?.fontSize ?? 45.0,
        displaySmallFontSize: textTheme.displaySmall?.fontSize ?? 36.0,
        headlineLargeFontSize: textTheme.headlineLarge?.fontSize ?? 32.0,
        headlineMediumFontSize: textTheme.headlineMedium?.fontSize ?? 28.0,
        headlineSmallFontSize: textTheme.headlineSmall?.fontSize ?? 24.0,
        titleLargeFontSize: textTheme.titleLarge?.fontSize ?? 22.0,
        titleMediumFontSize: textTheme.titleMedium?.fontSize ?? 16.0,
        titleSmallFontSize: textTheme.titleSmall?.fontSize ?? 14.0,
        bodyLargeFontSize: textTheme.bodyLarge?.fontSize ?? 16.0,
        bodyMediumFontSize: textTheme.bodyMedium?.fontSize ?? 14.0,
        bodySmallFontSize: textTheme.bodySmall?.fontSize ?? 12.0,
        labelLargeFontSize: textTheme.labelLarge?.fontSize ?? 14.0,
        labelMediumFontSize: textTheme.labelMedium?.fontSize ?? 12.0,
        labelSmallFontSize: textTheme.labelSmall?.fontSize ?? 11.0,
      ),
      isDark: isDarkMode,
    );
  }
}
