import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinx_frontend/pages/home_page/home_page.dart';
import 'package:tinx_frontend/providers/satellite_provider.dart';
import 'package:tinx_frontend/theme/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SatelliteProvider(),
      child: MaterialApp(
        title: 'TinX',
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.dark,
        home: HomePage(),
      ),
    );
  }
}
