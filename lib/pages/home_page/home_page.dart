import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TinX dashboard')),
      body: Center(
        child: Container(
          child: Text('Main page'),
        ),
      ),
    );
  }
}
