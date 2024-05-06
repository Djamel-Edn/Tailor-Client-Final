import 'package:flutter/material.dart';

class CreateStylePage extends StatefulWidget {
  CreateStylePage({super.key});

  @override
  State<CreateStylePage> createState() => _CreateStylePageState();
}

class _CreateStylePageState extends State<CreateStylePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            body: Container(
          height: 300,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  child: Text("data"));
            },
          ),
        )),
      ),
    );
  }
}
