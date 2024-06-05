import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyinformationClient extends StatefulWidget {
  const MyinformationClient({Key? key}) : super(key: key);

  @override
  _MyinformationState createState() => _MyinformationState();
}

class _MyinformationState extends State<MyinformationClient> {
  late String fullName;
  late String gender;
  late String phoneNumber;
  late String email;

  @override
  void initState() {
    super.initState();

    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? '';
      gender = prefs.getString('gender') ?? '';
      phoneNumber = prefs.getString('phoneNumber') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProvider>(
      builder: (context, clientProvider, child) {
        return Scaffold(
          backgroundColor: Color(0xFFFCF9F6),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        "MY INFORMATION  ",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                clientProvider.client!.profilePicture == "/../utils/pp.png"
                    ? CircleAvatar(
                        radius: 80.0,
                        foregroundImage: AssetImage("images/profileimage.png"))
                    : CircleAvatar(
                        radius: 80.0,
                        foregroundImage: MemoryImage(base64Decode(
                            clientProvider.client!.profilePicture))),
                SizedBox(height: 20),
                UserInfoItem(
                    title: 'Full Name', value: clientProvider.client!.name),
                UserInfoItem(
                    title: 'Email', value: clientProvider.client!.email),
                SizedBox(height: 70),
              ],
            ),
          ),
          extendBody: true,
        );
      },
    );
  }
}

class UserInfoItem extends StatelessWidget {
  final String title;
  final String value;

  const UserInfoItem({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xFFEFE9E2),
            border: Border.all(color: Colors.brown),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
