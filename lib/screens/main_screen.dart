import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/theme_editor_panel.dart';
import '../widgets/theme_preview_panel.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppPainter Minimal'),
        elevation: 0,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Row(
                children: [
                  Text(themeProvider.isDarkMode ? 'Dark' : 'Light'),
                  SizedBox(width: 8),
                  Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleThemeMode();
                    },
                  ),
                  SizedBox(width: 16),
                ],
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            // Desktop layout - side by side
            return Row(
              children: [
                // Theme Editor Panel
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                    ),
                    child: ThemeEditorPanel(),
                  ),
                ),
                // Theme Preview Panel
                Expanded(
                  flex: 3,
                  child: ThemePreviewPanel(),
                ),
              ],
            );
          } else {
            // Mobile layout - tabs
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Editor'),
                      Tab(text: 'Preview'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ThemeEditorPanel(),
                        ThemePreviewPanel(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
