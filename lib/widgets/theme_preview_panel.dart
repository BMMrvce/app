import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ThemePreviewPanel extends StatefulWidget {
  @override
  _ThemePreviewPanelState createState() => _ThemePreviewPanelState();
}

class _ThemePreviewPanelState extends State<ThemePreviewPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Platform Previews',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Theme: ${themeProvider.themeName}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 4),
                  Text(
                    themeProvider.themeDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.android), text: 'Android'),
                Tab(icon: Icon(Icons.phone_iphone), text: 'iPhone'),
                Tab(icon: Icon(Icons.desktop_windows), text: 'Desktop'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAndroidPreview(context, themeProvider),
                  _buildIPhonePreview(context, themeProvider),
                  _buildDesktopPreview(context, themeProvider),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Android Preview - Material Design focused
  Widget _buildAndroidPreview(BuildContext context, ThemeProvider themeProvider) {
    return Center(
      child: Container(
        width: 280,
        height: 560,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            // Android Status Bar Simulation
            Container(
              height: 24,
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '9:41',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 12),
                      SizedBox(width: 2),
                      Icon(Icons.wifi, color: Colors.white, size: 12),
                      SizedBox(width: 2),
                      Icon(Icons.battery_full, color: Colors.white, size: 12),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            
            // Android App Content
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Theme(
                  data: themeProvider.currentTheme,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('Material App'),
                      actions: [
                        IconButton(icon: Icon(Icons.search), onPressed: () {}),
                        IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                      ],
                    ),
                    body: SingleChildScrollView(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCompactContent(context),
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.add),
                      mini: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // iPhone Preview - iOS focused with curved edges
  Widget _buildIPhonePreview(BuildContext context, ThemeProvider themeProvider) {
    return Center(
      child: Container(
        width: 250,
        height: 540,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.grey[800]!, width: 8),
        ),
        margin: EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Column(
            children: [
              // iPhone Notch and Status Bar
              Container(
                height: 44,
                color: themeProvider.currentTheme.colorScheme.surface,
                child: Stack(
                  children: [
                    // Notch
                    Center(
                      child: Container(
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    // Status Bar Content
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '9:41',
                              style: TextStyle(
                                color: themeProvider.currentTheme.colorScheme.onSurface,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                                SizedBox(width: 4),
                                Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.yellow, shape: BoxShape.circle)),
                                SizedBox(width: 4),
                                Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                                SizedBox(width: 8),
                                Text(
                                  '100%',
                                  style: TextStyle(
                                    color: themeProvider.currentTheme.colorScheme.onSurface,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // iPhone App Content
              Expanded(
                child: Theme(
                  data: themeProvider.currentTheme,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('iOS Style App'),
                      centerTitle: true,
                      elevation: 0,
                    ),
                    body: SingleChildScrollView(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCompactContent(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Desktop Preview - Wide layout focused
  Widget _buildDesktopPreview(BuildContext context, ThemeProvider themeProvider) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 800,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              // Desktop Title Bar
              Container(
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                    SizedBox(width: 8),
                    Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.yellow, shape: BoxShape.circle)),
                    SizedBox(width: 8),
                    Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    SizedBox(width: 16),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Desktop Application',
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ),
              
              // Desktop App Content
              Expanded(
                child: Theme(
                  data: themeProvider.currentTheme,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('Desktop Theme Preview'),
                      actions: [
                        IconButton(icon: Icon(Icons.search), onPressed: () {}),
                        IconButton(icon: Icon(Icons.settings), onPressed: () {}),
                        IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
                      ],
                    ),
                    body: Row(
                      children: [
                        // Sidebar
                        Container(
                          width: 200,
                          color: themeProvider.currentTheme.colorScheme.surfaceVariant,
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              ListTile(
                                leading: Icon(Icons.home),
                                title: Text('Home'),
                                selected: true,
                              ),
                              ListTile(
                                leading: Icon(Icons.palette),
                                title: Text('Themes'),
                              ),
                              ListTile(
                                leading: Icon(Icons.settings),
                                title: Text('Settings'),
                              ),
                            ],
                          ),
                        ),
                        // Main Content
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSharedContent(context),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Shared content used across all platforms
  Widget _buildSharedContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColorSwatches(context),
        SizedBox(height: 16),
        _buildButtonsPreview(context),
        SizedBox(height: 16),
        _buildCardsPreview(context),
        SizedBox(height: 16),
        _buildFormControlsPreview(context),
        SizedBox(height: 16),
        _buildTypographyPreview(context),
      ],
    );
  }

  // Compact content optimized for mobile previews
  Widget _buildCompactContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCompactColorSwatches(context),
        SizedBox(height: 12),
        _buildCompactButtonsPreview(context),
        SizedBox(height: 12),
        _buildCompactCardsPreview(context),
        SizedBox(height: 12),
        _buildCompactFormControlsPreview(context),
        SizedBox(height: 12),
        _buildCompactTypographyPreview(context),
      ],
    );
  }

  Widget _buildCompactColorSwatches(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Colors',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            _buildCompactColorSwatch('Primary', colorScheme.primary),
            _buildCompactColorSwatch('Secondary', colorScheme.secondary),
            _buildCompactColorSwatch('Tertiary', colorScheme.tertiary),
            _buildCompactColorSwatch('Surface', colorScheme.surface),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactColorSwatch(String name, Color color) {
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Center(
        child: Text(
          name.substring(0, 1),
          style: TextStyle(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildCompactButtonsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buttons',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Elevated'),
              ),
              SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {},
                child: Text('Outlined'),
              ),
              SizedBox(width: 8),
              TextButton(
                onPressed: () {},
                child: Text('Text'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactCardsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cards',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sample Card',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 4),
                Text(
                  'Card content preview',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactFormControlsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Controls',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Text Field',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (value) {},
            ),
            Text('Check', style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
            Switch(
              value: true,
              onChanged: (value) {},
            ),
            Text('Switch', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactTypographyPreview(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Typography',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Headline', style: textTheme.headlineSmall),
            Text('Title', style: textTheme.titleMedium),
            Text('Body text', style: textTheme.bodyMedium),
            Text('Caption', style: textTheme.bodySmall),
          ],
        ),
      ],
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
