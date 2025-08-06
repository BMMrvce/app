import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'theme_model.g.dart';

@JsonSerializable()
class ThemeModel {
  final String name;
  final String description;
  final ColorSchemeModel colorScheme;
  final TypographyModel typography;
  final bool isDark;

  ThemeModel({
    required this.name,
    required this.description,
    required this.colorScheme,
    required this.typography,
    this.isDark = false,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeModelToJson(this);

  ThemeData toThemeData() {
    return ThemeData(
      colorScheme: colorScheme.toColorScheme(),
      textTheme: typography.toTextTheme(),
      useMaterial3: true,
    );
  }
}

@JsonSerializable()
class ColorSchemeModel {
  final int primary;
  final int onPrimary;
  final int primaryContainer;
  final int onPrimaryContainer;
  final int secondary;
  final int onSecondary;
  final int secondaryContainer;
  final int onSecondaryContainer;
  final int tertiary;
  final int onTertiary;
  final int tertiaryContainer;
  final int onTertiaryContainer;
  final int error;
  final int onError;
  final int errorContainer;
  final int onErrorContainer;
  final int background;
  final int onBackground;
  final int surface;
  final int onSurface;
  final int surfaceVariant;
  final int onSurfaceVariant;
  final int outline;
  final int outlineVariant;
  final int shadow;
  final int scrim;
  final int inverseSurface;
  final int onInverseSurface;
  final int inversePrimary;
  final int surfaceTint;

  ColorSchemeModel({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.surfaceTint,
  });

  factory ColorSchemeModel.fromJson(Map<String, dynamic> json) =>
      _$ColorSchemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ColorSchemeModelToJson(this);

  factory ColorSchemeModel.fromColorScheme(ColorScheme colorScheme) {
    return ColorSchemeModel(
      primary: colorScheme.primary.value,
      onPrimary: colorScheme.onPrimary.value,
      primaryContainer: colorScheme.primaryContainer.value,
      onPrimaryContainer: colorScheme.onPrimaryContainer.value,
      secondary: colorScheme.secondary.value,
      onSecondary: colorScheme.onSecondary.value,
      secondaryContainer: colorScheme.secondaryContainer.value,
      onSecondaryContainer: colorScheme.onSecondaryContainer.value,
      tertiary: colorScheme.tertiary.value,
      onTertiary: colorScheme.onTertiary.value,
      tertiaryContainer: colorScheme.tertiaryContainer.value,
      onTertiaryContainer: colorScheme.onTertiaryContainer.value,
      error: colorScheme.error.value,
      onError: colorScheme.onError.value,
      errorContainer: colorScheme.errorContainer.value,
      onErrorContainer: colorScheme.onErrorContainer.value,
      background: colorScheme.background.value,
      onBackground: colorScheme.onBackground.value,
      surface: colorScheme.surface.value,
      onSurface: colorScheme.onSurface.value,
      surfaceVariant: colorScheme.surfaceVariant.value,
      onSurfaceVariant: colorScheme.onSurfaceVariant.value,
      outline: colorScheme.outline.value,
      outlineVariant: colorScheme.outlineVariant.value,
      shadow: colorScheme.shadow.value,
      scrim: colorScheme.scrim.value,
      inverseSurface: colorScheme.inverseSurface.value,
      onInverseSurface: colorScheme.onInverseSurface.value,
      inversePrimary: colorScheme.inversePrimary.value,
      surfaceTint: colorScheme.surfaceTint.value,
    );
  }

  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Color(primary),
      onPrimary: Color(onPrimary),
      primaryContainer: Color(primaryContainer),
      onPrimaryContainer: Color(onPrimaryContainer),
      secondary: Color(secondary),
      onSecondary: Color(onSecondary),
      secondaryContainer: Color(secondaryContainer),
      onSecondaryContainer: Color(onSecondaryContainer),
      tertiary: Color(tertiary),
      onTertiary: Color(onTertiary),
      tertiaryContainer: Color(tertiaryContainer),
      onTertiaryContainer: Color(onTertiaryContainer),
      error: Color(error),
      onError: Color(onError),
      errorContainer: Color(errorContainer),
      onErrorContainer: Color(onErrorContainer),
      background: Color(background),
      onBackground: Color(onBackground),
      surface: Color(surface),
      onSurface: Color(onSurface),
      surfaceVariant: Color(surfaceVariant),
      onSurfaceVariant: Color(onSurfaceVariant),
      outline: Color(outline),
      outlineVariant: Color(outlineVariant),
      shadow: Color(shadow),
      scrim: Color(scrim),
      inverseSurface: Color(inverseSurface),
      onInverseSurface: Color(onInverseSurface),
      inversePrimary: Color(inversePrimary),
      surfaceTint: Color(surfaceTint),
    );
  }
}

@JsonSerializable()
class TypographyModel {
  final String fontFamily;
  final double displayLargeFontSize;
  final double displayMediumFontSize;
  final double displaySmallFontSize;
  final double headlineLargeFontSize;
  final double headlineMediumFontSize;
  final double headlineSmallFontSize;
  final double titleLargeFontSize;
  final double titleMediumFontSize;
  final double titleSmallFontSize;
  final double bodyLargeFontSize;
  final double bodyMediumFontSize;
  final double bodySmallFontSize;
  final double labelLargeFontSize;
  final double labelMediumFontSize;
  final double labelSmallFontSize;

  TypographyModel({
    required this.fontFamily,
    this.displayLargeFontSize = 57.0,
    this.displayMediumFontSize = 45.0,
    this.displaySmallFontSize = 36.0,
    this.headlineLargeFontSize = 32.0,
    this.headlineMediumFontSize = 28.0,
    this.headlineSmallFontSize = 24.0,
    this.titleLargeFontSize = 22.0,
    this.titleMediumFontSize = 16.0,
    this.titleSmallFontSize = 14.0,
    this.bodyLargeFontSize = 16.0,
    this.bodyMediumFontSize = 14.0,
    this.bodySmallFontSize = 12.0,
    this.labelLargeFontSize = 14.0,
    this.labelMediumFontSize = 12.0,
    this.labelSmallFontSize = 11.0,
  });

  factory TypographyModel.fromJson(Map<String, dynamic> json) =>
      _$TypographyModelFromJson(json);

  Map<String, dynamic> toJson() => _$TypographyModelToJson(this);

  TextTheme toTextTheme() {
    try {
      // Try to use Google Fonts
      return GoogleFonts.getTextTheme(fontFamily).copyWith(
        displayLarge: GoogleFonts.getFont(fontFamily, fontSize: displayLargeFontSize),
        displayMedium: GoogleFonts.getFont(fontFamily, fontSize: displayMediumFontSize),
        displaySmall: GoogleFonts.getFont(fontFamily, fontSize: displaySmallFontSize),
        headlineLarge: GoogleFonts.getFont(fontFamily, fontSize: headlineLargeFontSize),
        headlineMedium: GoogleFonts.getFont(fontFamily, fontSize: headlineMediumFontSize),
        headlineSmall: GoogleFonts.getFont(fontFamily, fontSize: headlineSmallFontSize),
        titleLarge: GoogleFonts.getFont(fontFamily, fontSize: titleLargeFontSize),
        titleMedium: GoogleFonts.getFont(fontFamily, fontSize: titleMediumFontSize),
        titleSmall: GoogleFonts.getFont(fontFamily, fontSize: titleSmallFontSize),
        bodyLarge: GoogleFonts.getFont(fontFamily, fontSize: bodyLargeFontSize),
        bodyMedium: GoogleFonts.getFont(fontFamily, fontSize: bodyMediumFontSize),
        bodySmall: GoogleFonts.getFont(fontFamily, fontSize: bodySmallFontSize),
        labelLarge: GoogleFonts.getFont(fontFamily, fontSize: labelLargeFontSize),
        labelMedium: GoogleFonts.getFont(fontFamily, fontSize: labelMediumFontSize),
        labelSmall: GoogleFonts.getFont(fontFamily, fontSize: labelSmallFontSize),
      );
    } catch (e) {
      // Fallback to regular TextStyle if Google Font fails
      return TextTheme(
        displayLarge: TextStyle(fontSize: displayLargeFontSize, fontFamily: fontFamily),
        displayMedium: TextStyle(fontSize: displayMediumFontSize, fontFamily: fontFamily),
        displaySmall: TextStyle(fontSize: displaySmallFontSize, fontFamily: fontFamily),
        headlineLarge: TextStyle(fontSize: headlineLargeFontSize, fontFamily: fontFamily),
        headlineMedium: TextStyle(fontSize: headlineMediumFontSize, fontFamily: fontFamily),
        headlineSmall: TextStyle(fontSize: headlineSmallFontSize, fontFamily: fontFamily),
        titleLarge: TextStyle(fontSize: titleLargeFontSize, fontFamily: fontFamily),
        titleMedium: TextStyle(fontSize: titleMediumFontSize, fontFamily: fontFamily),
        titleSmall: TextStyle(fontSize: titleSmallFontSize, fontFamily: fontFamily),
        bodyLarge: TextStyle(fontSize: bodyLargeFontSize, fontFamily: fontFamily),
        bodyMedium: TextStyle(fontSize: bodyMediumFontSize, fontFamily: fontFamily),
        bodySmall: TextStyle(fontSize: bodySmallFontSize, fontFamily: fontFamily),
        labelLarge: TextStyle(fontSize: labelLargeFontSize, fontFamily: fontFamily),
        labelMedium: TextStyle(fontSize: labelMediumFontSize, fontFamily: fontFamily),
        labelSmall: TextStyle(fontSize: labelSmallFontSize, fontFamily: fontFamily),
      );
    }
  }
}
