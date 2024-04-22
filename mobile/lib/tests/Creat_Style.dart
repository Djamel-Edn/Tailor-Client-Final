import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Jackets_Model.dart';

class CreatStyle extends StatefulWidget {
  const CreatStyle({super.key});

  @override
  State<CreatStyle> createState() => _CreatStyleState();
}

int? modelSelected;
int currentpage = 0;
List<String> OutfitPath = [];

List JeansPath = ["images/photo1709600798.jpeg"];

class _CreatStyleState extends State<CreatStyle> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: DefaultTabController(
              length: 3,
              child: Scaffold(
                body: Container(
                  padding: EdgeInsets.only(right: 20),
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: 55,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    currentpage = 0;
                                  });
                                },
                                child: Text(
                                  "Sweater",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    currentpage = 1;
                                  });
                                },
                                child: Text(
                                  "Jean",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              InkWell(
                                child: Text(
                                  "s",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  setState(() {
                                    currentpage = 2;
                                  });
                                  print(OutfitPath);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      currentpage == 0
                          ? Expanded(
                              child: GridView.builder(
                                  itemCount: JacketModel.JacketsPath.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          modelSelected = index;
                                          OutfitPath.add(
                                              JacketModel.JacketsPath[index]);
                                        });
                                      },
                                      child: modelSelected == index
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Image.asset(
                                                    JacketModel
                                                        .JacketsPath[index],
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Image.asset(
                                                    JacketModel
                                                        .JacketsPath[index],
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    );
                                  }),
                            )
                          : currentpage == 1
                              ? Expanded(
                                  child: GridView.builder(
                                      itemCount: JeansPath.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                modelSelected = index;
                                                OutfitPath.add(
                                                    JeansPath[index]);
                                              });
                                            },
                                            child: Container(
                                              color: modelSelected == index
                                                  ? Colors.amber
                                                  : null,
                                              child:
                                                  Image.asset(JeansPath[index]),
                                            ));
                                      }),
                                )
                              : Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 80,
                                        child: Image.asset(
                                          OutfitPath[0],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Container(
                                        height: 70,
                                        width: 80,
                                        child: Image.asset(
                                          OutfitPath[1],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                      // GestureDetector(
                      //     onTap: () {
                      //       print("jupe");
                      //     },
                      //     child: Image.asset("images/photo1709600798.jpeg")),
                      // Image.asset("images/photo1709600798.jpeg"),
                      // Image.asset("images/photo1709600798.jpeg"),
                      // Text(OutfitPath.length == 0 ? "" : OutfitPath.first),
                    ],
                  ),
                ),
              ))),
    );
  }
}



// body: DefaultTabController(
//           length: 2,
//           child: Container(
//             child: Column(
//               children: [
//                 TabBar(tabs: [
//                   Tab(child: Text("Jeans")),
//                   Tab(child: Text("Sweater"))
//                 ]),
//                 Container(
//                     color: Colors.amber,
//                     height: MediaQuery.of(context).size.height * 0.6,
//                     child: TabBarView(children: [
//                       ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           Container(
//                             height: 100,
//                             child: Column(
//                               children: [
//                                 Text(Jeans.jeans[0].name),
//                                 Image.asset(
//                                   Jeans.jeans[0].path,
//                                   fit: BoxFit.cover,
//                                 )
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 100,
//                             child: Column(
//                               children: [
//                                 Text(Jeans.jeans[1].name),
//                                 Image.asset(
//                                   Jeans.jeans[1].path,
//                                   fit: BoxFit.cover,
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Text("ss")
//                     ]))
//               ],
//             ),
//           ),
//         ),