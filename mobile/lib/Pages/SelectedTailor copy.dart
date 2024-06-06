import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TailorSelectedTwo extends StatefulWidget {
  var image, qstsansrs;

  TailorSelectedTwo({
    super.key,
    required this.image,
    required this.qstsansrs,
  });

  @override
  State<TailorSelectedTwo> createState() => _SearchPageState();
}

class _SearchPageState extends State<TailorSelectedTwo> {
  @override
  int currentpage = 0;
  var cntxdialoge;
  TextEditingController _controller = TextEditingController();
  List<Tailor> AllDataTailors = [];
  late IO.Socket socket;

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

  void ConnectOrderRealTime() {
    socket = IO.io("https://tailor-client-5cqi.onrender.com", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    print("connected on order real time");
    socket.emit(
        "addNewUser", Provider.of<LocalDbProvider>(context, listen: false).id);
    socket.onConnect((data) {
      print("connected on order real time");
      socket.on("NewOrder", (data) {
        print('rrrrrr');
        print("on emit order..........................$data");
        print(mounted);
        // if (mounted)
        //   setState(() {
        //     Provider.of<ChatProvider>(context, listen: false).SetMessage(
        //         Message(
        //             ChatId: data["message"]["ChatId"],
        //             senderId: data["message"]["senderId"],
        //             text: data["message"]["text"],
        //             images: data["message"]["images"],
        //             date: DateTime.now()));
        //   });
        // print(mounted);
        // if (mounted) {
      });
    });
  }

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
    // TODO: implement initState
    super.initState();
    AllDataTailors =
        Provider.of<TailorsProvider>(context, listen: false).AllTailors;

    ResultTilors = AllDataTailors;
  }

  Widget build(BuildContext context) {
    Result = ResultTilors;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xFFFFF4DE),
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
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
                                                element.city == "sidi belabbes")
                                        .toList();
                                  }
                                });
                              },
                            ),
                            Expanded(
                              child: !_nearest
                                  ? ListView.builder(
                                      itemCount: ResultTilors.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                cntxdialoge = context;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color(0xFFFFF4DE),
                                                  ),
                                                );
                                              },
                                            );
                                            List<int> imagebytes =
                                                widget.image!.readAsBytesSync();
                                            await OrderLogique.AddOrderByMe(
                                                Provider.of<LocalDbProvider>(
                                                        context,
                                                        listen: false)
                                                    .id,
                                                ResultTilors[index].id,
                                                0,
                                                [],
                                                base64Encode(imagebytes),
                                                widget.qstsansrs,
                                                ResultTilors[index],
                                                socket,
                                                context);
                                            Navigator.pop(cntxdialoge);
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor:
                                                          Color(0xFFFFF4DE),
                                                      title: Text(
                                                        "Add order successfully",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Nanum_Myeongjo",
                                                            fontSize: 22),
                                                      ),
                                                      actions: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Back",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Nanum_Myeongjo",
                                                                fontSize: 16),
                                                          ),
                                                        )
                                                      ],
                                                    ));
                                          },
                                          child: AnimatedContainer(
                                            duration: Duration(
                                                milliseconds:
                                                    600 + (index * 100)),
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              border: Border.symmetric(
                                                  horizontal: BorderSide(
                                                      color: Color(0xFF000000)
                                                          .withAlpha(10))),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ResultTilors[index]
                                                                .profilePicture
                                                                .toString() !=
                                                            "../utils/pp.png"
                                                        ? CircleAvatar(
                                                            radius: 30,
                                                            foregroundImage:
                                                                MemoryImage(
                                                              base64Decode(
                                                                  ResultTilors[
                                                                          index]
                                                                      .profilePicture
                                                                      .toString()),
                                                            ),
                                                          )
                                                        : CircleAvatar(
                                                            radius: 30,
                                                            foregroundImage:
                                                                AssetImage(
                                                              "images/DefaultProfileWomen.png",
                                                            ),
                                                          ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          ResultTilors[index]
                                                              .name!,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        RatingBar.builder(
                                                          initialRating:
                                                              CalculRating(
                                                                  ResultTilors[
                                                                      index]),
                                                          minRating: 1,
                                                          itemSize: 15,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            size: 1,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {},
                                                          ignoreGestures: true,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      itemCount: ResultTilorsNearest.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                cntxdialoge = context;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                            );
                                            await OrderLogique.AddOrderByMe(
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
                                                socket,
                                                context);
                                            Navigator.pop(cntxdialoge);
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor:
                                                          Color(0xFFFFF4DE),
                                                      title: Text(
                                                        "Add order successfully",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Nanum_Myeongjo",
                                                            fontSize: 22),
                                                      ),
                                                      actions: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Back",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Nanum_Myeongjo",
                                                                fontSize: 16),
                                                          ),
                                                        )
                                                      ],
                                                    ));
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
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black
                                                      .withAlpha(10)),
                                              color: Color(0xFFD9D9D9)
                                                  .withAlpha(60),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ResultTilorsNearest[index]
                                                            .profilePicture
                                                            .toString() !=
                                                        "../utils/pp.png"
                                                    ? CircleAvatar(
                                                        radius: 30,
                                                        foregroundImage:
                                                            MemoryImage(
                                                          base64Decode(
                                                              ResultTilorsNearest[
                                                                      index]
                                                                  .profilePicture
                                                                  .toString()),
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 30,
                                                        foregroundImage:
                                                            AssetImage(
                                                          "images/DefaultProfileWomen.png",
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      ResultTilorsNearest[index]
                                                          .name!,
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    RatingBar.builder(
                                                      initialRating: CalculRating(
                                                          ResultTilorsNearest[
                                                              index]),
                                                      minRating: 1,
                                                      itemSize: 15,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        size: 1,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                      ignoreGestures: true,
                                                    )
                                                  ],
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
      ),
    );
  }
}
