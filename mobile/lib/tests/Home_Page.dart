import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/category.dart';
import 'package:projetfinprepa/LogiquesFonctions/ModelLogique.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activateindex = 0;
  int indexCategory = 0;
  bool IsLoading = true;
  List<List<Model>> AllModelsByCategory = [];
  List<Model> AllModels = [];
  List<Model> ManModels = [];
  List<Model> WomanModels = [];
  List<Model> KidModels = [];
  Future<Uint8List> DecodeIamge(image) async {
    print("in decode");
    return base64Decode(image);
  }

  Future GetMAllModels() async {
    ManModels = [];
    WomanModels = [];
    KidModels = [];
    AllModels = [];
    AllModelsByCategory = [];
    AllModels = await ModelLogique.GetAllModels();
    for (var model in AllModels) {
      model.category == CategoryData.category[2].category
          ? ManModels.add(model)
          : model.category == CategoryData.category[3].category
              ? WomanModels.add(model)
              : KidModels.add(model);
    }
    AllModelsByCategory.add(AllModels);
    AllModelsByCategory.add(AllModels);
    AllModelsByCategory.add(ManModels);
    AllModelsByCategory.add(WomanModels);
    AllModelsByCategory.add(KidModels);

    print("ffffffffffffffffff ${ManModels}");
    print("ffffffffffffffffff ${WomanModels}");
    print("ffffffffffffffffff ${KidModels}");
  }

  @override
  void initState() {
    super.initState();
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
                ],
              ),
              SliverAppBar(
                pinned: false,
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
                                    // setState(() {
                                    //   activateindex = index;
                                    // });
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TabBar(
                          onTap: (index) {
                            if (indexCategory != index) {
                              setState(() {
                                indexCategory = index;
                              });
                            }
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
                      ),
                    ],
                  ),
                ),
                toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              ),
              FutureBuilder(
                future: GetMAllModels(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? SliverGrid.builder(
                          itemCount: 4,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1,
                                  childAspectRatio: 0.82),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Column(
                                children: [
                                  Skelton(
                                    hight: 160,
                                    width: 200,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Skelton(
                                    hight: 20,
                                    width: 90,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: SkeltonCircle(),
                                      ),
                                      Expanded(
                                        child: Skelton(
                                          hight: 20,
                                          width: 90,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Skelton(
                                          hight: 20,
                                          width: 50,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1,
                                  childAspectRatio: 0.72),
                          itemCount: AllModelsByCategory[indexCategory].length,
                          itemBuilder: (context, index) {
                            print("mmmmmmmmmmmmmmmmmmmmmmm");
                            return Padding(
                              padding: const EdgeInsets.only(right: 5, left: 4),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.18,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFC7A59B),
                                              Color(0xFFD8CECB),
                                              Color(0xFFD8CECB),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: FutureBuilder(
                                          future: DecodeIamge(
                                              AllModelsByCategory[indexCategory]
                                                      [index]
                                                  .image),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Skelton(
                                                hight: 160,
                                                width: 200,
                                              );
                                            } else if (snapshot.hasError) {
                                              return Skelton(
                                                hight: 160,
                                                width: 200,
                                              );
                                            }
                                            return Image.memory(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white54,
                                                offset: Offset(0, 1),
                                                blurRadius: 0,
                                                spreadRadius: 1)
                                          ],
                                          border: Border.all(
                                              color: Color(0xFF84643D)
                                                  .withAlpha(40)),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                          color:
                                              Color(0xFFD9D9D9).withAlpha(40)),
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: ListTile(
                                        titleAlignment:
                                            ListTileTitleAlignment.center,
                                        title: Text(
                                          "${AllModelsByCategory[indexCategory][index].category}",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 16,
                                              fontFamily: "JejuGothic"),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                                foregroundImage: MemoryImage(
                                                    base64Decode(
                                                        AllModelsByCategory[
                                                                    indexCategory]
                                                                [index]
                                                            .tailor
                                                            .profilePicture
                                                            .substring(23)))),
                                            Text(
                                              "${AllModelsByCategory[indexCategory][index].tailor.name}",
                                              style: TextStyle(
                                                  fontFamily: "JejuGothic",
                                                  color: Color(0xFF54361E)),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 30,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  "${AllModelsByCategory[indexCategory][index].tailor.rating}",
                                                  style: TextStyle(
                                                      color: Color(0xFF54361E)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
              SliverAppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Skelton extends StatelessWidget {
  double hight, width;

  Skelton({
    required this.hight,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}

class SkeltonCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black.withOpacity(0.04),
    );
  }
}
