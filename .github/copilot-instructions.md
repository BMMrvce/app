<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# AppPainter Minimal - Copilot Instructions

## Project Overview
This is a Flutter application for creating and customizing Material Design 3 themes. It's inspired by the AppPainter project and includes theme editing, export/import functionality, and real-time preview capabilities.

## Architecture Guidelines

### State Management
- Use Provider pattern for theme state management
- Keep state changes in ThemeProvider class
- Notify listeners when theme updates occur

### Theme System
- Follow Material Design 3 (Material You) specifications
- Support both light and dark color schemes
- Use ColorScheme.fromSeed() for automatic color generation
- Maintain proper contrast ratios for accessibility

### File Structure
- Models: Data structures for theme serialization
- Providers: State management classes
- Services: Business logic and external interactions
- Widgets: Reusable UI components
- Screens: Main application screens

### Code Style
- Follow Flutter/Dart conventions
- Use meaningful variable names
- Add proper error handling
- Include documentation for complex functions

### Dependencies
- Prefer official Flutter packages when available
- Use Google Fonts for typography
- Implement file I/O with file_picker package
- Use json_annotation for serialization

## Key Features to Maintain
1. Real-time theme preview
2. Material Design 3 compliance  
3. Export/Import functionality
4. Color picker integration
5. Typography customization
6. Responsive design
7. Dark/Light mode support
