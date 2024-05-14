import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

class TailorSelected extends StatefulWidget {
  var image, qstsansrs;

  TailorSelected({
    super.key,
    required this.image,
    required this.qstsansrs,
  });

  @override
  State<TailorSelected> createState() => _SearchPageState();
}

class _SearchPageState extends State<TailorSelected> {
  @override
  int currentpage = 0;
  TextEditingController _controller = TextEditingController();
  List<Tailor> AllDataTailors = [];

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

  int indexCategory = 0;
  void _ShowResult(String query) {
    List<Tailor> Data;
    if (!_nearest) {
      if (query == "") {
        Data = AllDataTailors;
        EmptyResultTailors = false;
      } else {
        Data = AllDataTailors.where((element) =>
                element.name!.toUpperCase().startsWith(query.toUpperCase()))
            .toList();

        if ((Data.length == 0) && query == "") {
          EmptyResultTailors = false;
          Data = AllDataTailors;
          EmptyResultModels = false;
        } else if ((Data.length == 0) && query != "") {
          EmptyResultTailors = true;
          EmptyResultModels = true;
        } else {
          EmptyResultModels = false;
          EmptyResultTailors = false;
        }
      }
      setState(() {
        ResultTilors = Data;
      });
    } else {
      if (query == "") {
        Data = AllDataTailors;
        EmptyResultTailors = false;
        EmptyResultModels = false;
      } else {
        Data = AllDataTailors.where((element) =>
                element.name!.toUpperCase().startsWith(query.toUpperCase()))
            .toList();

        if ((Data.length == 0) && query == "") {
          EmptyResultTailors = false;
          Data = AllDataTailors;
          EmptyResultModels = false;
        } else if ((Data.length == 0) && query != "") {
          EmptyResultTailors = true;
        } else {
          EmptyResultTailors = false;
        }
      }
      setState(() {
        ResultTilorsNearest = Data;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AllDataTailors =
        Provider.of<TailorsProvider>(context, listen: false).AllTailors;

    ResultTilors = AllDataTailors;
  }

  Widget build(BuildContext context) {
    Result = ResultTilors;
    return Scaffold(
      body: Container(
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
                  onTapOutside: (event) {},
                  onEditingComplete: () {},
                  onTap: () {
                    setState(() {
                      Showseg = true;
                    });
                  },
                  onChanged: (value) {
                    if (value == "") {}
                    _ShowResult(value);
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
            Expanded(
                child: EmptyResultTailors
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
                            title: Text("Nearst ?"),
                            value: _nearest,
                            onChanged: (value) {
                              setState(() {
                                _nearest = value!;
                                if (value) {
                                  ResultTilorsNearest = ResultTilors.where(
                                      (element) =>
                                          element.name == "Rajaa" ||
                                          element.name == "Nour").toList();
                                }
                              });
                            },
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
                                          print("aaaaaaaaaaaaaa qqq");
                                          OrderLogique.AddOrderByMe(
                                              Provider.of<LocalDbProvider>(
                                                      context,
                                                      listen: false)
                                                  .id,
                                              ResultTilors[index].id,
                                              0,
                                              [],
                                              widget.image,
                                              widget.qstsansrs,
                                              ResultTilors[index],
                                              context);
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
                                                MainAxisAlignment.spaceBetween,
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
                                                            ResultTilors[index]
                                                                .profilePicture
                                                                .toString()
                                                                .substring(23)),
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
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              RatingBar.builder(
                                                initialRating: 3,
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
                                          // Provider.of<OrderProvider>(context,
                                          //         listen: false)
                                          //     .AddOrderByMe(
                                          //         IPCONFIG.ClientId,
                                          //         "66312abd324795932c839325",
                                          //         0,
                                          //         [],
                                          //         widget.image,
                                          //         widget.qstsansrs,
                                          //         ResultTilorsNearest[index],
                                          //         context);
                                          print("qqqq");
                                          // OrderLogique.AddOrderByMe(
                                          //     IPCONFIG.ClientId,
                                          //     ResultTilorsNearest[index].id,
                                          //     0,
                                          //     [],
                                          //     widget.image,
                                          //     widget.qstsansrs,
                                          //     ResultTilorsNearest[index],
                                          //     context);
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
                                                MainAxisAlignment.spaceBetween,
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
                                                                .substring(23)),
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
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              RatingBar.builder(
                                                initialRating: 3,
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
                      ))
          ],
        ),
      ),
    );
  }
}
