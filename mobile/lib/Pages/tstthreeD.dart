import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetfinprepa/Pages/CreateStyle_Page.dart';
import 'package:projetfinprepa/Pages/SousPages/FirstOfCreatStyle.dart';
// import 'package:o3d/o3d.dart';

// class tstthreed extends StatefulWidget {
//   const tstthreed({super.key});

//   @override
//   State<tstthreed> createState() => _tstthreedState();
// }

// final advancecontroller = AdvancedDrawerController();
// void DrawerController() {
//   advancecontroller.showDrawer();
// }

// class _tstthreedState extends State<tstthreed> with TickerProviderStateMixin {
//   //Create controller object to control 3D model.

//   @override
//   Widget build(BuildContext context) {
//     return AdvancedDrawer(
//         disabledGestures: true,
//         controller: advancecontroller,
//         openScale: 0.8,
//         openRatio: 0.6,
//         child: Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                 icon: Icon(Icons.abc),
//                 onPressed: () {
//                   DrawerController();
//                 },
//               ),
//             ),
//             body: ListView.builder(
//               itemBuilder: (context, index) {
//                 return Container(
//                   // height: MediaQuery.of(context).size.height,
//                   // width: MediaQuery.of(context).size.width,
//                   child: Image.asset(
//                     "images/nature2.jpeg",
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//             )),
//         backdropColor: Colors.blueGrey,
//         drawer: SafeArea(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             IconButton(
//                 onPressed: () {
//                   advancecontroller.hideDrawer();
//                 },
//                 icon: Icon(
//                   Icons.close,
//                   size: 30,
//                   color: Colors.white,
//                 )),
//             Expanded(
//               child: Container(),
//             )
//           ],
//         )));
//   }
// }
// Center(
//               child: Container(
//                   child: //The 3D viewer widget
//                       Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 400,
//                 child: O3D.asset(
//                   src: "images/glbglbttled.glb",
//                   autoPlay: true,
//                   autoRotate: true,
//                   ar: true,
//                   xrEnvironment: true,
//                   autoRotateDelay: 1,
//                   disableZoom: true,
//                   environmentImage: "",
//                 ),

//                 // child: WebView(
//                 //   initialUrl:
//                 //       "https://app.vectary.com/p/3YQlapkqjcKZs9wGxKDn14",
//                 //   javascriptMode: JavascriptMode.unrestricted,
//                 // )
//               )
//             ],
//           ))),

class parx extends StatefulWidget {
  @override
  State<parx> createState() => _MyAppState();
}

class _MyAppState extends State<parx> {
  late ScrollController pagecntrl;
  File? image;
  final imagePicker = ImagePicker();
  late PageController pageviewcntrl;
  double pageofs = 0;
  void initState() {
    pagecntrl = ScrollController();
    pageviewcntrl = PageController(viewportFraction: 0.7);
    pageviewcntrl.addListener(() {
      setState(() {
        pageofs = pageviewcntrl.page!;
      });
    });
    pagecntrl.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  List<String> images = ["images/BackVF.png", "images/NewBackground.png"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              backgroundColor: Color(0xFFFFF4DE),
              body: ListView(
                controller: pagecntrl,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(120)),
                          child: Image.asset(
                            "images/im 2 (1).png",
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                          )),
                      Positioned(
                        bottom: 30,
                        // right: MediaQuery.of(context).size.width * 0.19,
                        child: Text(
                          "Your turn to create!",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "Nanum_Myeongjo",
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Text(
                      "Choose between importing an image from your gallery or creating a brand new look.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Nanum_Myeongjo",
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      File? image;
                      final imagePicker = ImagePicker();
                      var pickedimage = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (pickedimage != null) {
                        image = File(pickedimage.path);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xFF84643D))),
                      height: 50,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Import Image",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF84643D),
                                fontFamily: "Nanum_Myeongjo",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF84643D),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFF84643D))),
                    height: 50,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => FirstCreationStylePge(),
                          //     ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateStylePage(),
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Create New Style",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Nanum_Myeongjo",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF84643D),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFF84643D))),
                    height: 50,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FirstCreationStylePge(),
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Create New Style",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Nanum_Myeongjo",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                // itemBuilder: (context, index) {
                //   return
                // },
              ))),
    );
  }
}

tstf() {
  List<String> images = [
    "images/dress1.jpg",
    "images/dress2.jpg",
  ];

  return Container(
    margin: EdgeInsets.only(top: 20),
    height: 360,
    width: double.infinity,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Center(
          child: Container(
            height: 350,
            width: 250,
            padding: EdgeInsets.only(right: 14),
            child: Stack(children: [
              Image.asset(
                images[index],
                fit: BoxFit.cover,
                height: 350,
                width: 250,
              )
            ]),
          ),
        );
      },
    ),
  );
}
