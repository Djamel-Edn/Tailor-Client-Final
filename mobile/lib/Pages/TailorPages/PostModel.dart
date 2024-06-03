import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetfinprepa/LogiquesFonctions/ModelLogique.dart';

class PostModelPage extends StatefulWidget {
  const PostModelPage({super.key});

  @override
  State<PostModelPage> createState() => _PostModelPageState();
}

class _PostModelPageState extends State<PostModelPage> {
  GlobalKey<FormState> keyitemname = GlobalKey<FormState>();
  GlobalKey<FormState> keydesc = GlobalKey<FormState>();
  var namecntrl = TextEditingController();
  var Pricecntrl = TextEditingController();
  var Desccntrl = TextEditingController();
  var cntxdialog;

  File? image;
  List<String> FilterTypes = [
    "Dress",
    "Jean",
    "Skirt",
    "Sweater",
    "Sleepwear",
    "Bottoms",
    "Blouse",
    "T-shirt",
    "Belt",
    "Sweat",
  ];
  List<String> CategTypes = [
    "Man",
    "Women",
    "Kid",
  ];
  String _SpecialitySelected = "";
  String _CategSelected = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFCF9F6),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              height: 300,
              child: image == null
                  ? InkWell(
                      onTap: () async {
                        if (image == null) {
                          final imagePicker = ImagePicker();
                          var pickedimage = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedimage != null) {
                            setState(() {
                              image = File(pickedimage.path);
                            });
                          }
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 120,
                              child: Image.asset("images/Upload.png")),
                          Text(
                            "Uplaod Image",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Nanum_Myeongjo",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ))
                  : InkWell(
                      onTap: () async {
                        image = null;
                        if (image == null) {
                          final imagePicker = ImagePicker();
                          var pickedimage = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedimage != null) {
                            setState(() {
                              image = File(pickedimage.path);
                            });
                          }
                        }
                      },
                      child: Image.file(
                        image!,
                        fit: BoxFit.fill,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Color(0xFFDDD0B9)),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    child: TextFormField(
                  controller: namecntrl,
                  key: keyitemname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "s";
                    } else {
                      return "ss";
                    }
                  },
                  decoration: InputDecoration(
                      label: Text("Item name"),
                      labelStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: "Nanum_Myeongjo",
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black))),
                ))),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    child: TextFormField(
                  controller: Desccntrl,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  minLines: 1,
                  maxLength: 120,
                  key: keydesc,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "s";
                    } else {
                      return "ss";
                    }
                  },
                  decoration: InputDecoration(
                      label: Text("Item Desc"),
                      labelStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: "Nanum_Myeongjo",
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black))),
                ))),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    child: TextFormField(
                  controller: Pricecntrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("Item Price"),
                      labelStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: "Nanum_Myeongjo",
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black))),
                ))),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ExpansionTile(
                  shape: BeveledRectangleBorder(),
                  title: Text(
                    "category",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Nanum_Myeongjo",
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  children: [
                    Wrap(
                      children: CategTypes.map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FilterChip(
                              label: Text(e),
                              checkmarkColor: Colors.black,
                              side: CategTypes.contains(_CategSelected)
                                  ? BorderSide.none
                                  : BorderSide(),
                              // : BorderSide(),
                              selectedColor: Color(0xFFC0AF9A),
                              backgroundColor: Color(0xFFC0AF9A).withAlpha(90),
                              selected: e == _CategSelected,
                              onSelected: (value) {
                                setState(() {
                                  _CategSelected = e;
                                });
                              },
                            ),
                          )).toList(),
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ExpansionTile(
                  shape: BeveledRectangleBorder(),
                  title: Text(
                    "Speciality",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Nanum_Myeongjo",
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  children: [
                    Wrap(
                      children: FilterTypes.map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FilterChip(
                              label: Text(e),
                              checkmarkColor: Colors.black,
                              side: FilterTypes.contains(_SpecialitySelected)
                                  ? BorderSide.none
                                  : BorderSide(),
                              // : BorderSide(),
                              selectedColor: Color(0xFFC0AF9A),
                              backgroundColor: Color(0xFFC0AF9A).withAlpha(90),
                              selected: e == _SpecialitySelected,
                              onSelected: (value) {
                                setState(() {
                                  _SpecialitySelected = e;
                                });
                                print(_SpecialitySelected);
                              },
                            ),
                          )).toList(),
                    )
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            InkWell(
              onTap: () {
                if (image != null &&
                    namecntrl.text.trim() != "" &&
                    Desccntrl.text.trim() != "" &&
                    Pricecntrl.text.trim() != "" &&
                    _CategSelected != "" &&
                    _SpecialitySelected != "") {
                  showDialog(
                    context: context,
                    builder: (contextd) {
                      cntxdialog = contextd;
                      Future.delayed(Duration(seconds: 6), () {
                        Navigator.pop(contextd);
                      });
                      return Center(
                          child: CircularProgressIndicator(
                        color: Color(0xFFFFF4DE),
                      ));
                    },
                  );
                  List<int> imagebytes = image!.readAsBytesSync();
                  ModelLogique.AddPost(
                    namecntrl.text.trim(),
                    Desccntrl.text.trim(),
                    base64Encode(imagebytes),
                    double.parse(Pricecntrl.text.trim()),
                    _CategSelected,
                    _SpecialitySelected,
                    context,
                  );
                } else {}
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF84643D),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Share",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Nanum_Myeongjo",
                      fontSize: 18),
                ),
                height: 55,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
            ),
          ],
        ),
      ),
    ));
  }
}
