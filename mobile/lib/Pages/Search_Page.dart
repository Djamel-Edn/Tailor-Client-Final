import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Data/category.dart';
import 'package:projetfinprepa/LogiquesFonctions/ReviweLogique.dart';
import 'package:projetfinprepa/Pages/ProfiPage.dart';
import 'package:projetfinprepa/Providers/CollecionProv.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
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
  List<Model> SavedData = [];

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
  bool _nearest = false;

  bool Showseg = false;
  List<Tailor> ResultTilors = [];
  List<Tailor> ResultTilorsNearest = [];

  List<Tailor> Result = [];
  List<Model> ResultModels = [];
  List<Model> ResultModelsWithFilter = [];

  List<Model> Result2 = [];
  List<String> ResultMatchSeg = [];
  int indexCategory = 0;

  void _ShowResult(String query) {
    List<Tailor> Data;
    List<Model> Data2;
    if (!_nearest) {
      if (query == "") {
        Data = AllDataTailors;
        Data2 = AllDataModels;
        EmptyResultTailors = false;
        EmptyResultModels = false;
      } else {
        Data = AllDataTailors.where((element) =>
                element.name!.toUpperCase().startsWith(query.toUpperCase()))
            .toList();

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
    } else {
      if (query == "") {
        Data = AllDataTailors;
        Data2 = AllDataModels;
        EmptyResultTailors = false;
        EmptyResultModels = false;
      } else {
        Data = AllDataTailors.where((element) =>
                element.name!.toUpperCase().startsWith(query.toUpperCase()))
            .toList();

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
        ResultTilorsNearest = Data;
        ResultModels = Data2;
      });
    }
  }

  void _ShowMatchSeg(String query) {
    ResultMatchSeg = FilterTypes.where(
        (e) => e.toUpperCase().startsWith(query.toUpperCase())).toList();
    setState(() {});
  }

  double CalculRating(Tailor tailor) {
    double totalrating = 0.0;

    for (var e in tailor.reviews!) {
      totalrating += double.parse(e["rating"].toString());
    }
    if (tailor.reviews!.isNotEmpty) {
      totalrating = totalrating / tailor.reviews!.length;
    } else {
      totalrating = 0;
    }
    return totalrating;
  }

  @override
  void initState() {
    AllDataTailors =
        Provider.of<TailorsProvider>(context, listen: false).AllTailors;
    AllDataModels =
        Provider.of<ModelsProvider>(context, listen: false).AllModel;

    ResultTilors = AllDataTailors;
    ResultModels = AllDataModels;
    ResultMatchSeg = FilterTypes;
    super.initState();
  }

  Widget build(BuildContext context) {
    Result = ResultTilors;
    return DefaultTabController(
      length: 2,
      child: Scaffold(body: Consumer<CollectionProvider>(
        builder: (context, collecFavs, child) {
          return Container(
            color: Color(0xFFFFF4DE),
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
                            _controller.text = _controller
                                .text = _FilterSlected[0]
                                    .substring(0, 1)
                                    .toUpperCase() +
                                _FilterSlected[0].substring(1).toLowerCase();
                            _FilterSlected[0] = _controller.text;
                          }
                          Showseg = false;

                          ResultModels = AllDataModels.where(
                            (element) =>
                                element.speciality.toUpperCase() ==
                                _FilterSlected[0].toUpperCase(),
                          ).toList();
                          ResultModelsWithFilter = ResultModels;
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
                              borderSide: BorderSide(
                                  color: Color(0xFF3C2F1F), width: 1),
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
                  unselectedLabelColor: Color(0xFF84643D),
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
                                  ? Color(0xFF84643D)
                                  : null,
                              border: indexCategory == e.id
                                  ? Border.all(color: Color(0xFF84643D))
                                  : Border.all(color: Color(0xFF84643D)),
                              borderRadius: BorderRadius.circular(8)),
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
                                            microseconds:
                                                1200 + (index * 1000)),
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Color(0xFFFFF4DE),
                                              isDismissible: true,
                                              context: context,
                                              builder: (context) {
                                                return StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return Column(children: [
                                                      Expanded(
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .transparent,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              child:
                                                                  AspectRatio(
                                                                aspectRatio: 1,
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    child: ResultModelsWithFilter.length != 0
                                                                        ? Image.memory(
                                                                            base64Decode(ResultModelsWithFilter[index].image),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : Image.memory(
                                                                            base64Decode(ResultModels[index].image),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )),
                                                              ),
                                                            ),
                                                            Positioned(
                                                                top: 30,
                                                                right: 20,
                                                                child: InkWell(
                                                                  overlayColor:
                                                                      MaterialStatePropertyAll(
                                                                          Colors
                                                                              .transparent),
                                                                  onTap:
                                                                      () async {
                                                                    ////////
                                                                    setState(
                                                                        () {});
                                                                    print(
                                                                        "save post");
                                                                    if (ResultModelsWithFilter
                                                                            .length !=
                                                                        0) {
                                                                      await RevLogique.AddLikePost(
                                                                          Provider.of<LocalDbProvider>(context, listen: false)
                                                                              .id,
                                                                          ResultModelsWithFilter[index]
                                                                              .id,
                                                                          context);
                                                                      collecFavs
                                                                          .addOrdeletLike(
                                                                              ResultModelsWithFilter[index].id);
                                                                    } else {
                                                                      await RevLogique.AddLikePost(
                                                                          Provider.of<LocalDbProvider>(context, listen: false)
                                                                              .id,
                                                                          ResultModels[index]
                                                                              .id,
                                                                          context);
                                                                      collecFavs
                                                                          .addOrdeletLike(
                                                                              ResultModels[index].id);
                                                                    }
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Container(
                                                                      height: 40,
                                                                      padding: EdgeInsets.all(7),
                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xFFFCF9F6)),
                                                                      child: ResultModelsWithFilter.length == 0
                                                                          ? collecFavs.likes.contains(ResultModels[index].id)
                                                                              ? Image.asset(
                                                                                  "images/enregistrerinstagram (1).png",
                                                                                )
                                                                              : Image.asset(
                                                                                  "images/enregistrerinstagram.png",
                                                                                )
                                                                          : collecFavs.likes.contains(ResultModelsWithFilter[index].id)
                                                                              ? Image.asset(
                                                                                  "images/enregistrerinstagram (1).png",
                                                                                )
                                                                              : Image.asset(
                                                                                  "images/enregistrerinstagram.png",
                                                                                )),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20,
                                                                vertical: 8),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xFF84643D))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ProfilPage(
                                                                            model:
                                                                                null,
                                                                            tailor:
                                                                                AllDataModels[index].tailor!,
                                                                            IsFoRead:
                                                                                true,
                                                                            IsFoOrder:
                                                                                false,
                                                                          ),
                                                                        ));
                                                                  },
                                                                  child: AllDataModels[index]
                                                                              .tailor!
                                                                              .profilePicture !=
                                                                          "../utils/pp.png"
                                                                      ? CircleAvatar(
                                                                          foregroundImage: MemoryImage(base64Decode(AllDataModels[index]
                                                                              .tailor!
                                                                              .profilePicture!)))
                                                                      : Expanded(
                                                                          child:
                                                                              CircleAvatar(foregroundImage: AssetImage("images/profileimage.png")),
                                                                        ),
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => ProfilPage(
                                                                                model: null,
                                                                                tailor: AllDataModels[index].tailor!,
                                                                                IsFoRead: true,
                                                                                IsFoOrder: false,
                                                                              ),
                                                                            ));
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        AllDataModels[index]
                                                                            .tailor!
                                                                            .name!,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              "Nanum_Myeongjo",
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    RatingBar
                                                                        .builder(
                                                                      initialRating:
                                                                          CalculRating(
                                                                              AllDataModels[index].tailor!),
                                                                      itemSize:
                                                                          15,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      allowHalfRating:
                                                                          true,
                                                                      itemCount:
                                                                          5,
                                                                      itemBuilder:
                                                                          (context, _) =>
                                                                              const Icon(
                                                                        Icons
                                                                            .star,
                                                                        size: 1,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                      onRatingUpdate:
                                                                          (rating) {},
                                                                      ignoreGestures:
                                                                          true,
                                                                    )
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                        SizedBox()),
                                                                Row(
                                                                  children: [
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await RevLogique.AddFavTailor(
                                                                              Provider.of<LocalDbProvider>(context, listen: false).id,
                                                                              AllDataModels[index].tailor!.id,
                                                                              context);
                                                                          collecFavs.addOrdeletFav(AllDataModels[index]
                                                                              .tailor!
                                                                              .id);
                                                                          setState(
                                                                              () {});

                                                                          // SavedTailroFav.add(value)
                                                                        },
                                                                        icon: collecFavs.favs.contains(AllDataModels[index].tailor!.id)
                                                                            ? Icon(
                                                                                Icons.favorite,
                                                                                color: Colors.red,
                                                                              )
                                                                            : Icon(
                                                                                Icons.favorite_border,
                                                                              )),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20,
                                                                vertical: 15),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Model model;
                                                            if (ResultModelsWithFilter
                                                                    .length ==
                                                                0) {
                                                              model =
                                                                  ResultModels[
                                                                      index];
                                                            } else {
                                                              model =
                                                                  ResultModelsWithFilter[
                                                                      index];
                                                            }
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ProfilPage(
                                                                    model:
                                                                        model,
                                                                    tailor: AllDataModels[
                                                                            index]
                                                                        .tailor!,
                                                                    IsFoRead:
                                                                        false,
                                                                    IsFoOrder:
                                                                        true,
                                                                  ),
                                                                ));
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 60,
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                border: Border.all(
                                                                    color: Color(
                                                                        0xFF84643D)),
                                                                color: Color(
                                                                    0xFF84643D)),
                                                            child: Text(
                                                              "Order Now",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Nanum_Myeongjo",
                                                                  fontSize: 21,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ]);
                                                  },
                                                );
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
                                                          color: Color(
                                                                  0xFF84643D)
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
                              backgroundColor: Color(0xFFC0AF9A).withAlpha(50),
                              label: Text("$e"),
                              side: BorderSide.none,
                              selectedColor: Color(0xFFC0AF9A).withAlpha(50),
                              selected:
                                  _FilterSlected.contains(e.toUpperCase()),
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
                      : Column(
                          children: [
                            CheckboxListTile(
                              shape: CircleBorder(),
                              side: BorderSide(color: Colors.black),
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                              title: Row(
                                children: [
                                  Container(
                                      height: 21,
                                      child: Image.asset("images/adress.png")),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Nearest",
                                    style: TextStyle(
                                      fontFamily: "Nanum_Myeongjo",
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              value: _nearest,
                              onChanged: (value) {
                                setState(() {
                                  _nearest = value!;
                                  if (value) {
                                    ResultTilorsNearest = ResultTilors.where(
                                            (element) =>
                                                element.city == "sidi belabbes")
                                        .toList();
                                    print(ResultTilors[1].city);
                                  }
                                });
                              },
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Expanded(
                              child: !_nearest
                                  ? GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.87),
                                      itemCount: ResultTilors.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            print(ResultTilors[index]);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilPage(
                                                          model: null,
                                                          tailor: ResultTilors[
                                                              index],
                                                          IsFoRead: true,
                                                          IsFoOrder: false),
                                                ));
                                          },
                                          child: AnimatedContainer(
                                            duration: Duration(
                                                milliseconds:
                                                    600 + (index * 100)),
                                            padding: EdgeInsets.all(20),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 12),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                color: Color(0xFFD9D9D9)
                                                    .withAlpha(60),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ResultTilors[index]
                                                            .profilePicture
                                                            .toString() !=
                                                        "../utils/pp.png"
                                                    ? CircleAvatar(
                                                        radius: 40,
                                                        foregroundImage:
                                                            MemoryImage(
                                                          base64Decode(
                                                              ResultTilors[
                                                                      index]
                                                                  .profilePicture
                                                                  .toString()
                                                                  .substring(
                                                                      23)),
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 40,
                                                        foregroundImage:
                                                            AssetImage(
                                                          "images/DefaultProfileWomen.png",
                                                        ),
                                                      ),
                                                Text(
                                                  ResultTilors[index].name!,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                RatingBar.builder(
                                                  initialRating: CalculRating(
                                                      ResultTilors[index]),
                                                  minRating: 1,
                                                  itemSize: 15,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    size: 1,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {},
                                                  ignoreGestures: true,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.87),
                                      itemCount: ResultTilorsNearest.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            print(ResultTilors.length);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilPage(
                                                          model: null,
                                                          tailor:
                                                              ResultTilorsNearest[
                                                                  index],
                                                          IsFoRead: true,
                                                          IsFoOrder: false),
                                                ));
                                          },
                                          child: AnimatedContainer(
                                            duration: Duration(
                                                milliseconds:
                                                    600 + (index * 100)),
                                            padding: EdgeInsets.all(20),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 12),
                                            decoration: BoxDecoration(
                                                boxShadow: [],
                                                border: Border.all(
                                                    color: Colors.black),
                                                color: Color(0xFFD9D9D9)
                                                    .withAlpha(60),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ResultTilorsNearest[index]
                                                            .profilePicture
                                                            .toString() !=
                                                        "../utils/pp.png"
                                                    ? CircleAvatar(
                                                        radius: 40,
                                                        foregroundImage:
                                                            MemoryImage(
                                                          base64Decode(
                                                              ResultTilorsNearest[
                                                                      index]
                                                                  .profilePicture
                                                                  .toString()
                                                                  .substring(
                                                                      23)),
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 40,
                                                        foregroundImage:
                                                            AssetImage(
                                                          "images/DefaultProfileWomen.png",
                                                        ),
                                                      ),
                                                Text(
                                                  ResultTilorsNearest[index]
                                                      .name!,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                RatingBar.builder(
                                                  initialRating: CalculRating(
                                                      ResultTilorsNearest[
                                                          index]),
                                                  minRating: 1,
                                                  itemSize: 15,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    size: 1,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {},
                                                  ignoreGestures: true,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                ]))
              ],
            ),
          );
        },
      )),
    );
  }
}
