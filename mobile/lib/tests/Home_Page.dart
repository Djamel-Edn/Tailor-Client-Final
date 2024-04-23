import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:projetfinprepa/Data/category.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activateindex = 0;
  int indexCategory = 0;
  List<String> images = [
    "images/NorfolkJaket.jpeg",
    "images/NorfolkJaket.jpeg",
    "images/NorfolkJaket.jpeg",
    "images/NorfolkJaket.jpeg",
    "images/NorfolkJaket.jpeg",
  ];
  List<Color> colors = [];
  PaletteGenerator? paletteGenerator;
  List<int> itemselected = [0, 0, 0, 0, 0];
  void generatecolor() async {
    for (var i = 0; i < images.length; i++) {
      colors.add(Colors.white);
    }
    for (var i = 0; i < images.length; i++) {
      paletteGenerator =
          await PaletteGenerator.fromImageProvider(AssetImage(images[i]));
      if (paletteGenerator != null) {
        colors[i] = paletteGenerator!.colors.first;
      } else {
        colors.add(Colors.white);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generatecolor();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 23),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFFCF9F6),
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Color(0xFFFCF9F6),
                pinned: false,
                leadingWidth: MediaQuery.of(context).size.width * 0.4,
                leading: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "Hi,Leila",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF54361E)),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Image.asset("images/HiMain.png")
                      ],
                    )),
                actions: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 20,
                    child: Image.asset(
                      "images/Iconnotification.png",
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.height * 0.1,
                  //     width: MediaQuery.of(context).size.width * 0.15,
                  //     child: Image.asset(
                  //       "images/searchicon.png",
                  //     ),
                  //     decoration: BoxDecoration(
                  //         color: Color(0xFFD9D9D9),
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(50),
                  //             bottomLeft: Radius.circular(50))),
                  //   ),
                  // ),
                ],
              ),
              SliverAppBar(
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFFCF9F6),
                  ),
                  child: Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Explore our stunning collection and create your unique piece today! 🌟✨",
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Marcellus",
                                color: Color(0xFF7C583C)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Offers",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Marcellus",
                                  color: Color(0xFF9E7B61)),
                            ),
                            CarouselSlider.builder(
                              itemCount: 3,
                              itemBuilder: (context, index, realIndex) {
                                return Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xFFA38E7E))),
                                    child: Image.asset(
                                      "images/Group 9.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      activateindex = index;
                                    });
                                  },
                                  height:
                                      MediaQuery.of(context).size.height * 0.23,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 10),
                                  enlargeCenterPage: true),
                            ),
                            Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: activateindex,
                                count: 3,
                                effect: WormEffect(
                                    activeDotColor: Color(0xFFDBBFAA),
                                    dotColor:
                                        Color.fromARGB(255, 207, 207, 207)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                floating: false,
                toolbarHeight: MediaQuery.of(context).size.height * 0.47,
              ),
              SliverAppBar(
                shadowColor: Colors.black,
                pinned: true,
                flexibleSpace: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFFCF9F6),
                  ),
                  child: Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Container(
                          child: Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "JejuGothic",
                                color: Color(0xFF9E7B61)),
                          ),
                        ),
                      ),
                      TabBar(
                        onTap: (index) {
                          setState(() {
                            indexCategory = index;
                          });
                        },
                        isScrollable: true,
                        labelColor: Colors.white,
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        tabs: CategoryData.category.map((e) {
                          return AnimatedContainer(
                              height: 30,
                              width: 60,
                              duration: Duration(microseconds: 400),
                              decoration: BoxDecoration(
                                  color: indexCategory == e.id
                                      ? Color(0xFF9E7B61)
                                      : null,
                                  border: indexCategory == e.id
                                      ? Border.all(color: Color(0xFF9E7B61))
                                      : Border.all(color: Color(0xFF9E7B61)),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Text(
                                  e.category,
                                  textAlign: TextAlign.center,
                                ),
                              ));
                        }).toList(),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: TabBarView(children: [
                          Container(
                              child: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                flexibleSpace: Wrap(
                                  children: [Text("qq")],
                                ),
                              )
                            ],
                          )),
                          Text("qaaaaa"),
                          Text("dazzzzta"),
                          Text("dazslslta"),
                          Text("dalslslta"),
                        ]),
                      ),
                    ],
                  ),
                ),
                toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
