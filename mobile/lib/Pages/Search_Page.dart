import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Data/category.dart';
import 'package:projetfinprepa/Providers/Models.dart';
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
  List<Model> AllDataModels = [];
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
  bool IsInitialSheet = true;

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
      Data = AllDataTailors.where((element) =>
          element.name.toUpperCase().startsWith(query.toUpperCase())).toList();

      Data2 = AllDataModels.where(
              (element) => element.speciality.startsWith(query.toUpperCase()))
          .toList();
      if ((Data.length == 0 || Data2.length == 0) && query == "") {
        EmptyResultTailors = false;
        Data = AllDataTailors;
        EmptyResultModels = false;
        Data2 = AllDataModels;
      } else if ((Data.length == 0 && Data2.length == 0) && query != "") {
        EmptyResultTailors = true;
        EmptyResultModels = true;
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
    AllDataModels =
        Provider.of<ModelsProvider>(context, listen: false).AllModel;

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
          color: Color(0xFFFCF9F6),
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
                      ResultModels = AllDataModels;
                    },
                    onEditingComplete: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        if (_FilterSlected.length == 0) {
                          ResultModels = AllDataModels;
                        } else {
                          _controller.text = _controller.text =
                              _FilterSlected[0].substring(0, 1).toUpperCase() +
                                  _FilterSlected[0].substring(1).toLowerCase();
                          _FilterSlected[0] = _controller.text;
                        }
                        Showseg = false;
                        ResultModels = AllDataModels.where(
                          (element) =>
                              element.speciality.toUpperCase() ==
                              _FilterSlected[0].toUpperCase(),
                        ).toList();
                        if (!ResultModels.isEmpty) {
                          EmptyResultModels = false;
                        }
                      });
                    },
                    onTap: () {
                      setState(() {
                        Showseg = true;
                      });
                    },
                    onChanged: (value) {
                      _ShowMatchSeg(value);
                      _ShowResult(value);

                      var tst = FilterTypes.firstWhere(
                        (element) =>
                            element.toUpperCase() == value.toUpperCase(),
                        orElse: () => "NotFound",
                      );

                      if (tst != "NotFound") {
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
                                  "Not foundk",
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
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return SizedBox(
                                                  height: 600,
                                                  width: double.infinity,
                                                  child: Column(children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.amber,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: AspectRatio(
                                                            aspectRatio: 1,
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: Image.memory(
                                                                    base64Decode(
                                                                        ResultModels[index]
                                                                            .image))),
                                                          ),
                                                        ),
                                                        Positioned(
                                                            top: 30,
                                                            right: 30,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: IconButton(
                                                                icon: Icon(Icons
                                                                    .save_outlined),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                    Text("data")
                                                  ]));
                                            },
                                          );
                                        },
                                        child: Hero(
                                            tag: "$index",
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(0xFF84643D)
                                                            .withAlpha(50))),
                                                child: Image.memory(
                                                  base64Decode(
                                                    ResultModels[index].image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )),
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
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.87),
                        itemCount: ResultTilors.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration:
                                Duration(milliseconds: 600 + (index * 100)),
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            decoration: BoxDecoration(
                                boxShadow: [],
                                border: Border.all(color: Colors.black),
                                color: Color(0xFFD9D9D9).withAlpha(60),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ResultTilors[index].profilePicture.toString() !=
                                        "../utils/pp.png"
                                    ? CircleAvatar(
                                        radius: 40,
                                        foregroundImage: MemoryImage(
                                          base64Decode(ResultTilors[index]
                                              .profilePicture
                                              .toString()
                                              .substring(23)),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 40,
                                        foregroundImage: AssetImage(
                                          "images/DefaultProfileWomen.png",
                                        ),
                                      ),
                                Text(
                                  ResultTilors[index].name,
                                  style: TextStyle(fontSize: 18),
                                ),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  itemSize: 15,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    size: 1,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                  ignoreGestures: true,
                                )
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
