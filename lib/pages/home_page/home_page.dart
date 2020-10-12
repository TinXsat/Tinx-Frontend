import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget NiceRectangle({Widget child, Color color, bool glow = true}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: glow ? [BoxShadow(color: color, blurRadius: 8)] : null,
      ),
      child: child,
    );
  }

  Widget FuckingDot({Color color, double size = 8, bool glow = true}) =>
      Container(
        padding: EdgeInsets.all(size),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: glow
              ? [BoxShadow(color: color, blurRadius: 8, spreadRadius: 2)]
              : null,
        ),
      );

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
          child: NiceRectangle(
            color: theme.colorScheme.background,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Server status:',
                      style: theme.textTheme.headline4,
                    ),
                    FuckingDot(color: Colors.red),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Satellite status:', style: theme.textTheme.headline4),
                    FuckingDot(color: Colors.green),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
