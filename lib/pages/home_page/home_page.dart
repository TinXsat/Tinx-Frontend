import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('TinX dashboard')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Poland can into space!'),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.5),
              ),
            ),
            ListTile(title: Text('Settings')),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Text('Main page'),
        ),
      ),
    );
  }
}
