import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetfinprepa/Pages/SousPages/EditProfile%20copy.dart';
import 'package:projetfinprepa/Pages/Tailorprofile/Myinformation%20copy.dart';
import 'package:projetfinprepa/Pages/Tailorprofile/settings.dart';
import 'package:projetfinprepa/Pages/registration/MyApp.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:provider/provider.dart';

class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage({Key? key}) : super(key: key);

  @override
  _TailorProfilePageState createState() => _TailorProfilePageState();
}

class _TailorProfilePageState extends State<ClientProfilePage> {
  // final UserProfile userProfile = UserProfile(
  //   fullName: 'John Doe',
  //   gender: 'Male',
  //   address: '123 Main St, City, Country',
  //   email: 'johndoe@example.com',
  //   phoneNumber: '+1234567890',
  // );
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _currentStateButtonKey = GlobalKey();

  bool isAvailable = false;
  bool isUnavailable = false;
  bool isAway = false;
  DateTime? awayDate;

  void _showOverlay(BuildContext context) {
    final RenderBox renderBox =
        _currentStateButtonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = renderBox.size;
    final buttonPosition = renderBox.localToGlobal(Offset.zero);

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: buttonPosition.dx + buttonSize.width / 2 - 150,
        top: buttonPosition.dy - 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFDDD0B9),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Available',
                        style: TextStyle(color: Colors.green),
                      )),
                      IconButton(
                        icon: Icon(
                          Icons.circle,
                          color: isAvailable ? Colors.green : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isAvailable = !isAvailable;
                            if (isAvailable) {
                              isUnavailable = false;
                              isAway = false;
                              awayDate = null;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Unavailable',
                        style: TextStyle(color: Colors.red),
                      )),
                      IconButton(
                        icon: Icon(
                          Icons.circle,
                          color: isUnavailable ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isUnavailable = !isUnavailable;
                            if (isUnavailable) {
                              isAvailable = false;
                              isAway = false;
                              awayDate = null;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the row contents
                    children: [
                      Expanded(
                        child: Text(
                          'Away for ',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                      if (isAway && awayDate != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            '${awayDate!.toLocal().toString().split(' ')[0]}',
                          ),
                        ),
                      IconButton(
                        icon: Icon(
                          Icons.circle,
                          color: isAway ? Colors.brown : Colors.grey,
                        ),
                        onPressed: () async {
                          if (!isAway) {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                isAway = true;
                                awayDate = pickedDate;
                                isAvailable = false;
                                isUnavailable = false;
                              });
                            }
                          } else {
                            setState(() {
                              isAway = false;
                              awayDate = null;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF9F6),
      body: Consumer<ClientProvider>(
        builder: (context, clientProvider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                GestureDetector(
                  child: Center(
                    child: Stack(children: <Widget>[
                      clientProvider.client!.profilePicture ==
                              "/../utils/pp.png"
                          ? CircleAvatar(
                              radius: 80.0,
                              foregroundImage:
                                  AssetImage("images/profileimage.png"))
                          : CircleAvatar(
                              radius: 80.0,
                              foregroundImage: MemoryImage(base64Decode(
                                  clientProvider.client!.profilePicture)))
                    ]),
                  ),
                ),
                SizedBox(height: 50),
                ContainerItem(
                  leadingIcon: Icons.home,
                  title: 'My Info',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => MyinformationClient()),
                      ),
                    );
                  },
                ),
                ContainerItem(
                  leadingIcon: Icons.edit,
                  title: 'Edit Profile',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => EditProfileClient())),
                    );
                  },
                ),
                ContainerItem(
                  leadingIcon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => settings1()),
                      ),
                    );
                  },
                ),
                SizedBox(height: 70),
                ContainerItem(
                  leadingIcon: Icons.logout,
                  title: 'Log out',
                  onTap: () async {
                    await Provider.of<LocalDbProvider>(context, listen: false)
                        .LOGOUT();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyAppHia(),
                        ),
                        (route) => false);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.camera,
                color: Colors.black,
              ),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera",
                  style: TextStyle(
                    color: Colors.brown,
                  )),
            ),
            TextButton.icon(
              icon: Icon(
                Icons.image,
                color: Colors.black,
              ),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text(
                "Gallery",
                style: TextStyle(
                  color: Colors.brown,
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}

class ContainerItem extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;

  const ContainerItem({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFFEFE9E2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(leadingIcon),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
