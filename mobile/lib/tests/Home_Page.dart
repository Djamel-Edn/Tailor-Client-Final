import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Data/category.dart';
import 'package:projetfinprepa/LogiquesFonctions/ReviweLogique.dart';
import 'package:projetfinprepa/Pages/ProfiPage.dart';
import 'package:projetfinprepa/Providers/CollecionProv.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Models.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> SavedData = [];
  int activateindex = 0;
  int indexCategory = 0;
  bool IsLoading = true;

  Future<Uint8List> DecodeIamge(image) async {
    return base64Decode(image);
  }

//////////////////////////////////////////////
///////////////////////////////////////////
  ///qllqllqlqsx dlc dkdkd oeozo zozo

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Consumer<ClientProvider>(
          builder: (context, value, child) {
            print(
                "sssssssssssssssss ${Provider.of<CollectionProvider>(context, listen: false).favs}");
            // if (Provider.of<ClientProvider>(context, listen: false).client !=
            //     null) {
            //   for (var tailor
            //       in Provider.of<ClientProvider>(context, listen: false)
            //           .client!
            //           .favorites!) {
            //     Provider.of<CollectionProvider>(context, listen: false)
            //         .AddFav(tailor["_id"]);
            //   }
            // }
            return Container(
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
                            Provider.of<ClientProvider>(context, listen: false)
                                        .client !=
                                    null
                                ? Text(
                                    "Hi,${Provider.of<ClientProvider>(context, listen: false).client!.name}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontFamily: "Nanum_Myeongjo"),
                                  )
                                : Text(
                                    "Hi, there",
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
                  Consumer<ModelsProvider>(
                    //
                    builder: (context, value, child) {
                      return (value.IsLoading)
                          ? SliverGrid.builder(
                              itemCount: 4,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 1,
                                      childAspectRatio: 0.82),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
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
                              itemCount: value
                                  .AllModelsByCategory[indexCategory].length,
                              itemBuilder: (context, index) {
                                print(
                                    "qqqqqqqqqqqqqqqqqqqq ${value.AllModelsByCategory[indexCategory].length}");
                                return InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Color(0xFFFFF4DE),
                                      isDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return Consumer<CollectionProvider>(
                                          builder:
                                              (context, collecFavs, child) {
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
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: AspectRatio(
                                                            aspectRatio: 1,
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image.memory(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    base64Decode(value
                                                                        .AllModelsByCategory[
                                                                            indexCategory]
                                                                            [
                                                                            index]
                                                                        .image))),
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
                                                              onTap: () async {
                                                                await RevLogique.AddLikePost(
                                                                    Provider.of<LocalDbProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .id,
                                                                    value
                                                                        .AllModelsByCategory[
                                                                            indexCategory]
                                                                            [
                                                                            index]
                                                                        .id,
                                                                    context);
                                                                collecFavs.addOrdeletLike(value
                                                                    .AllModelsByCategory[
                                                                        indexCategory]
                                                                        [index]
                                                                    .id);
                                                                // setState(() {});

                                                                // /////
                                                                // if (SavedData.contains(
                                                                //     value.AllModelsByCategory[
                                                                //             indexCategory]
                                                                //         [
                                                                //         index])) {
                                                                //   SavedData.remove(
                                                                //       value.AllModelsByCategory[
                                                                //               indexCategory]
                                                                //           [
                                                                //           index]);
                                                                // } else {
                                                                //   SavedData.add(
                                                                //       value.AllModelsByCategory[
                                                                //               indexCategory]
                                                                //           [
                                                                //           index]);
                                                                // }
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Color(
                                                                        0xFFFCF9F6)),
                                                                height: 40,
                                                                child: collecFavs
                                                                        .likes
                                                                        .contains(value
                                                                            .AllModelsByCategory[indexCategory][
                                                                                index]
                                                                            .id)
                                                                    ? Image
                                                                        .asset(
                                                                        "images/enregistrerinstagram (1).png",
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        "images/enregistrerinstagram.png",
                                                                      ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                                      builder:
                                                                          (context) =>
                                                                              ProfilPage(
                                                                        model: value.AllModelsByCategory[indexCategory]
                                                                            [
                                                                            index],
                                                                        tailor: value
                                                                            .AllModelsByCategory[indexCategory][index]
                                                                            .tailor!,
                                                                        IsFoRead:
                                                                            true,
                                                                        IsFoOrder:
                                                                            false,
                                                                      ),
                                                                    ));
                                                              },
                                                              child: value
                                                                          .AllModelsByCategory[
                                                                              indexCategory]
                                                                              [
                                                                              index]
                                                                          .tailor!
                                                                          .profilePicture !=
                                                                      "../utils/pp.png"
                                                                  ? CircleAvatar(
                                                                      foregroundImage: MemoryImage(base64Decode(value
                                                                          .AllModelsByCategory[
                                                                              indexCategory]
                                                                              [
                                                                              index]
                                                                          .tailor!
                                                                          .profilePicture!)))
                                                                  : Expanded(
                                                                      child: CircleAvatar(
                                                                          foregroundImage:
                                                                              AssetImage("images/profileimage.png")),
                                                                    ),
                                                            ),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Column(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ProfilPage(
                                                                            model:
                                                                                value.AllModelsByCategory[indexCategory][index],
                                                                            tailor:
                                                                                value.AllModelsByCategory[indexCategory][index].tailor!,
                                                                            IsFoRead:
                                                                                true,
                                                                            IsFoOrder:
                                                                                false,
                                                                          ),
                                                                        ));
                                                                  },
                                                                  child: Text(
                                                                    "${value.AllModelsByCategory[indexCategory][index].tailor!.name}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "Nanum_Myeongjo",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  initialRating: CalculRating(value
                                                                      .AllModelsByCategory[
                                                                          indexCategory]
                                                                          [
                                                                          index]
                                                                      .tailor!),
                                                                  minRating: 1,
                                                                  itemSize: 15,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
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
                                                                          Provider.of<LocalDbProvider>(context, listen: false)
                                                                              .id,
                                                                          value
                                                                              .AllModelsByCategory[indexCategory][index]
                                                                              .tailor!
                                                                              .id,
                                                                          context);
                                                                      collecFavs.addOrdeletFav(value
                                                                          .AllModelsByCategory[
                                                                              indexCategory]
                                                                              [
                                                                              index]
                                                                          .tailor!
                                                                          .id);
                                                                    },
                                                                    icon: collecFavs.favs.contains(value
                                                                            .AllModelsByCategory[indexCategory][index]
                                                                            .tailor!
                                                                            .id)
                                                                        ? Icon(
                                                                            Icons.favorite,
                                                                            color:
                                                                                Colors.red,
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 15),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ProfilPage(
                                                                model: value.AllModelsByCategory[
                                                                        indexCategory]
                                                                    [index],
                                                                tailor: value
                                                                    .AllModelsByCategory[
                                                                        indexCategory]
                                                                        [index]
                                                                    .tailor!,
                                                                IsFoRead: false,
                                                                IsFoOrder: true,
                                                              ),
                                                            ));
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 60,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            border:
                                                                Border.all(),
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
                                                              color:
                                                                  Colors.white),
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
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 4),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
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
                                              child: Image.memory(
                                                base64Decode(value
                                                    .AllModelsByCategory[
                                                        indexCategory][index]
                                                    .image),
                                                fit: BoxFit.cover,
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
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15)),
                                                color: Colors.white),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              title: Text(
                                                "${value.AllModelsByCategory[indexCategory][index].category}",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily:
                                                        "Nanum_Myeongjo"),
                                                textAlign: TextAlign.center,
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    value
                                                                .AllModelsByCategory[
                                                                    indexCategory]
                                                                    [index]
                                                                .tailor!
                                                                .profilePicture !=
                                                            "../utils/pp.png"
                                                        ? CircleAvatar(
                                                            foregroundImage: MemoryImage(
                                                                base64Decode(value
                                                                    .AllModelsByCategory[
                                                                        indexCategory]
                                                                        [index]
                                                                    .tailor!
                                                                    .profilePicture!)))
                                                        : Expanded(
                                                            child: CircleAvatar(
                                                                foregroundImage:
                                                                    AssetImage(
                                                                        "images/profileimage.png")),
                                                          ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      "${value.AllModelsByCategory[indexCategory][index].tailor!.name}",
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
                                                          "${CalculRating(value.AllModelsByCategory[indexCategory][index].tailor!).round()}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                  ),
                                );
                              },
                            );
                    },
                    //
                  ),
                  SliverAppBar(
                    backgroundColor: Color(0xFFFFF4DE),
                    toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            );
          },
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
