import 'package:flutter/material.dart';

class DetailPost extends StatelessWidget {
  int tag;
  DetailPost(this.tag);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                      tag: "$tag",
                      child: Container(child: Text("lllllllllll"))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
