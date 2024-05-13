import 'package:flutter/material.dart';
import 'package:projetfinprepa/Pages/SousPages/DesignFashionsoftware_Page.dart';

class FirstCreationStylePge extends StatelessWidget {
  const FirstCreationStylePge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFFFFF4DE),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                    textAlign: TextAlign.center,
                    "Before you start choose the category and type of garment that resonate with you."),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DesignFashinSoft(),
                        ));
                  },
                  child: Text("design ur model")),
              SizedBox(
                height: 30,
              ),
              Text("upload model exist"),
            ],
          ),
        ),
      )),
    );
  }
}
