import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:projetfinprepa/Pages/SousPages/CustomDesign.dart';
import 'package:projetfinprepa/Styles/DataStyles.dart';

class CreateStylePage extends StatefulWidget {
  @override
  State<CreateStylePage> createState() => _SearchPageState();
}

class _SearchPageState extends State<CreateStylePage> {
  final advancedDrawerController = AdvancedDrawerController();
  // late O3DController controller;
  var CategorySelected;
  int CategorySelectedIndex = 0;
  String TypeSelected = "";
  bool AnyTypeSelected = false;
  bool showback = true;
  List<BasicTile> Data = [
    BasicTile(title: "Tops", tiles: [
      Tiles(tile: "Blouse", isselected: false),
      Tiles(tile: "Cardigan", isselected: false),
      Tiles(tile: "Hoodie", isselected: false),
      Tiles(tile: "Shirt", isselected: false),
      Tiles(tile: "Sweatshirt", isselected: false),
      Tiles(tile: "shirt", isselected: false),
    ]),
    BasicTile(title: "Bottoms", tiles: [
      Tiles(tile: "Bermuda shorts", isselected: false),
      Tiles(tile: "Jogging pants", isselected: false),
      Tiles(tile: "Leggings", isselected: false),
      Tiles(tile: "pants", isselected: false),
      Tiles(tile: "Skirt", isselected: false),
      Tiles(tile: "Trousers", isselected: false),
    ]),
    BasicTile(title: "Dresses and Jumpsuits", tiles: [
      Tiles(tile: "Dress", isselected: false),
      Tiles(tile: "Jumpsuit", isselected: false),
      Tiles(tile: "Skirts", isselected: false),
    ]),
    // BasicTile(title: "Sleepwear", tiles: [
    //   Tiles(tile: "Pajama Sets", isselected: false),
    //   Tiles(tile: "Robes", isselected: false),
    // ]),
    BasicTile(title: "Suits and Sets", tiles: [
      Tiles(tile: "Suit (jacket and pants)", isselected: false),
      Tiles(tile: "Tailleur (skirt and jacket)", isselected: false),
      Tiles(tile: "Uniform", isselected: false),
    ]),
    BasicTile(title: "Outerwear", tiles: [
      Tiles(tile: "Blazer", isselected: false),
      Tiles(tile: "Coat", isselected: false),
      Tiles(tile: "Jacket", isselected: false),
      Tiles(tile: "Parka", isselected: false),
      Tiles(tile: "Poncho", isselected: false),
      Tiles(tile: "Trench coat", isselected: false),
      Tiles(tile: "Vest", isselected: false),
    ]),
    BasicTile(title: "sportswear", tiles: [
      Tiles(tile: "Athletic shorts", isselected: false),
      Tiles(tile: "Tracksuits", isselected: false),
      Tiles(tile: "Leggings", isselected: false),
      Tiles(tile: "Performance Tops", isselected: false),
      Tiles(tile: "Compression Wear", isselected: false),
    ]),
    BasicTile(title: "Accessories", tiles: [
      Tiles(tile: "Belt", isselected: false),
      Tiles(tile: "Cap", isselected: false),
      Tiles(tile: "Hat", isselected: false),
      Tiles(tile: "Scarf", isselected: false),
    ])
  ];
  List<String> StyleAfficher = [];
  @override
  void initState() {
    // controller = O3DController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      disabledGestures: true,
      controller: advancedDrawerController,
      backdropColor: Color(0xFFC7B7A7),
      drawer: SafeArea(
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
            child: Text(
              "TYPES OF CLOTHES",
              style: TextStyle(
                fontFamily: "Nanum_Myeongjo",
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView(
                children: Data.map((e) => ExpansionTile(
                      iconColor: Colors.black,
                      leading: Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      trailing: Icon(
                        Icons.abc,
                        color: Colors.transparent,
                      ),
                      title: Text(
                        e.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Nanum_Myeongjo",
                          fontSize: 20,
                        ),
                      ),
                      children: e.tiles
                          .map(
                            (tile) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                  ),
                                  Image.asset(
                                    "images/DOT.png",
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Expanded(
                                    child: Text(
                                      tile.tile,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nanum_Myeongjo",
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                      shape: CircleBorder(),
                                      side: BorderSide(color: Colors.black),
                                      checkColor: Colors.white,
                                      activeColor: Colors.black,
                                      value: tile.isselected,
                                      onChanged: (val) {
                                        setState(() {
                                          for (var el in Data) {
                                            for (var rlr in el.tiles) {
                                              rlr.isselected = false;
                                            }
                                          }
                                          tile.isselected = val!;
                                          // The key is tile.tile

                                          TypeSelected = tile.tile;
                                          switch (TypeSelected) {
                                            case "Blouse" ||
                                                  "Cardigan" ||
                                                  "Hoodie" ||
                                                  "Shirt" ||
                                                  "Sweatshirt" ||
                                                  "T-shirt":
                                              CategorySelected = "Tops";
                                              CategorySelectedIndex = 0;
                                              break;
                                            case "Bermuda shorts" ||
                                                  "Jogging pants" ||
                                                  "Leggings" ||
                                                  "Pants" ||
                                                  "Skirt" ||
                                                  "Trousers":
                                              CategorySelected = "Bottoms";
                                              CategorySelectedIndex = 1;
                                              break;
                                            case "Dress" ||
                                                  "Skirt" ||
                                                  "Jumpsuit":
                                              CategorySelected = "Dresses";
                                              CategorySelectedIndex = 2;
                                              break;
                                            case "Suit (jacket and pants)" ||
                                                  "Tailleur (skirt and jacket)" ||
                                                  "Uniform":
                                              CategorySelected = "Suits";
                                              CategorySelectedIndex = 3;
                                              break;
                                            case "Athletic shorts" ||
                                                  "Tracksuits" ||
                                                  "Compression Wear" ||
                                                  "Leggings":
                                              CategorySelected = "Sportswear";
                                              CategorySelectedIndex = 5;
                                              break;
                                            case "Belt" ||
                                                  "Cap" ||
                                                  "Hat" ||
                                                  "Scarf":
                                              CategorySelected = "Accessories";
                                              CategorySelectedIndex = 6;
                                              break;

                                            default:
                                              CategorySelected = "Outerwear";
                                              CategorySelectedIndex = 4;
                                          }
                                          setState(() {
                                            AnyTypeSelected = true;
                                          });
                                          StyleAfficher.clear();
                                          for (var type in Style
                                              .styles[CategorySelectedIndex]
                                              .subCategories) {
                                            if (type["name"] == TypeSelected) {
                                              for (var image
                                                  in type["images"]) {
                                                StyleAfficher.add(image);
                                              }
                                            }
                                          }
                                        });
                                      })
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    )).toList()),
          ),
        ],
      )),
      child: Scaffold(
          appBar: AppBar(
              toolbarHeight: 100,
              backgroundColor: Color(0xFFFFF4DE),
              actions: [],
              leading: Wrap(
                children: [
                  showback
                      ? IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ))
                      : SizedBox(),
                  InkWell(
                    onTap: () {
                      drawerController();
                    },
                    child: Container(
                      height: 32,
                      child: Image.asset("images/Lines.png"),
                    ),
                  ),
                ],
              )),
          backgroundColor: Color(0xFFFFF4DE),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: !AnyTypeSelected
                ? Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Before you start choose the category and type of garment that resonate with you.",
                      style: TextStyle(
                        fontFamily: "Nanum_Myeongjo",
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      itemCount: StyleAfficher.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 40),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomDesignPAge(
                                        image: StyleAfficher[index],
                                        QStOF: CategorySelected,
                                        type: TypeSelected),
                                  ));
                            },
                            child: Container(
                              height: 300,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                              ),
                              child: Image.asset(
                                StyleAfficher[index],
                                fit: BoxFit.cover,
                              ),
                              //  O3D.asset(
                              //   // src: "images/glbglbttled.glb",
                              //   // src: "images/ThreeDModels/shirtwomen.glb",
                              //   src:
                              //       "images/ThreeDModels/shirtlongrouvert.glb",
                              //   // src: "mobile/images/ChaiseObj/jiiiiiittled.glb",
                              //   autoPlay: true,
                              //   autoRotate: true,
                              //   ar: false,
                              //   xrEnvironment: true,
                              //   autoRotateDelay: 1,
                              //   disableZoom: true,
                              //   disableTap: false,
                              //   disablePan: false,
                              //   environmentImage: "",
                              // ),
                            ),
                          ),
                        );
                      },
                    )),
          )
          // body: Container(

          ),
    );
  }

  void drawerController() {
    advancedDrawerController.showDrawer();
  }

  Widget buildtile(BasicTile basicTile) {
    return ExpansionTile(
      title: Text(basicTile.title),
      children: basicTile.tiles.map((e) => buildtile(basicTile)).toList(),
    );
  }
}

class BasicTile {
  final String title;
  final List<Tiles> tiles;
  BasicTile({required this.title, required this.tiles});
}

class Tiles {
  final String tile;
  bool isselected;
  Tiles({required this.tile, required this.isselected});
}
