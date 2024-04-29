import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack Example'),
        ),
        body: Stack(
          children: <Widget>[
            // Background widget
            Center(
              child: Container(
                color: Colors.blue,
                width: 160,
                height: 270,
              ),
            ),
            // Centered text widget
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Hello, Stack!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Positioned widget
           
          ],
        ),
      ),
    );
  }
}
