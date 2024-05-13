import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:projetfinprepa/Data/ANSQST.dart';
import 'package:projetfinprepa/Pages/SelectedTailor.dart';
import 'package:projetfinprepa/Styles/DataStyles.dart';

class CustomDesignPAge extends StatefulWidget {
  String image;
  String QStOF;
  String type;
  CustomDesignPAge(
      {required this.image, required this.QStOF, required this.type});

  @override
  State<CustomDesignPAge> createState() => _CustomDesignPAgeState();
}

class _CustomDesignPAgeState extends State<CustomDesignPAge> {
  List<String> Data = ["SHort", "Regular", "long"];
  List<Map<String, dynamic>> QSTANS = [];
  Color mainColor = Colors.black;
  Color SecondColor = Colors.black;
  List<QSTANSRSELECTED> qstsansrs = [];
  var SiSrCntrl = TextEditingController();
  var AddCntrl = TextEditingController();

  @override
  void initState() {
    int? indexOfCategoty;
    switch (widget.QStOF) {
      case "Tops":
        indexOfCategoty = 0;
        break;
      case "Bottoms":
        indexOfCategoty = 1;
        break;
      case "Dresses":
        indexOfCategoty = 2;
        break;
      case "Suits":
        indexOfCategoty = 3;
        break;
      case "Outerwear":
        indexOfCategoty = 4;
        break;
      case "Sportswear":
        indexOfCategoty = 5;
        break;
      case "Accessories":
        indexOfCategoty = 6;
        break;
      default:
    }
    QSTANS = Style.styles[indexOfCategoty!].questionnaire;
    for (var i = 0;
        i < Style.styles[indexOfCategoty!].questionnaire.length;
        i++) {
      qstsansrs.add(QSTANSRSELECTED(
          ansr: "",
          qst: Style.styles[indexOfCategoty!].questionnaire[i]["qst"]));
    }

    super.initState();
  }

  @override
  void dispose() {
    AddCntrl.dispose();
    SiSrCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFFFFF4DE),
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color(0xFFFFF4DE),
          title: Text("Order Deatails"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    "Custom ${widget.type} Design",
                    style: TextStyle(
                        fontFamily: "Nanum_Myeongjo",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "Tailor the perfect ${widget.type} for you",
                    style: TextStyle(
                        fontFamily: "Nanum_Myeongjo",
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    )
                    // O3D.asset(
                    //   // src: "images/glbglbttled.glb",
                    //   // src: "images/ThreeDModels/shirtwomen.glb",
                    //   src: "images/ThreeDModels/shirtlongrouvert.glb",
                    //   // src: "mobile/images/ChaiseObj/jiiiiiittled.glb",
                    //   autoPlay: true,
                    //   autoRotate: true,
                    //   ar: false,
                    //   xrEnvironment: true,
                    //   autoRotateDelay: 1,
                    //   disableZoom: true,
                    //   disableTap: false,
                    //   disablePan: false,
                    //   environmentImage: "",
                    // ),
                    ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text(
                    "Choose Your Details",
                    style: TextStyle(
                      fontFamily: "Nanum_Myeongjo",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  children: QSTANS
                      .map((e) => buildRow(e["qst"], e["responses"]))
                      .toList(),
                ),
                SizedBox(
                  height: 6,
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildRowColors(context, "Secondory Color", SecondColor, 1),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: SecondColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                // buildRow(),
                // buildRow(),
                SizedBox(
                  height: 6,
                ),
                BuildAddition("Additional Details",
                    "Pleats, Ruffles, Embroidery, etc.", AddCntrl),
                BuildAddition("Special Instructions or Specific Requests",
                    "Add any specific requests here", SiSrCntrl),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BuildButton("Cancel", Colors.white, Colors.black),
                      BuildButton("Next", Color(0xFF84643D), Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget BuildButton(title, Color color, Color colorText) {
    return InkWell(
      onTap: () {
        qstsansrs
            .add(QSTANSRSELECTED(ansr: mainColor.toString(), qst: "maincolor"));
        qstsansrs.add(
            QSTANSRSELECTED(ansr: SecondColor.toString(), qst: "secondcolor"));
        qstsansrs.add(
            QSTANSRSELECTED(ansr: AddCntrl.text, qst: "Additional Details"));
        qstsansrs.add(QSTANSRSELECTED(ansr: SiSrCntrl.text, qst: "SiSR"));

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TailorSelected(
                image: widget.image,
                qstsansrs: qstsansrs,
              ),
            ));
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
                              Navigator.pop(context);
                            },
                            child: BuildButton(
                                "Next", Color(0xFF84643D), Colors.white),
                          ),
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

  Widget buildRow(String QSt, List<String> ANSR) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            QSt,
            style: TextStyle(
              fontFamily: "Nanum_Myeongjo",
              fontSize: 16,
            ),
          ),
        ),
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ANSR.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FilterChip(
                  checkmarkColor: Colors.black,
                  side: !qstsansrs.any(
                    (element) =>
                        element.qst == QSt && element.ansr == ANSR[index],
                  )
                      ? BorderSide.none
                      : BorderSide(),
                  selectedColor: Color(0xFFC0AF9A),
                  backgroundColor: Color(0xFFC0AF9A).withAlpha(90),
                  selected: qstsansrs.any(
                    (element) =>
                        element.qst == QSt && element.ansr == ANSR[index],
                  ),
                  label: Text(
                    ANSR[index],
                    style: TextStyle(
                      fontFamily: "Nanum_Myeongjo",
                      fontSize: 14,
                    ),
                  ),
                  onSelected: (value) {
                    setState(() {
                      for (var element in qstsansrs) {
                        if (element.qst == QSt) {
                          element.ansr = ANSR[index];
                        }
                      }
                    });
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
