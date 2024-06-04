import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myinformation1 extends StatefulWidget {
  const Myinformation1({Key? key}) : super(key: key);

  @override
  _MyinformationState createState() => _MyinformationState();
}

class _MyinformationState extends State<Myinformation1> {
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
    return Consumer<TailorsProvider>(
      builder: (context, tailorsProvider, child) {
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
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Color.fromARGB(255, 208, 190, 172),
                  backgroundImage: tailorsProvider.tailor!.profilePicture ==
                          "../utils/pp.png"
                      ? AssetImage("images/jamel.jpg")
                      : MemoryImage(base64Decode(
                              tailorsProvider.tailor!.profilePicture!))
                          as ImageProvider,
                ),
                SizedBox(height: 20),
                UserInfoItem(
                    title: 'Full Name', value: tailorsProvider.tailor!.name!),
                UserInfoItem(title: 'Gender', value: "Female"),
                UserInfoItem(title: 'Address', value: 'Sidi Bel Abbes'),
                UserInfoItem(
                    title: 'Email', value: tailorsProvider.tailor!.email!),
                UserInfoItem(
                    title: 'Phone Number',
                    value: "+213 " + tailorsProvider.tailor!.phone!.toString()),
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
