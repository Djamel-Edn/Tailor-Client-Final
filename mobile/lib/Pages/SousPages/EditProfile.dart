// Define a class to represent user information
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

class UserProfile {
  String fullName;
  String gender;
  String address;
  String email;
  String phoneNumber;

  UserProfile({
    required this.fullName,
    required this.gender,
    required this.address,
    required this.email,
    required this.phoneNumber,
  });
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  var cntxdialogue;
  @override
  void initState() {
    super.initState();
    _fullNameController.text =
        Provider.of<TailorsProvider>(context, listen: false).tailor!.name!;
    _addressController.text =
        Provider.of<TailorsProvider>(context, listen: false).tailor!.city!;
    _phoneNumberController.text =
        Provider.of<TailorsProvider>(context, listen: false)
            .tailor!
            .phone!
            .toString();
    // _fullNameController.text = "dddddddd";
    // _addressController.text = "dddddddd";
    // _phoneNumberController.text = "skkkkk";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F6),
      body: Consumer<TailorsProvider>(builder: (context, tailorProv, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 73),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      " EDIT PROFILE  ",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 80.0,
                        backgroundImage: _image == null
                            ? tailorProv.tailor!.profilePicture ==
                                    "../utils/pp.png"
                                ? AssetImage("images/profileimage.png")
                                : MemoryImage(base64Decode(
                                        tailorProv.tailor!.profilePicture!))
                                    as ImageProvider
                            : FileImage(_image!) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 10.0,
                        right: 10.0,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottomSheet()),
                            );
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              UserInfoItem(
                title: 'Full Name',
                controller: _fullNameController,
              ),
              UserInfoItem(
                title: 'Address',
                controller: _addressController,
              ),
              UserInfoItem(
                title: 'Phone Number',
                controller: _phoneNumberController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (contextd) {
                      cntxdialogue = contextd;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFCF9F6),
                        ),
                      );
                    },
                  );
                  print("sssssssss");
                  // Save changes
                  // widget.userProfile.fullName = _fullNameController.text;
                  // widget.userProfile.gender = _genderController.text;
                  // widget.userProfile.address = _addressController.text;
                  // widget.userProfile.email = _emailController.text;
                  // widget.userProfile.phoneNumber = _phoneNumberController.text;
                  // You can add additional logic to save to database or API here
                  // After saving, you might want to navigate back to the profile page
                  print(_image);
                  if (_image != null) {
                    List<int> imagebytes = _image!.readAsBytesSync();
                    print("ddddddddddddddddddd");
                    await tailorProv.EditProfilTailor(
                        Provider.of<LocalDbProvider>(context, listen: false).id,
                        _fullNameController.text,
                        _addressController.text,
                        int.parse(_phoneNumberController.text),
                        base64Encode(imagebytes),
                        context);
                  } else {
                    await tailorProv.EditProfilTailor(
                        Provider.of<LocalDbProvider>(context, listen: false).id,
                        _fullNameController.text,
                        _addressController.text,
                        int.parse(_phoneNumberController.text),
                        null,
                        context);
                  }
                  Navigator.pop(cntxdialogue);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF84643D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 110),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
      extendBody: true,
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                label: const Text("Camera"),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: const Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}

class UserInfoItem extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const UserInfoItem({
    Key? key,
    required this.title,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    fillColor: const Color(0xFFEFE9E2),
                    filled: true,
                    suffixIcon: Image.asset(
                      "images/Vector.png",
                      width: 24, // Adjust the width of the image as needed
                      height: 24, // Adjust the height of the image as needed
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
