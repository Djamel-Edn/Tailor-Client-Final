import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';
import 'package:projetfinprepa/LogiquesFonctions/ReviweLogique.dart';
import 'package:projetfinprepa/Pages/SousPages/MapScreenPage.dart';
import 'package:projetfinprepa/Providers/CollecionProv.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Models.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ProfilPage extends StatefulWidget {
  Tailor tailor;
  bool IsFoRead;
  bool IsFoOrder;
  Model? model;

  ProfilPage(
      {super.key,
      required this.tailor,
      required this.IsFoRead,
      required this.IsFoOrder,
      required this.model});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool ForRead = true;
  bool InOrder = false;
  late IO.Socket socket;
  String? _groupvalue;
  List<Model> Catalogue = [];
  List<Model> ModelsSelected = [];
  List<bool> bools = [];
  var cntxdialog;
  var totalrating = 0.0;
  @override
  void initState() {
    for (var e in widget.tailor.reviews!) {
      totalrating += double.parse(e["rating"].toString());
    }
    if (widget.tailor.reviews!.isNotEmpty) {
      totalrating = totalrating / widget.tailor.reviews!.length;
      totalrating = totalrating.roundToDouble();
    } else {
      totalrating = 0;
    }

    if (widget.model != null) {
      ModelsSelected.add(widget.model!);
    }
    ForRead = widget.IsFoRead;
    InOrder = widget.IsFoOrder;
    for (var model
        in Provider.of<ModelsProvider>(context, listen: false).AllModel) {
      if (model.tailor!.id == widget.tailor.id) {
        Catalogue.add(model);
      }
    }

    super.initState();
  }

  // void sendOrder(OrderEmit order) {
  //   socket = IO.io("https://tailor-client-ps9z.onrender.com", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   Map<String, dynamic> orderobj = {
  //     "id": order.id,
  //     "models": order.models,
  //     "orderDate": order.orderDate,
  //     "postStyle": order.postStyle,
  //     "questionnaire": order.questionnaire,
  //     "status": order.status,
  //     "tailor": order.tailor,
  //     "totalPrice": order.totalPrice,
  //   };
  //   socket.emit("newOrder", orderobj);
  // }

  @override
  Widget build(BuildContext context) {
    var GContext = context;

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Consumer<CollectionProvider>(
            builder: (context, collecFavs, child) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "images/BackgroundProfileImage.png",
                        ),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          widget.tailor.profilePicture != "../utils/pp.png"
                              ? !ForRead
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                    )
                                  : CircleAvatar(
                                      radius: 46,
                                      foregroundImage: MemoryImage(
                                        base64Decode(widget
                                            .tailor.profilePicture!
                                            .substring(23)),
                                      ),
                                    )
                              : SizedBox(),
                          // CircleAvatar(
                          //     radius: 46,
                          //     foregroundImage: AssetImage(
                          //       "images/DefaultProfileWomen.png",
                          //     ),
                          //   ),
                          ForRead ? SizedBox() : SizedBox(),
                          !ForRead
                              ? SizedBox()
                              // Text(
                              //     widget.tailor.name!,
                              //     style: TextStyle(
                              //         fontFamily: "Nanum_Myeongjo",
                              //         fontSize: 28,
                              //         decoration: TextDecoration.underline),
                              //   )
                              : SizedBox(),
                          ForRead
                              ? InkWell(
                                  onTap: () async {
                                    await RevLogique.AddFavTailor(
                                        Provider.of<LocalDbProvider>(context,
                                                listen: false)
                                            .id,
                                        widget.tailor.id,
                                        context);
                                    collecFavs.addOrdeletFav(widget.tailor.id);
                                    // if (Style.SavedTailroFav.contains(d
                                    //     widget.tailor.id)) {
                                    //   Style.SavedTailroFav.remove(widget.tailor.id);
                                    // } else {
                                    //   Style.SavedTailroFav.add(widget.tailor.id!);
                                    // }
                                    // setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: collecFavs.favs
                                              .contains(widget.tailor.id)
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(Icons.favorite_border),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 100,
                                )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.topLeft,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF4DE),
                        border: Border.all(color: Color(0xFF715B49)),
                        //  borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(30),
                        //     topRight: Radius.circular(30))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ForRead
                              ? Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.tailor.name!,
                                                      style: TextStyle(
                                                          fontSize: 28,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    ),
                                                    Text(
                                                      "Female",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily:
                                                            "Nanum_Myeongjo",
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("${totalrating}"),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                RatingBar.builder(
                                                  initialRating: totalrating,
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
                                                ),
                                                Text(
                                                    " (${widget.tailor.reviews!.length})")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 2),
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 20,
                                                child: Image.asset(
                                                    "images/adress.png")),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "8430 Preston Rd. Medea,Medea",
                                              style: TextStyle(
                                                  fontFamily: "Nanum_Myeongjo",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 2),
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 25,
                                                child: Image.asset(
                                                    "images/eprouve.png")),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              "Available for the moment.",
                                              style: TextStyle(
                                                  fontFamily: "Nanum_Myeongjo",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 6,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ForRead = false;
                                        InOrder = true;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          top: 12,
                                          bottom: 12,
                                          right: 4),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "images/order.png",
                                            color: InOrder
                                                ? Colors.white
                                                : Colors.black,
                                          )),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: InOrder
                                              ? Color(0xFF84643D)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  ),
                                  Text(
                                    "Order",
                                    style: TextStyle(
                                        fontFamily: "Nanum_Myeongjo",
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ForRead = false;
                                        InOrder = false;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                        child: Image.asset(
                                          "images/destination.png",
                                          color: ForRead
                                              ? Colors.black
                                              : !InOrder
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: ForRead
                                              ? Colors.transparent
                                              : !InOrder
                                                  ? Color(0xFF84643D)
                                                  : Colors.transparent,
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  ),
                                  Text(
                                    "Direction",
                                    style: TextStyle(
                                        fontFamily: "Nanum_Myeongjo",
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    height: 60,
                                    width: 60,
                                    child: InkWell(
                                      onTap: () {
                                        // Share.share(
                                        //     'check out my website https://example.com');
                                      },
                                      child: Container(
                                        child:
                                            Image.asset("images/partager.png"),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                                  Text(
                                    "Share",
                                    style: TextStyle(
                                        fontFamily: "Nanum_Myeongjo",
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ForRead
                              ? TabBar(
                                  dividerColor: Colors.transparent,
                                  indicatorPadding: EdgeInsets.all(1),
                                  labelColor: Colors.black,
                                  splashBorderRadius: BorderRadius.circular(0),
                                  indicatorColor: Colors.black,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  labelPadding: EdgeInsets.all(10),
                                  padding: EdgeInsets.symmetric(vertical: 3),
                                  tabs: [
                                    Text(
                                      "Gallery",
                                      style: TextStyle(
                                          fontFamily: "Nanum_Myeongjo",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "Review",
                                      style: TextStyle(
                                          fontFamily: "Nanum_Myeongjo",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "About us",
                                      style: TextStyle(
                                          fontFamily: "Nanum_Myeongjo",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ],
                                )
                              : InOrder
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          height: 2,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          child: Text(
                                            "1/ Select one or more models from the catalog for tailoring.",
                                            style: TextStyle(
                                                fontFamily: "Nanum_Myeongjo",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  // for image from gallery
                                                  // onTap: UploadImage,
                                                  onTap: () async {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                            return BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX: 5,
                                                                      sigmaY:
                                                                          5),
                                                              child:
                                                                  AlertDialog(
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFFFFF4DE),
                                                                      title:
                                                                          ListTile(
                                                                        title:
                                                                            Text(
                                                                          "Catalog",
                                                                          style: TextStyle(
                                                                              fontFamily: "Nanum_Myeongjo",
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 20),
                                                                        ),
                                                                        subtitle:
                                                                            Text(
                                                                          "Choose your desired style from our catalog of previously tailored models.",
                                                                          style: TextStyle(
                                                                              fontFamily: "Nanum_Myeongjo",
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ),
                                                                      content:
                                                                          Wrap(
                                                                        children: [
                                                                          Divider(),
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.4,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.7,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(1.0),
                                                                              child: GridView.builder(
                                                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 3, crossAxisSpacing: 3, crossAxisCount: 3, childAspectRatio: 0.65),
                                                                                itemBuilder: (context, index) {
                                                                                  Model? model;
                                                                                  return Stack(
                                                                                    children: [
                                                                                      Container(
                                                                                        height: MediaQuery.of(context).size.height * 0.28,
                                                                                        decoration: BoxDecoration(
                                                                                            border: Border.all(),
                                                                                            borderRadius: BorderRadius.circular(
                                                                                              8,
                                                                                            )),
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(8),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: Image.memory(
                                                                                              base64Decode(Catalogue[index].image),
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Positioned(
                                                                                        top: 0,
                                                                                        right: 0,
                                                                                        child: Checkbox(
                                                                                          shape: CircleBorder(),
                                                                                          checkColor: Color(0xFF84643D),
                                                                                          activeColor: Colors.black,
                                                                                          value: ModelsSelected.contains(Catalogue[index]),
                                                                                          onChanged: (val) {
                                                                                            if (val!) {
                                                                                              ModelsSelected.add(Catalogue[index]);
                                                                                              bools.add(val);
                                                                                            } else {
                                                                                              ModelsSelected.removeWhere((element) => element == Catalogue[index]);
                                                                                            }
                                                                                            setState(() {});
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                                itemCount: Catalogue.length,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(20.0),
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                margin: EdgeInsets.symmetric(
                                                                                  horizontal: MediaQuery.of(context).size.width * 0.09,
                                                                                ),
                                                                                height: 50,
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFF84643D),
                                                                                  border: Border.all(),
                                                                                  borderRadius: BorderRadius.circular(12),
                                                                                ),
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text(
                                                                                    "Next",
                                                                                    style: TextStyle(color: Colors.white, fontFamily: "Nanum_Myeongjo", fontWeight: FontWeight.bold, fontSize: 14),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Center(
                                                                              child: InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "Back",
                                                                              style: TextStyle(
                                                                                decoration: TextDecoration.underline,
                                                                                color: Color(0xFF84643D),
                                                                                fontFamily: "Nanum_Myeongjo",
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                          ))
                                                                        ],
                                                                      )),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );

                                                    this.setState(() {});
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.17,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                    decoration: BoxDecoration(
                                                        color: Color(0xFFEDDBC1)
                                                            .withAlpha(30),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFF715B49)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Icon(Icons.add),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Row(
                                                    children:
                                                        ModelsSelected
                                                            .map(
                                                                (model) =>
                                                                    Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              5,
                                                                          horizontal:
                                                                              4),
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.17,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.3,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xFFEDDBC1).withAlpha(
                                                                              30),
                                                                          border:
                                                                              Border.all(color: Color(0xFF715B49)),
                                                                          borderRadius: BorderRadius.circular(20)),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        child: Image
                                                                            .memory(
                                                                          base64Decode(
                                                                              model.image),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    )).toList(),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Text(
                                            "2/ Would you like to provide the fabric, or shall the tailor handle it?",
                                            style: TextStyle(
                                                fontFamily: "Nanum_Myeongjo",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        RadioListTile(
                                            activeColor: Colors.black,
                                            title: Text(
                                              "I'll provide the fabric.",
                                              style: TextStyle(
                                                  fontFamily: "Nanum_Myeongjo",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            value: "I'll provide the fabric.",
                                            groupValue: _groupvalue,
                                            onChanged: (val) {
                                              setState(() {
                                                _groupvalue = val;
                                              });
                                            }),
                                        RadioListTile(
                                            activeColor: Colors.black,
                                            title: Text(
                                              "Tailor to handle fabric purchase.",
                                              style: TextStyle(
                                                  fontFamily: "Nanum_Myeongjo",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            value:
                                                "Tailor to handle fabric purchase.",
                                            groupValue: _groupvalue,
                                            onChanged: (val) {
                                              setState(() {
                                                _groupvalue = val;
                                              });
                                            }),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.11,
                                        ),
                                        Center(
                                          child: InkWell(
                                            onTap: () {
                                              List<String> IDSModel = [];
                                              for (var i = 0;
                                                  i < ModelsSelected.length;
                                                  i++) {
                                                IDSModel.add(
                                                    ModelsSelected[i].id);
                                              }
                                              if (ModelsSelected.length != 0) {
                                                BuildContext c;
                                                OrderLogique.AddOrder(
                                                        Provider.of<LocalDbProvider>(
                                                                context,
                                                                listen: false)
                                                            .id,
                                                        widget.tailor.id,
                                                        "1200",
                                                        IDSModel,
                                                        context)
                                                    .then((value) async {
                                                  Provider.of<ClientProvider>(
                                                          context,
                                                          listen: false)
                                                      .GetALlAboutCurrentUser(
                                                          Provider.of<LocalDbProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .id,
                                                          context);
                                                  print(
                                                      "adddinaaa oredr w hada howa ${value}");
                                                  // sendOrder(value!);
                                                  showDialog(
                                                      context: context,
                                                      builder: (contextdialog) {
                                                        cntxdialog =
                                                            contextdialog;
                                                        return BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 5,
                                                                    sigmaY: 5),
                                                            child: AlertDialog(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFFFF4DE),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              title: Center(
                                                                child: Text(
                                                                  "Success! ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Nanum_Myeongjo",
                                                                      fontSize:
                                                                          25),
                                                                ),
                                                              ),
                                                              content: Text(
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          22,
                                                                      fontFamily:
                                                                          "Nanum_Myeongjo"),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  " Your order has been placed. \n Your request is currently being processed. You'll receive a notification once the tailor accepts your order"),
                                                            ));
                                                      });
                                                  return Future.delayed(
                                                      Duration(seconds: 3), () {
                                                    Navigator.pop(cntxdialog);
                                                  });
                                                });
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.16,
                                              ),
                                              height: 48,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF84643D),
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                "Order now",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        "Nanum_Myeongjo",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Center(
                                              child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Back",
                                              style: TextStyle(
                                                  fontFamily: "Nanum_Myeongjo",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          )),
                                        ),
                                      ],
                                    )
                                  : Expanded(child: MapScreen()),
                          ForRead
                              ? Expanded(
                                  child: TabBarView(children: [
                                    // gallery
                                    widget.tailor.models != null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: GridView.builder(
                                              itemCount: Catalogue.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.memory(
                                                      base64Decode(
                                                          Catalogue[index]
                                                              .image),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : Image.asset(
                                            "images/ImageForGallery.png"),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: ListView.builder(
                                        itemCount:
                                            widget.tailor.reviews!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 6),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color(0xFFD9D9D9),
                                            ),
                                            child: Wrap(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: CircleAvatar(
                                                          child: widget.tailor.reviews![
                                                                              index]
                                                                          [
                                                                          "client"]
                                                                      [
                                                                      "profilePicture"] !=
                                                                  "/../utils/pp.png"
                                                              ? Image.memory(base64Decode(widget
                                                                          .tailor
                                                                          .reviews![index]
                                                                      ["client"]
                                                                  ["profilePicture"]))
                                                              : Image.asset(
                                                                  "images/profileimage.png",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "${widget.tailor.reviews![index]["client"]["name"]}",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Nanum_Myeongjo",
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                                  child: Text(
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Nanum_Myeongjo",
                                                        fontSize: 14,
                                                      ),
                                                      "${widget.tailor.reviews![index]["text"]}"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 15),
                                      child: SingleChildScrollView(
                                        child: Text(
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: "Nanum_Myeongjo",
                                              fontSize: 18,
                                            ),
                                            "${widget.tailor.description}"),
                                      ),
                                    )
                                  ]),
                                )
                              : SizedBox()
                        ],
                      ),
                    )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
