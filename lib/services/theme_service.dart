import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;
import '../models/theme_model.dart';

class ThemeService {
  static const String _fileExtension = 'json';

  // Export theme to JSON file
  static Future<bool> exportTheme(ThemeModel theme) async {
    try {
      final jsonString = jsonEncode(theme.toJson());
      final fileName = '${theme.name.replaceAll(' ', '_').toLowerCase()}_theme.json';
      
      if (kIsWeb) {
        // Web implementation using browser download
        return _exportForWeb(jsonString, fileName);
      } else {
        // Desktop/Mobile implementation
        return await _exportForDesktop(jsonString, fileName);
      }
    } catch (e) {
      print('Error exporting theme: $e');
      return false;
    }
  }

  static bool _exportForWeb(String jsonString, String fileName) {
    try {
      // Create blob and download for web
      final bytes = utf8.encode(jsonString);
      final blob = html.Blob([bytes], 'application/json');
      final url = html.Url.createObjectUrlFromBlob(blob);
      
      // Create download link and trigger download
      final anchor = html.AnchorElement(href: url)
        ..style.display = 'none'
        ..download = fileName;
      
      html.document.body?.append(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
      
      return true;
    } catch (e) {
      print('Error in web export: $e');
      return false;
    }
  }

  static Future<bool> _exportForDesktop(String jsonString, String fileName) async {
    try {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Export Theme',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: [_fileExtension],
      );

      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsString(jsonString);
        return true;
      }
      return false;
    } catch (e) {
      print('Error in desktop export: $e');
      return false;
    }
  }

  // Import theme from JSON file
  static Future<ThemeModel?> importTheme() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [_fileExtension],
        dialogTitle: 'Import Theme',
      );

      if (result != null) {
        if (kIsWeb) {
          // Web implementation
          final bytes = result.files.first.bytes;
          if (bytes != null) {
            final jsonString = utf8.decode(bytes);
            final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
            return ThemeModel.fromJson(jsonMap);
          }
        } else {
          // Desktop/Mobile implementation
          final file = File(result.files.single.path!);
          final jsonString = await file.readAsString();
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
          return ThemeModel.fromJson(jsonMap);
        }
      }
      return null;
    } catch (e) {
      print('Error importing theme: $e');
      return null;
    }
  }

  // Get built-in theme presets
  static List<ThemeModel> getThemePresets() {
    return [
      // Material Blue - Classic Material Design
      ThemeModel(
        name: 'Material Blue',
        description: 'Classic Material Design with blue color scheme',
        colorScheme: ColorSchemeModel(
          primary: 0xFF1976D2,
          onPrimary: 0xFFFFFFFF,
          primaryContainer: 0xFFBBDEFB,
          onPrimaryContainer: 0xFF0D47A1,
          secondary: 0xFF03DAC6,
          onSecondary: 0xFF000000,
          secondaryContainer: 0xFFB2DFDB,
          onSecondaryContainer: 0xFF004D40,
          tertiary: 0xFF9C27B0,
          onTertiary: 0xFFFFFFFF,
          tertiaryContainer: 0xFFE1BEE7,
          onTertiaryContainer: 0xFF4A148C,
          error: 0xFFD32F2F,
          onError: 0xFFFFFFFF,
          errorContainer: 0xFFFFCDD2,
          onErrorContainer: 0xFFB71C1C,
          background: 0xFFFAFAFA,
          onBackground: 0xFF212121,
          surface: 0xFFFFFFFF,
          onSurface: 0xFF212121,
          surfaceVariant: 0xFFF5F5F5,
          onSurfaceVariant: 0xFF424242,
          outline: 0xFF9E9E9E,
          outlineVariant: 0xFFE0E0E0,
          shadow: 0xFF000000,
          scrim: 0xFF000000,
          inverseSurface: 0xFF303030,
          onInverseSurface: 0xFFFFFFFF,
          inversePrimary: 0xFF90CAF9,
          surfaceTint: 0xFF1976D2,
        ),
        typography: TypographyModel(fontFamily: 'Roboto'),
      ),

      // Dark Professional - Modern dark theme
      ThemeModel(
        name: 'Dark Professional',
        description: 'Modern dark theme with professional styling',
        colorScheme: ColorSchemeModel(
          primary: 0xFF8AB4F8,
          onPrimary: 0xFF0A1628,
          primaryContainer: 0xFF1E3A8A,
          onPrimaryContainer: 0xFFBFDBFE,
          secondary: 0xFF94A3B8,
          onSecondary: 0xFF0F172A,
          secondaryContainer: 0xFF334155,
          onSecondaryContainer: 0xFFE2E8F0,
          tertiary: 0xFFFBBF24,
          onTertiary: 0xFF1F2937,
          tertiaryContainer: 0xFFD97706,
          onTertiaryContainer: 0xFFFEF3C7,
          error: 0xFFEF4444,
          onError: 0xFF1F2937,
          errorContainer: 0xFFDC2626,
          onErrorContainer: 0xFFFEE2E2,
          background: 0xFF0F172A,
          onBackground: 0xFFF8FAFC,
          surface: 0xFF1E293B,
          onSurface: 0xFFF1F5F9,
          surfaceVariant: 0xFF334155,
          onSurfaceVariant: 0xFFCBD5E1,
          outline: 0xFF64748B,
          outlineVariant: 0xFF475569,
          shadow: 0xFF000000,
          scrim: 0xFF000000,
          inverseSurface: 0xFFF8FAFC,
          onInverseSurface: 0xFF1E293B,
          inversePrimary: 0xFF1E40AF,
          surfaceTint: 0xFF8AB4F8,
        ),
        typography: TypographyModel(fontFamily: 'Inter'),
        isDark: true,
      ),

      // Royal Purple - Elegant purple palette
      ThemeModel(
        name: 'Royal Purple',
        description: 'Elegant purple palette with royal styling',
        colorScheme: ColorSchemeModel(
          primary: 0xFF7C3AED,
          onPrimary: 0xFFFFFFFF,
          primaryContainer: 0xFFDDD6FE,
          onPrimaryContainer: 0xFF3730A3,
          secondary: 0xFFEC4899,
          onSecondary: 0xFFFFFFFF,
          secondaryContainer: 0xFFFCE7F3,
          onSecondaryContainer: 0xFF9D174D,
          tertiary: 0xFFF59E0B,
          onTertiary: 0xFF1F2937,
          tertiaryContainer: 0xFFFEF3C7,
          onTertiaryContainer: 0xFFB45309,
          error: 0xFFDC2626,
          onError: 0xFFFFFFFF,
          errorContainer: 0xFFFEE2E2,
          onErrorContainer: 0xFF991B1B,
          background: 0xFFFAF5FF,
          onBackground: 0xFF1F1B3A,
          surface: 0xFFFFFFFF,
          onSurface: 0xFF1F1B3A,
          surfaceVariant: 0xFFF3F4F6,
          onSurfaceVariant: 0xFF4B5563,
          outline: 0xFF9CA3AF,
          outlineVariant: 0xFFE5E7EB,
          shadow: 0xFF000000,
          scrim: 0xFF000000,
          inverseSurface: 0xFF2D1B69,
          onInverseSurface: 0xFFFFFFFF,
          inversePrimary: 0xFFA78BFA,
          surfaceTint: 0xFF7C3AED,
        ),
        typography: TypographyModel(fontFamily: 'Playfair Display'),
      ),

      // Nature Green - Fresh green theme
      ThemeModel(
        name: 'Nature Green',
        description: 'Fresh green theme inspired by nature',
        colorScheme: ColorSchemeModel(
          primary: 0xFF059669,
          onPrimary: 0xFFFFFFFF,
          primaryContainer: 0xFFD1FAE5,
          onPrimaryContainer: 0xFF064E3B,
          secondary: 0xFF10B981,
          onSecondary: 0xFFFFFFFF,
          secondaryContainer: 0xFFECFDF5,
          onSecondaryContainer: 0xFF047857,
          tertiary: 0xFF0891B2,
          onTertiary: 0xFFFFFFFF,
          tertiaryContainer: 0xFFCFFAFE,
          onTertiaryContainer: 0xFF0E7490,
          error: 0xFFDC2626,
          onError: 0xFFFFFFFF,
          errorContainer: 0xFFFEE2E2,
          onErrorContainer: 0xFF991B1B,
          background: 0xFFF0FDF4,
          onBackground: 0xFF14532D,
          surface: 0xFFFFFFFF,
          onSurface: 0xFF14532D,
          surfaceVariant: 0xFFF3F4F6,
          onSurfaceVariant: 0xFF374151,
          outline: 0xFF6B7280,
          outlineVariant: 0xFFD1D5DB,
          shadow: 0xFF000000,
          scrim: 0xFF000000,
          inverseSurface: 0xFF1F2937,
          onInverseSurface: 0xFFFFFFFF,
          inversePrimary: 0xFF34D399,
          surfaceTint: 0xFF059669,
        ),
        typography: TypographyModel(fontFamily: 'Open Sans'),
      ),

      // Sunset Orange - Warm orange theme
      ThemeModel(
        name: 'Sunset Orange',
        description: 'Warm orange theme inspired by sunset colors',
        colorScheme: ColorSchemeModel(
          primary: 0xFFEA580C,
          onPrimary: 0xFFFFFFFF,
          primaryContainer: 0xFFFED7AA,
          onPrimaryContainer: 0xFF9A3412,
          secondary: 0xFFF59E0B,
          onSecondary: 0xFF1F2937,
          secondaryContainer: 0xFFFEF3C7,
          onSecondaryContainer: 0xFFB45309,
          tertiary: 0xFFDC2626,
          onTertiary: 0xFFFFFFFF,
          tertiaryContainer: 0xFFFEE2E2,
          onTertiaryContainer: 0xFF991B1B,
          error: 0xFFDC2626,
          onError: 0xFFFFFFFF,
          errorContainer: 0xFFFEE2E2,
          onErrorContainer: 0xFF991B1B,
          background: 0xFFFFFBEB,
          onBackground: 0xFF1F2937,
          surface: 0xFFFFFFFF,
          onSurface: 0xFF1F2937,
          surfaceVariant: 0xFFFEF3C7,
          onSurfaceVariant: 0xFF78716C,
          outline: 0xFFA8A29E,
          outlineVariant: 0xFFE7E5E4,
          shadow: 0xFF000000,
          scrim: 0xFF000000,
          inverseSurface: 0xFF292524,
          onInverseSurface: 0xFFFFFFFF,
          inversePrimary: 0xFFFFAB70,
          surfaceTint: 0xFFEA580C,
        ),
        typography: TypographyModel(fontFamily: 'Lato'),
      ),
    ];
  }
}
