import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/StaticData.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Data/category.dart';
import 'package:projetfinprepa/Pages/Detail_Page.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  int currentpage = 0;
  TextEditingController _controller = TextEditingController();
  List<Tailor> AllDataTailors = [];
  List<Model> AllDataModels = StaticData().Models;
  List<String> FilterTypes = [
    "Dress",
    "Jean",
    "Skirt",
    "Sweater",
    "Sleepwear",
    "Bottoms",
    "Blouse",
    "T-shirt",
    "Belt",
    "Sweat",
  ];
  List<String> _FilterSlected = [];
  bool EmptyResultTailors = false;
  bool EmptyResultModels = false;
  bool _selectedSeg = false;
  bool startTransition = false;

  bool Showseg = false;
  List<Tailor> ResultTilors = [];
  List<Tailor> Result = [];
  List<Model> ResultModels = [];
  List<Model> Result2 = [];
  List<String> ResultMatchSeg = [];
  int indexCategory = 0;
  void _ShowResult(String query) {
    List<Tailor> Data;
    List<Model> Data2;
    if (query == "") {
      Data = AllDataTailors;
      Data2 = AllDataModels;
      EmptyResultTailors = false;
      EmptyResultModels = false;
    } else {
      print(query.toUpperCase() == AllDataTailors[0].name.toUpperCase());
      Data = AllDataTailors.where((element) =>
          element.name.toUpperCase().startsWith(query.toUpperCase())).toList();

      Data2 = AllDataModels.where(
              (element) => element.Category.startsWith(query.toUpperCase()))
          .toList();
      if ((Data.length == 0 || Data2.length == 0) && query == "") {
        EmptyResultTailors = false;
        Data = AllDataTailors;
        EmptyResultModels = false;
        Data2 = AllDataModels;
      } else if ((Data.length == 0 && Data2.length == 0) && query != "") {
        EmptyResultTailors = true;
        EmptyResultModels = true;
        print("not found");
      } else {
        EmptyResultModels = false;
        EmptyResultTailors = false;
      }
    }
    setState(() {
      ResultTilors = Data;
      ResultModels = Data2;
    });
  }

  void _ShowMatchSeg(String query) {
    ResultMatchSeg = FilterTypes.where(
        (e) => e.toUpperCase().startsWith(query.toUpperCase())).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AllDataTailors =
        Provider.of<TailorsProvider>(context, listen: false).AllTailors;
    ResultTilors = AllDataTailors;
    ResultModels = AllDataModels;
    ResultMatchSeg = FilterTypes;
  }

  Widget build(BuildContext context) {
    Result = ResultTilors;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _controller,
                    onTapOutside: (event) {
                      print("outsyde");
                    },
                    onEditingComplete: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        print(_FilterSlected.length);
                        if (_FilterSlected.length == 0) {
                          ResultModels = AllDataModels;
                        } else {
                          _controller.text = _controller.text =
                              _FilterSlected[0].substring(0, 1).toUpperCase() +
                                  _FilterSlected[0].substring(1).toLowerCase();
                        }
                        Showseg = false;
                      });
                    },
                    onTap: () {
                      print("tap");
                      setState(() {
                        Showseg = true;
                      });
                    },
                    onChanged: (value) {
                      print(value);
                      _ShowMatchSeg(value);
                      _ShowResult(value);

                      var tst = FilterTypes.firstWhere(
                        (element) =>
                            element.toUpperCase() == value.toUpperCase(),
                        orElse: () => "NotFound",
                      );
                      print(tst);
                      print(FilterTypes.contains(value.toUpperCase()));
                      if (tst != "NotFound") {
                        print("aaaaaaaaaaaaaaaaaaaaaaaaaaooo");
                        setState(() {
                          _FilterSlected.clear();
                          _FilterSlected.add(value.toUpperCase());
                        });
                      } else {
                        _FilterSlected.clear();
                      }
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF3C2F1F), width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ),
              TabBar(
                onTap: (index) {
                  setState(() {
                    indexCategory = index;
                  });
                },
                padding: EdgeInsets.all(20),
                isScrollable: true,
                labelColor: Colors.white,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabs: CategoryDataInSearch.category.map((e) {
                  return Tab(
                    child: AnimatedContainer(
                        width: MediaQuery.of(context).size.width * 0.33,
                        duration: Duration(milliseconds: 700),
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
                        )),
                  );
                }).toList(),
              ),
              Expanded(
                  child: TabBarView(children: [
                !Showseg
                    ? EmptyResultModels
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Not found",
                                  style: TextStyle(
                                      fontSize: 28, color: Color(0xFFC0AF9A)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset("images/ImjNotFound.png")
                              ],
                            ),
                          )
                        : AnimationLimiter(
                            child: GridView.custom(
                              physics: BouncingScrollPhysics(),
                              gridDelegate: SliverQuiltedGridDelegate(
                                crossAxisCount: 4,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                repeatPattern:
                                    QuiltedGridRepeatPattern.inverted,
                                pattern: [
                                  QuiltedGridTile(2, 2),
                                  QuiltedGridTile(1, 1),
                                  QuiltedGridTile(1, 1),
                                  QuiltedGridTile(1, 2),
                                ],
                              ),
                              childrenDelegate: SliverChildBuilderDelegate(
                                childCount: ResultModels.length,
                                (context, index) =>
                                    AnimationConfiguration.staggeredGrid(
                                  columnCount: 4,
                                  position: index,
                                  duration: Duration(seconds: 1),
                                  child: SlideAnimation(
                                    verticalOffset: 90,
                                    child: ScaleAnimation(
                                      delay: Duration(
                                          microseconds: 1200 + (index * 1000)),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(PageRouteBuilder(
                                            reverseTransitionDuration:
                                                Duration(milliseconds: 200),
                                            transitionDuration:
                                                Duration(milliseconds: 1200),
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return DetailPost(index);
                                            },
                                          ));
                                        },
                                        child: Hero(
                                          tag: "$index",
                                          child: Image.asset(
                                            ResultModels[index].image,
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                    : Wrap(
                        children: ResultMatchSeg.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: FilterChip(
                            label: Text("$e"),
                            selected: _FilterSlected.contains(e.toUpperCase()),
                            onSelected: (value) {
                              setState(() {
                                if (value) {
                                  _FilterSlected.clear();
                                  _FilterSlected.add(e.toUpperCase());
                                } else {
                                  _FilterSlected.removeWhere(
                                      (element) => element == e);
                                }
                                if (_FilterSlected.length == 0) {
                                  ResultModels = AllDataModels;
                                } else {
                                  _controller.text = _FilterSlected[0]
                                          .substring(0, 1)
                                          .toUpperCase() +
                                      _FilterSlected[0]
                                          .substring(1)
                                          .toLowerCase();
                                }
                              });
                            },
                          ),
                        );
                      }).toList()),
                EmptyResultTailors
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Not found",
                              style: TextStyle(
                                  fontSize: 28, color: Color(0xFFC0AF9A)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset("images/ImjNotFound.png")
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: ResultTilors.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration:
                                Duration(milliseconds: 600 + (index * 100)),
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 0.2,
                                      spreadRadius: 0.3,
                                      color: Colors.black45,
                                      offset: Offset(0, 2),
                                      blurStyle: BlurStyle.inner)
                                ],
                                color: Color.fromARGB(255, 231, 231, 231)
                                    .withOpacity(1),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ResultTilors[index].profilePicture.toString() !=
                                        "../utils/pp.png"
                                    ? CircleAvatar(
                                        radius: 30,
                                        foregroundImage: MemoryImage(
                                          base64Decode(ResultTilors[index]
                                              .profilePicture
                                              .toString()
                                              .substring(23)),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 30,
                                        foregroundImage: AssetImage(
                                          "images/DefaultProfileWomen.png",
                                        ),
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(ResultTilors[index].name),
                              ],
                            ),
                          );
                        },
                      ),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
