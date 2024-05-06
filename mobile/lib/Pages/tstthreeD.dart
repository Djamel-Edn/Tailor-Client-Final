import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
              body: ListView(
        controller: pagecntrl,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Container(
                  transform: Matrix4.identity()
                    ..translate(
                        0.0,
                        pagecntrl.hasClients
                            ? (-(0 * MediaQuery.of(context).size.height) +
                                    pagecntrl.position.pixels) /
                                2
                            : 0.0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    images[0],
                    fit: BoxFit.fill,
                  ),
                ),
                Center(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 2),
                  child: ListTile(
                    title: Text(
                      "Your turn to create!",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nanum_Myeongjo"),
                    ),
                    subtitle: Text(
                      "Choose between importing an image from your gallery or creating a brand new look.",
                      style: TextStyle(
                        fontFamily: "Nanum_Myeongjo",
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Container(
                  transform: Matrix4.identity()
                    ..translate(
                        0.0,
                        pagecntrl.hasClients
                            ? (-(1 * MediaQuery.of(context).size.height) +
                                    pagecntrl.position.pixels) /
                                2
                            : 0.0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    images[1],
                    fit: BoxFit.fill,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        height: 15,
                      ),
                      Container(
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
                                    builder: (context) =>
                                        FirstCreationStylePge(),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: Text(
                              "Explore our inspiring styles",
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Nanum_Myeongjo"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          tstf(),
                        ],
                      )
                    ],
                  ),
                ),
              ],
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
