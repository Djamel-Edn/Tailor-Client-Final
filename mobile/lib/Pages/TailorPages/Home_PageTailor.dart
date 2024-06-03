import 'package:flutter/material.dart';
import 'package:projetfinprepa/Pages/TailorPages/SousWidgets/DetailPageExistModel%20copy.dart';
import 'package:projetfinprepa/Pages/TailorPages/SousWidgets/DetailPageNewModel.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:projetfinprepa/Widgets/CommandItemTailor.dart';
import 'package:projetfinprepa/tests/Home_Page.dart';
import 'package:provider/provider.dart';

class HomePageTailor extends StatefulWidget {
  const HomePageTailor({super.key});

  @override
  State<HomePageTailor> createState() => _MyCommandPageState();
}

class _MyCommandPageState extends State<HomePageTailor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4DE),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFFFF4DE),
      //   shadowColor: Colors.black,
      //   elevation: 01,
      //   title: Text(
      //     "My Command Tailor",
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontFamily: "Nanum_Myeongjo",
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   toolbarHeight: MediaQuery.of(context).size.height * 0.12,
      // ),
      body: Consumer<TailorsProvider>(
        builder: (context, tailor, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: tailor.tailor != null
                    ? Text(
                        "Hello ${tailor.tailor!.name}",
                        style: TextStyle(
                          fontFamily: "Nanum_Myeongjo",
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        "Hello there!",
                        style: TextStyle(
                          fontFamily: "Nanum_Myeongjo",
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Text(
                  "explore the latest collections and check your old and new orders people are counting on you!",
                  style: TextStyle(
                    fontFamily: "Nanum_Myeongjo",
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Consumer<TailorsProvider>(
                builder: (context, value, child) {
                  List OrderPanding = [];
                  if (value.tailor != null) {
                    for (var order in value.tailor!.orders!) {
                      if (order["status"] == "Pending") {
                        OrderPanding.add(order);
                      }
                    }
                    return Expanded(
                        child: ListView.builder(
                      itemCount: OrderPanding.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (OrderPanding[index]["questionnaire"].length ==
                                  0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPageExistModel(
                                        order: OrderPanding[index],
                                      ),
                                    ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPageNewModel(
                                        order: OrderPanding[index],
                                      ),
                                    ));
                              }
                            },
                            child: CommandItemTailor(
                              order: OrderPanding[index],
                            ),
                          ),
                        );
                      },
                    ));
                  } else {
                    return Expanded(
                        // padding: EdgeInsets.all(20),
                        // height: MediaQuery.of(context).size.height * 0.8,
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      child: ListView(
                        children: [
                          Stack(
                            children: [
                              Skelton(
                                hight:
                                    MediaQuery.of(context).size.height * 1 / 5,
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
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
                                      20,
                                  child: Skelton(
                                    width: 130,
                                    hight: 30,
                                  )),
                              Positioned(
                                  top: 60,
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
                                      20,
                                  child: Skelton(
                                    width: 130,
                                    hight: 30,
                                  )),
                              Positioned(
                                  top: 100,
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
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
                                hight:
                                    MediaQuery.of(context).size.height * 1 / 5,
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
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
                                      20,
                                  child: Skelton(
                                    width: 130,
                                    hight: 30,
                                  )),
                              Positioned(
                                  top: 60,
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
                                      20,
                                  child: Skelton(
                                    width: 130,
                                    hight: 30,
                                  )),
                              Positioned(
                                  top: 100,
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
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
                                hight:
                                    MediaQuery.of(context).size.height * 1 / 5,
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
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
                                      20,
                                  child: Skelton(
                                    width: 130,
                                    hight: 30,
                                  )),
                              Positioned(
                                  top: 60,
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
                                      20,
                                  child: Skelton(
                                    width: 130,
                                    hight: 30,
                                  )),
                              Positioned(
                                  top: 100,
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
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
                                hight:
                                    MediaQuery.of(context).size.height * 1 / 5,
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
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
                                      20,
                                  child: Skelton(
                                    width: 130,
                                    hight: 30,
                                  )),
                              Positioned(
                                  top: 60,
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
                                      20,
                                  child: Skelton(
                                    width: 130,
                                    hight: 30,
                                  )),
                              Positioned(
                                  top: 100,
                                  left: MediaQuery.of(context).size.width *
                                          1 /
                                          3 +
                                      20,
                                  child: Skelton(
                                    width: 100,
                                    hight: 30,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ));
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
