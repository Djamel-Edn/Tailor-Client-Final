import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetfinprepa/Pages/FirstPage.dart';
import 'package:projetfinprepa/Providers/Page_current.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF9E7B61),
      systemNavigationBarColor: Color(0xFF9E7B61)));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PageCurrent(),
      ),
      ChangeNotifierProvider(
        create: (context) => TailorsProvider(),
      )
    ],
    child: const FirstPage(),
  ));
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int activateindex = 0;
//   int activateindextab = 0;
//   PaletteGenerator? paletteGenerator;

//   List<int> itemselected = [0, 0, 0, 0, 0];
//   void generatecolor(image) async {
//     paletteGenerator =
//         await PaletteGenerator.fromImageProvider(AssetImage(image));
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SafeArea(
//           child: DefaultTabController(
//         length: 6,
//         child: Scaffold(
//           body: SingleChildScrollView(
//             child: Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.fill,
//                       image: AssetImage(
//                         "images/Background.png",
//                       ))),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.01,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: MediaQuery.of(context).size.width * 0.03),
//                       child: ListTile(
//                         title: Text(
//                           "Location",
//                           style: TextStyle(
//                               color: Color(0xF09E7B61),
//                               fontFamily: "JejuGothic"),
//                         ),
//                         subtitle: Row(
//                           children: [
//                             FaIcon(
//                               FontAwesomeIcons.locationDot,
//                               color: Color(0xFF9E7B61),
//                               size: 20,
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               "Medea, ALGERIA",
//                               style: TextStyle(fontFamily: "JejuGothic"),
//                             ),
//                           ],
//                         ),
//                         trailing: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: Color(0xFFFFFFFF),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Image.asset("images/notificationIcon.png"),
//                             // color: Color(0xFF9E7B61),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: MediaQuery.of(context).size.width * 0.07),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.6,
//                         child: Text(
//                           "Realise the one you prefer.",
//                           style:
//                               TextStyle(fontSize: 30, fontFamily: "Marcellus"),
//                         ),
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         CarouselSlider.builder(
//                           itemCount: 3,
//                           itemBuilder: (context, index, realIndex) {
//                             return Padding(
//                               padding: const EdgeInsets.all(13.0),
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border:
//                                         Border.all(color: Color(0xFFA38E7E))),
//                                 child: Image.asset(
//                                   "images/projet_pub.png",
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             );
//                           },
//                           options: CarouselOptions(
//                               onPageChanged: (index, reason) {
//                                 setState(() {
//                                   activateindex = index;
//                                 });
//                               },
//                               height: 200,
//                               autoPlay: true,
//                               autoPlayInterval: Duration(seconds: 10),
//                               enlargeCenterPage: true),
//                         ),
//                         AnimatedSmoothIndicator(
//                           activeIndex: activateindex,
//                           count: 3,
//                           effect: WormEffect(
//                               activeDotColor: Color(0xFFDBBFAA),
//                               dotColor: Color.fromARGB(255, 207, 207, 207)),
//                         )
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: MediaQuery.of(context).size.width * 0.07),
//                       child: Container(
//                         child: Text(
//                           "Category",
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontFamily: "JejuGothic",
//                               color: Color(0xFF9E7B61)),
//                         ),
//                       ),
//                     ),
//                     TabBar(
//                       onTap: (index) {
//                         setState(() {
//                           activateindextab = index;
//                         });
//                       },
//                       isScrollable: true,
//                       tabAlignment: TabAlignment.start,
//                       dividerColor: Colors.transparent,
//                       indicatorColor: Colors.transparent,
//                       tabs: [
//                         Tab(
//                           height: 100,
//                           child: CircleAvatar(
//                             radius: 30,
//                             child: Image.asset(
//                               "images/projet_pub.png",
//                               color:
//                                   activateindextab == 0 ? Colors.white : null,
//                             ),
//                             backgroundColor: activateindextab == 0
//                                 ? Color(0xFF9E7B61)
//                                 : Color(0xFFD9D9D9),
//                           ),
//                         ),
//                         Tab(
//                           height: 100,
//                           child: CircleAvatar(
//                             child: Image.asset(
//                               "images/projet_pub.png",
//                               color:
//                                   activateindextab == 1 ? Colors.white : null,
//                             ),
//                             backgroundColor: activateindextab == 1
//                                 ? Color(0xFF9E7B61)
//                                 : Color(0xFFD9D9D9),
//                             radius: 30,
//                           ),
//                         ),
//                         Tab(
//                           height: 100,
//                           child: CircleAvatar(
//                             radius: 30,
//                             child: Image.asset(
//                               "images/projet_pub.png",
//                               color:
//                                   activateindextab == 2 ? Colors.white : null,
//                             ),
//                             backgroundColor: activateindextab == 2
//                                 ? Color(0xFF9E7B61)
//                                 : Color(0xFFD9D9D9),
//                           ),
//                         ),
//                         Tab(
//                           height: 100,
//                           child: CircleAvatar(
//                             radius: 30,
//                             child: Image.asset(
//                               "images/projet_pub.png",
//                             ),
//                             backgroundColor: Color(0xFFD9D9D9),
//                           ),
//                         ),
//                         Tab(
//                           height: 100,
//                           child: CircleAvatar(
//                             radius: 30,
//                             child: Image.asset(
//                               "images/projet_pub.png",
//                             ),
//                             backgroundColor: Color(0xFFD9D9D9),
//                           ),
//                         ),
//                         Tab(
//                           height: 100,
//                           child: CircleAvatar(
//                             radius: 30,
//                             child: Image.asset(
//                               "images/projet_pub.png",
//                             ),
//                             backgroundColor: Color(0xFFD9D9D9),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.07,
//                       child: TabBarView(
//                         children: [
//                           ListView.builder(
//                             itemCount: CategoryData.category.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       itemselected[0] = index;
//                                     });
//                                   },
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 400),
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         color: itemselected[0] == index
//                                             ? Color(0xFF9E7B61)
//                                             : null,
//                                         border: itemselected[0] == index
//                                             ? Border.all(
//                                                 color: Color(0xFF9E7B61))
//                                             : Border.all(
//                                                 color: Color(0xFF9E7B61)),
//                                         borderRadius:
//                                             BorderRadius.circular(50)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         CategoryData.categoryMan[index],
//                                         style: itemselected[0] == index
//                                             ? CategoryData.styleCategoryselected
//                                             : CategoryData
//                                                 .styleCategoryunselected,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           ListView.builder(
//                             itemCount: CategoryData.category.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       itemselected[1] = index;
//                                     });
//                                   },
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 400),
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         color: itemselected[1] == index
//                                             ? Color(0xFF9E7B61)
//                                             : null,
//                                         border: itemselected[1] == index
//                                             ? Border.all(
//                                                 color: Color(0xFF9E7B61))
//                                             : Border.all(
//                                                 color: Color(0xFF9E7B61)),
//                                         borderRadius:
//                                             BorderRadius.circular(50)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         CategoryData.categorywoman[index],
//                                         style: itemselected[1] == index
//                                             ? CategoryData.styleCategoryselected
//                                             : CategoryData
//                                                 .styleCategoryunselected,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           ListView.builder(
//                             itemCount: CategoryData.category.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       itemselected[2] = index;
//                                     });
//                                   },
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 400),
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         color: itemselected[2] == index
//                                             ? Color(0xFF9E7B61)
//                                             : null,
//                                         border: itemselected[2] == index
//                                             ? Border.all(
//                                                 color: Color(0xFF9E7B61))
//                                             : Border.all(
//                                                 color: Color(0xFF9E7B61)),
//                                         borderRadius:
//                                             BorderRadius.circular(50)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         CategoryData.categoryMan[index],
//                                         style: itemselected[2] == index
//                                             ? CategoryData.styleCategoryselected
//                                             : CategoryData
//                                                 .styleCategoryunselected,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           ListView.builder(
//                             itemCount: CategoryData.category.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.black),
//                                       borderRadius: BorderRadius.circular(50)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       CategoryData.categoryMan[index],
//                                       style: CategoryData.styleCategoryselected,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           ListView.builder(
//                             itemCount: CategoryData.category.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.black),
//                                       borderRadius: BorderRadius.circular(50)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       CategoryData.categoryMan[index],
//                                       style: CategoryData.styleCategoryselected,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           ListView.builder(
//                             itemCount: CategoryData.category.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.black),
//                                       borderRadius: BorderRadius.circular(50)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       CategoryData.category[index],
//                                       style: CategoryData.styleCategoryselected,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                         height: MediaQuery.of(context).size.height * 0.4,
//                         child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           itemCount: 3,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 decoration: BoxDecoration(),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.6,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.18,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Color(0xFFC7A59B),
//                                               Color(0xFFD8CECB),
//                                               Color(0xFFD8CECB),
//                                             ],
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter,
//                                           ),
//                                         ),
//                                         child: null),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.6,
//                                       child: ListTile(
//                                         title: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               "White suit ",
//                                               style: TextStyle(
//                                                   decoration:
//                                                       TextDecoration.underline,
//                                                   fontSize: 16,
//                                                   fontFamily: "JejuGothic"),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.star,
//                                                   size: 30,
//                                                   color: Colors.yellow,
//                                                 ),
//                                                 Text(
//                                                   "4,7",
//                                                   style: TextStyle(
//                                                       color: Color(0xFF54361E)),
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                         subtitle: Row(
//                                           children: [
//                                             CircleAvatar(
//                                               child: Icon(Icons.person),
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text(
//                                               "MARIA Tayl",
//                                               style: TextStyle(
//                                                   fontFamily: "JejuGothic",
//                                                   color: Color(0xFF54361E)),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }
