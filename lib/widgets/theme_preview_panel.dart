import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ThemePreviewPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Live Preview',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 16),
              Text(
                'Theme: ${themeProvider.themeName}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Text(
                themeProvider.themeDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),
              
              // Color Swatches
              _buildColorSwatches(context),
              SizedBox(height: 24),
              
              // App Bar Preview
              _buildAppBarPreview(context),
              SizedBox(height: 16),
              
              // Buttons Preview
              _buildButtonsPreview(context),
              SizedBox(height: 16),
              
              // Cards Preview
              _buildCardsPreview(context),
              SizedBox(height: 16),
              
              // Form Controls Preview
              _buildFormControlsPreview(context),
              SizedBox(height: 16),
              
              // Typography Preview
              _buildTypographyPreview(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColorSwatches(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Palette',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildColorSwatch('Primary', colorScheme.primary, colorScheme.onPrimary),
            _buildColorSwatch('Secondary', colorScheme.secondary, colorScheme.onSecondary),
            _buildColorSwatch('Tertiary', colorScheme.tertiary, colorScheme.onTertiary),
            _buildColorSwatch('Surface', colorScheme.surface, colorScheme.onSurface),
            _buildColorSwatch('Background', colorScheme.background, colorScheme.onBackground),
            _buildColorSwatch('Error', colorScheme.error, colorScheme.onError),
          ],
        ),
      ],
    );
  }

  Widget _buildColorSwatch(String name, Color color, Color onColor) {
    return Container(
      width: 120,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              color: onColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(
              color: onColor.withOpacity(0.8),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'App Bar',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: AppBar(
            title: Text('Sample App Bar'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buttons',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Elevated'),
            ),
            FilledButton(
              onPressed: () {},
              child: Text('Filled'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('Outlined'),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Text'),
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              mini: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cards & Surfaces',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Title',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'This is a sample card with some content to demonstrate the surface colors.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Elevated Card',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Higher elevation card showing shadow effects.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormControlsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Form Controls',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Text Field',
            hintText: 'Enter some text',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (value) {},
            ),
            Text('Checkbox'),
            SizedBox(width: 24),
            Radio(
              value: true,
              groupValue: true,
              onChanged: (value) {},
            ),
            Text('Radio'),
            SizedBox(width: 24),
            Switch(
              value: true,
              onChanged: (value) {},
            ),
            Text('Switch'),
          ],
        ),
        SizedBox(height: 16),
        Slider(
          value: 0.5,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildTypographyPreview(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Typography Scale',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Display Large', style: textTheme.displayLarge),
            SizedBox(height: 8),
            Text('Display Medium', style: textTheme.displayMedium),
            SizedBox(height: 8),
            Text('Display Small', style: textTheme.displaySmall),
            SizedBox(height: 12),
            Text('Headline Large', style: textTheme.headlineLarge),
            SizedBox(height: 8),
            Text('Headline Medium', style: textTheme.headlineMedium),
            SizedBox(height: 8),
            Text('Headline Small', style: textTheme.headlineSmall),
            SizedBox(height: 12),
            Text('Title Large', style: textTheme.titleLarge),
            SizedBox(height: 6),
            Text('Title Medium', style: textTheme.titleMedium),
            SizedBox(height: 6),
            Text('Title Small', style: textTheme.titleSmall),
            SizedBox(height: 12),
            Text('Body Large', style: textTheme.bodyLarge),
            SizedBox(height: 4),
            Text('Body Medium', style: textTheme.bodyMedium),
            SizedBox(height: 4),
            Text('Body Small', style: textTheme.bodySmall),
            SizedBox(height: 12),
            Text('Label Large', style: textTheme.labelLarge),
            SizedBox(height: 4),
            Text('Label Medium', style: textTheme.labelMedium),
            SizedBox(height: 4),
            Text('Label Small', style: textTheme.labelSmall),
          ],
        ),
      ],
    );
  }
}
