import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/theme_provider.dart';
import '../services/theme_service.dart';

class ThemeEditorPanel extends StatefulWidget {
  @override
  _ThemeEditorPanelState createState() => _ThemeEditorPanelState();
}

class _ThemeEditorPanelState extends State<ThemeEditorPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> popularFonts = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Poppins',
    'Inter',
    'Playfair Display',
    'Oswald',
    'Raleway',
    'Nunito',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    
    // Initialize controllers with current theme data
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _nameController.text = themeProvider.themeName;
    _descriptionController.text = themeProvider.themeDescription;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          children: [
            // Theme Info Section
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Theme Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      themeProvider.updateThemeInfo(value, _descriptionController.text);
                    },
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Theme Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                    onChanged: (value) {
                      themeProvider.updateThemeInfo(_nameController.text, value);
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _exportTheme(themeProvider),
                          icon: Icon(Icons.download),
                          label: Text('Export'),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _importTheme(themeProvider),
                          icon: Icon(Icons.upload),
                          label: Text('Import'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            // Tab Bar
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Presets'),
                Tab(text: 'Colors'),
                Tab(text: 'Typography'),
                Tab(text: 'Advanced'),
              ],
            ),
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPresetsTab(themeProvider),
                  _buildColorsTab(themeProvider),
                  _buildTypographyTab(themeProvider),
                  _buildAdvancedTab(themeProvider),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPresetsTab(ThemeProvider themeProvider) {
    final presets = ThemeService.getThemePresets();
    
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: presets.length,
      itemBuilder: (context, index) {
        final preset = presets[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(preset.colorScheme.primary),
              child: Icon(
                Icons.palette,
                color: Color(preset.colorScheme.onPrimary),
              ),
            ),
            title: Text(preset.name),
            subtitle: Text(preset.description),
            trailing: ElevatedButton(
              onPressed: () {
                themeProvider.applyThemePreset(preset);
                _nameController.text = preset.name;
                _descriptionController.text = preset.description;
              },
              child: Text('Apply'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorsTab(ThemeProvider themeProvider) {
    final colorScheme = themeProvider.isDarkMode 
        ? themeProvider.darkTheme.colorScheme 
        : themeProvider.currentTheme.colorScheme;

    final colorRoles = [
      {'name': 'Primary', 'key': 'primary', 'color': colorScheme.primary},
      {'name': 'Secondary', 'key': 'secondary', 'color': colorScheme.secondary},
      {'name': 'Tertiary', 'key': 'tertiary', 'color': colorScheme.tertiary},
      {'name': 'Surface', 'key': 'surface', 'color': colorScheme.surface},
      {'name': 'Background', 'key': 'background', 'color': colorScheme.background},
      {'name': 'Error', 'key': 'error', 'color': colorScheme.error},
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: colorRoles.length,
      itemBuilder: (context, index) {
        final colorRole = colorRoles[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorRole['color'] as Color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
            ),
            title: Text(colorRole['name'] as String),
            subtitle: Text(
              '#${(colorRole['color'] as Color).value.toRadixString(16).substring(2).toUpperCase()}',
            ),
            trailing: ElevatedButton(
              onPressed: () => _showColorPicker(
                context, 
                colorRole['color'] as Color,
                (color) => themeProvider.updateSingleColor(colorRole['key'] as String, color),
              ),
              child: Text('Edit'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypographyTab(ThemeProvider themeProvider) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text('Font Family', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: popularFonts.map((font) {
            return FilterChip(
              label: Text(font, style: GoogleFonts.getFont(font)),
              selected: themeProvider.currentTheme.textTheme.bodyMedium?.fontFamily == font,
              onSelected: (selected) {
                if (selected) {
                  themeProvider.updateTypography(font);
                }
              },
            );
          }).toList(),
        ),
        SizedBox(height: 24),
        Text('Typography Scale Preview', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 16),
        _buildTypographyPreview(themeProvider),
      ],
    );
  }

  Widget _buildTypographyPreview(ThemeProvider themeProvider) {
    final textTheme = themeProvider.currentTheme.textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextSample('Display Large', textTheme.displayLarge),
        _buildTextSample('Display Medium', textTheme.displayMedium),
        _buildTextSample('Display Small', textTheme.displaySmall),
        _buildTextSample('Headline Large', textTheme.headlineLarge),
        _buildTextSample('Headline Medium', textTheme.headlineMedium),
        _buildTextSample('Headline Small', textTheme.headlineSmall),
        _buildTextSample('Title Large', textTheme.titleLarge),
        _buildTextSample('Title Medium', textTheme.titleMedium),
        _buildTextSample('Title Small', textTheme.titleSmall),
        _buildTextSample('Body Large', textTheme.bodyLarge),
        _buildTextSample('Body Medium', textTheme.bodyMedium),
        _buildTextSample('Body Small', textTheme.bodySmall),
        _buildTextSample('Label Large', textTheme.labelLarge),
        _buildTextSample('Label Medium', textTheme.labelMedium),
        _buildTextSample('Label Small', textTheme.labelSmall),
      ],
    );
  }

  Widget _buildTextSample(String name, TextStyle? style) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 120,
            child: Text(name, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: Text('Sample Text', style: style),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedTab(ThemeProvider themeProvider) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Advanced Theme Settings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Material Design 3'),
                  SizedBox(height: 8),
                  Text(
                    'This theme uses Material Design 3 (Material You) specifications with dynamic color support.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext context, Color currentColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        Color pickerColor = currentColor;
        
        return AlertDialog(
          title: Text('Select Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                pickerColor = color;
              },
              labelTypes: const [ColorLabelType.hex, ColorLabelType.rgb],
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onColorChanged(pickerColor);
                Navigator.of(context).pop();
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  void _exportTheme(ThemeProvider themeProvider) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preparing theme export...'),
          duration: Duration(seconds: 1),
        ),
      );

      final theme = themeProvider.getCurrentThemeModel();
      final success = await ThemeService.exportTheme(theme);
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text('Theme "${theme.name}" exported successfully!'),
              ],
            ),
            backgroundColor: Colors.green[100],
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 8),
                Text('Failed to export theme. Please try again.'),
              ],
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(child: Text('Export error: ${e.toString()}')),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  void _importTheme(ThemeProvider themeProvider) async {
    try {
      final theme = await ThemeService.importTheme();
      
      if (theme != null) {
        themeProvider.applyThemePreset(theme);
        _nameController.text = theme.name;
        _descriptionController.text = theme.description;
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text('Theme "${theme.name}" imported successfully!'),
              ],
            ),
            backgroundColor: Colors.green[100],
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Text('Import cancelled or no valid theme file selected.'),
              ],
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(child: Text('Import error: ${e.toString()}')),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
  }
}
