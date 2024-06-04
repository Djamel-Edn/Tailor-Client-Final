import 'package:flutter/material.dart';
import 'package:projetfinprepa/Pages/Tailorprofile/changepass.dart';
import 'package:projetfinprepa/Pages/Tailorprofile/profile.dart';

class settings1 extends StatelessWidget {
  const settings1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCF9F6),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              SizedBox(height: 100),
              Text("Settings ",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 50),
              Image.asset("images/Automation.png"),
              SizedBox(height: 50),
              ContainerItem(
                leadingIcon: Icons.home,
                title: 'Change password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => Password()),
                    ),
                  );
                },
              ),
              ContainerItem(
                leadingIcon: Icons.edit,
                title: 'Report a problem',
                onTap: () {},
              ),
              ContainerItem(
                leadingIcon: Icons.collections,
                title: 'Search for help',
                onTap: () {},
              )
            ])));
  }
}
