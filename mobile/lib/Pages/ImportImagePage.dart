import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetfinprepa/Data/ANSQST.dart';
import 'package:projetfinprepa/Pages/SelectedTailor%20copy.dart';
import 'package:projetfinprepa/Pages/SousPages/DesignFashionsoftware_Page.dart';

class ImportImagePage extends StatefulWidget {
  ImportImagePage({super.key});

  @override
  State<ImportImagePage> createState() => _ImportImagePageState();
}

class _ImportImagePageState extends State<ImportImagePage> {
  var cntrlAddition = TextEditingController();
  List<QSTANSRSELECTED> qstsansrs = [];

  File? image;

  var mainColor, SecondColor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text(
            "Order Details",
            style: TextStyle(fontFamily: "Nanum_Myeongjo", fontSize: 23),
          ),
          backgroundColor: Color(0xFFFFF4DE),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        backgroundColor: Color(0xFFFFF4DE),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Custom model Design",
                  style: TextStyle(fontFamily: "Nanum_Myeongjo", fontSize: 20),
                ),
                Text(
                  "Tailor the perfect models for you",
                  style: TextStyle(
                      fontFamily: "Nanum_Myeongjo",
                      fontSize: 12,
                      color: Color(0xFF000000).withAlpha(98)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withAlpha(10)),
                        borderRadius: BorderRadius.circular(10)),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              final imagePicker = ImagePicker();
                              var pickedimage = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedimage != null) {
                                image = File(pickedimage.path);
                                setState(() {});
                              }
                            },
                            child: Image.asset("images/Import.png"))),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildRowColors(context, "Main Color", mainColor, 0),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: mainColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildRowColors(context, "Secondary Color", SecondColor, 1),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: SecondColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                BuildAddition("Additional Details",
                    "Pleats, Ruffles, Embroidery, etc.", cntrlAddition),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print("sssssssss");
                          print(mainColor);
                          print(SecondColor);
                          print(cntrlAddition.text);
                          qstsansrs.add(QSTANSRSELECTED(
                              ansr: mainColor.toString(), qst: "maincolor"));
                          qstsansrs.add(QSTANSRSELECTED(
                              ansr: SecondColor.toString(),
                              qst: "secondcolor"));
                          qstsansrs.add(QSTANSRSELECTED(
                              ansr: cntrlAddition.text,
                              qst: "Additional Details"));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TailorSelectedTwo(
                                    image: image, qstsansrs: qstsansrs),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Color(0xFF84643D),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            "Next",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Nanum_Myeongjo",
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        " or ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DesignFashinSoft(),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xFF84643D))),
                          child: Text(
                            "Try It Myself",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF84643D),
                                fontFamily: "Nanum_Myeongjo",
                                fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget BuildRowColors(context, title, color, indexcolor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: AlertDialog(
                    title: Text(
                      title,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: "Nanum_Myeongjo",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    content: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        ColorPicker(
                          pickerColor: const Color.fromARGB(255, 135, 112, 112),
                          onColorChanged: (value) {
                            setState(() {
                              if (indexcolor == 0) {
                                mainColor = value;
                              } else {
                                SecondColor = value;
                              }
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                // setState(() {});
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      fontFamily: "Nanum_Myeongjo",
                                      fontSize: 23),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF000000).withAlpha(10),
              ),
              child: Image.asset("images/IconsColor.png"),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Nanum_Myeongjo",
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget BuildButton(title, Color color, Color colorText) {
    return InkWell(
      onTap: () {
        // print("IdClient 66312abd324795932c839325");
        // print("Idtailor ${IPCONFIG.ClientId}");

        // for (var i = 0; i < qstsansrs.length; i++) {
        //   print(qstsansrs[i].qst);
        //   print(qstsansrs[i].ansr);
        // }
        // OrderLogique.AddOrderByMe(IPCONFIG.ClientId, "66312abd324795932c839325",
        //     0, [], widget.image, qstsansrs,,context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFF84643D).withOpacity(0.5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text(
            title,
            style: TextStyle(
              color: colorText,
              fontFamily: "Nanum_Myeongjo",
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget BuildAddition(title, hint, cntrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Nanum_Myeongjo",
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: cntrl,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: "Nanum_Myeongjo",
                fontSize: 16,
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFC0AF9A),
                  ),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFC0AF9A),
                  ),
                  borderRadius: BorderRadius.circular(12)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        )
      ],
    );
  }
}
