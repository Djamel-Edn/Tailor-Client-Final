import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class DragAndDropDemo extends StatefulWidget {
  @override
  _DragAndDropDemoState createState() => _DragAndDropDemoState();
}

class _DragAndDropDemoState extends State<DragAndDropDemo> {
  List<String> images = [
    "images/pexels-pixabay-260024.jpg",
    "images/pexels-pixabay-163064.jpg",
    "images/pexels-pixabay-163036.jpg"
  ];
  PaletteGenerator? paletteGenerator;

  void generatecolor() async {
    paletteGenerator =
        await PaletteGenerator.fromImageProvider(AssetImage(images[1]));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    generatecolor();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: paletteGenerator != null
              ? paletteGenerator!.colors != null
                  ? paletteGenerator!.colors.first
                  : Colors.amber
              : Colors.amber,
          body: Center(
            child: Container(child: Image.asset(images[0])),
          ),
        ),
      ),
    );
  }
}
