import 'package:flutter/material.dart';
import 'package:projetfinprepa/Pages/TailorPages/SousWidgets/DetailPageExistModel%20copy.dart';
import 'package:projetfinprepa/Pages/TailorPages/SousWidgets/DetailPageNewModel.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:projetfinprepa/Widgets/CommandItemTailor.dart';
import 'package:projetfinprepa/tests/Home_Page.dart';
import 'package:provider/provider.dart';

class MyCommandPageTailor extends StatefulWidget {
  const MyCommandPageTailor({super.key});

  @override
  State<MyCommandPageTailor> createState() => _MyCommandPageState();
}

class _MyCommandPageState extends State<MyCommandPageTailor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4DE),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF4DE),
        shadowColor: Colors.black,
        elevation: 01,
        title: Text(
          "My Command Tailor",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "Nanum_Myeongjo",
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
      ),
      body: Column(
        children: [
          Consumer<TailorsProvider>(
            builder: (context, value, child) {
              List OrderAccepted = [];
              List OrderCompleted = [];
              if (value.tailor != null) {
                for (var order in value.tailor!.orders!) {
                  if (order["status"] == "Accepted" ||
                      order["status"] == "Completed") {
                    OrderAccepted.add(order);
                  }
                  if (order["status"] == "Completed") {
                    OrderCompleted.add(order);
                  }
                }
                return Expanded(
                    child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: OrderAccepted.length + 1,
                        itemBuilder: (context, index) {
                          return OrderAccepted.length != index
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (OrderAccepted[index]["questionnaire"]
                                              .length ==
                                          0) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPageExistModel(
                                                order: OrderAccepted[index],
                                              ),
                                            ));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPageNewModel(
                                                order: OrderAccepted[index],
                                              ),
                                            ));
                                      }
                                    },
                                    child: CommandItemTailor(
                                      order: OrderAccepted[index],
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                );
                        },
                      ),
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: OrderCompleted.length,
                    //     itemBuilder: (context, index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: InkWell(
                    //           onTap: () {
                    //             if (OrderCompleted[index]["questionnaire"]
                    //                     .length ==
                    //                 0) {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         DetailPageExistModel(
                    //                       order: OrderAccepted[index],
                    //                     ),
                    //                   ));
                    //             } else {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         DetailPageNewModel(
                    //                       order: OrderCompleted[index],
                    //                     ),
                    //                   ));
                    //             }
                    //           },
                    //           child: CommandItemTailor(
                    //             order: OrderCompleted[index],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // )
                  ],
                ));
              } else {
                return Container(
                    padding: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView(
                      children: [
                        Stack(
                          children: [
                            Skelton(
                              hight: MediaQuery.of(context).size.height * 1 / 5,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                              top: 10,
                              bottom: 10,
                              left: 10,
                              child: Skelton(
                                hight: 150,
                                width:
                                    MediaQuery.of(context).size.width * 1 / 3,
                              ),
                            ),
                            Positioned(
                                top: 20,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 130,
                                  hight: 30,
                                )),
                            Positioned(
                                top: 60,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 130,
                                  hight: 30,
                                )),
                            Positioned(
                                top: 100,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 100,
                                  hight: 30,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Skelton(
                              hight: MediaQuery.of(context).size.height * 1 / 5,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                              top: 10,
                              bottom: 10,
                              left: 10,
                              child: Skelton(
                                hight: 150,
                                width:
                                    MediaQuery.of(context).size.width * 1 / 3,
                              ),
                            ),
                            Positioned(
                                top: 20,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 130,
                                  hight: 30,
                                )),
                            Positioned(
                                top: 60,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 130,
                                  hight: 30,
                                )),
                            Positioned(
                                top: 100,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 100,
                                  hight: 30,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Skelton(
                              hight: MediaQuery.of(context).size.height * 1 / 5,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                              top: 10,
                              bottom: 10,
                              left: 10,
                              child: Skelton(
                                hight: 150,
                                width:
                                    MediaQuery.of(context).size.width * 1 / 3,
                              ),
                            ),
                            Positioned(
                                top: 20,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 130,
                                  hight: 30,
                                )),
                            Positioned(
                                top: 60,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 130,
                                  hight: 30,
                                )),
                            Positioned(
                                top: 100,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 100,
                                  hight: 30,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Skelton(
                              hight: MediaQuery.of(context).size.height * 1 / 5,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                              top: 10,
                              bottom: 10,
                              left: 10,
                              child: Skelton(
                                hight: 150,
                                width:
                                    MediaQuery.of(context).size.width * 1 / 3,
                              ),
                            ),
                            Positioned(
                                top: 20,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 130,
                                  hight: 30,
                                )),
                            Positioned(
                                top: 60,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 130,
                                  hight: 30,
                                )),
                            Positioned(
                                top: 100,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 3 +
                                        20,
                                child: Skelton(
                                  width: 100,
                                  hight: 30,
                                )),
                          ],
                        ),
                      ],
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
