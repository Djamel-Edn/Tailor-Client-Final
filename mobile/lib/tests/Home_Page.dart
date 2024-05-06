import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/category.dart';
import 'package:projetfinprepa/LogiquesFonctions/ModelLogique.dart';

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
            color: Color(0xFFFFF4DE),
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Color(0xFFFFF4DE),
                pinned: false,
                leadingWidth: MediaQuery.of(context).size.width * 0.4,
                leading: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "Hi,Leila",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: "Nanum_Myeongjo"),
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
                    color: Color(0xFFFFF4DE),
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
                                fontFamily: "Nanum_Myeongjo",
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                floating: false,
                toolbarHeight: MediaQuery.of(context).size.height * 0.15,
              ),
              SliverAppBar(
                shadowColor: Colors.black,
                pinned: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF4DE),
                  ),
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 6),
                        child: TabBar(
                          onTap: (index) {
                            if (indexCategory != index) {
                              setState(() {
                                indexCategory = index;
                              });
                            }
                          },
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          tabAlignment: TabAlignment.start,
                          dividerColor: Colors.transparent,
                          isScrollable: true,
                          indicatorWeight: 1,
                          labelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Colors.black,
                          labelPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          indicatorPadding: EdgeInsets.only(bottom: 5),
                          tabs: CategoryData.category.map((e) {
                            return Text(
                              e.category,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Nanum_Myeongjo",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 1.2),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
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
                                  childAspectRatio: 0.6),
                          itemCount: AllModelsByCategory[indexCategory].length,
                          itemBuilder: (context, index) {
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
                                                0.25,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFFFFDB93)
                                                    .withAlpha(80),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(0, 1))
                                          ],
                                          border: Border.all(
                                              color: Color(0xFFFFDB93)
                                                  .withAlpha(30)),
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.memory(
                                                snapshot.data!,
                                                fit: BoxFit.cover,
                                              ),
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
                                                color: Color(0xFFFFDB93)
                                                    .withAlpha(30),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(0, 1))
                                          ],
                                          border: Border.all(
                                              color: Color(0xFFFFDB93)
                                                  .withAlpha(80)),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                          color: Colors.white),
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
                                              color: Colors.black,
                                              fontFamily: "Nanum_Myeongjo"),
                                          textAlign: TextAlign.center,
                                        ),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CircleAvatar(
                                                  foregroundImage: MemoryImage(
                                                      base64Decode(
                                                          AllModelsByCategory[
                                                                      indexCategory]
                                                                  [index]
                                                              .tailor!
                                                              .profilePicture!
                                                              .substring(23)))),
                                              Text(
                                                "${AllModelsByCategory[indexCategory][index].tailor!.name}",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Nanum_Myeongjo",
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w300),
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
                                                    "${AllModelsByCategory[indexCategory][index].tailor!.rating}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "Nanum_Myeongjo"),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
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
                backgroundColor: Color(0xFFFFF4DE),
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
