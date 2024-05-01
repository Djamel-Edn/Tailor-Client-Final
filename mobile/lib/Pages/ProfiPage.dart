import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Providers/Models.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  Tailor tailor;
  ProfilPage({super.key, required this.tailor});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool ForRead = true;
  bool InOrder = false;
  File? image;
  final imagePicker = ImagePicker();
  List<File> ImagesSelected = [];
  String? _groupvalue;
  List<Model> Catalogue = [];
  List<Model> ModelsSelected = [];
  List<bool> bools = [];
  UploadImage() async {
    var pickedimage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
        ImagesSelected.add(image!);
      });
    }
  }

  @override
  void initState() {
    // Catalogue = Provider.of<ModelsProvider>(context, listen: false).AllModel;

    for (var model
        in Provider.of<ModelsProvider>(context, listen: false).AllModel) {
      if (model.tailor.id == widget.tailor.id) {
        Catalogue.add(model);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/coverture.png"),
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 46,
                        foregroundImage: MemoryImage(
                          base64Decode(
                              widget.tailor.profilePicture.substring(23)),
                        ),
                      ),
                      ForRead ? Expanded(child: SizedBox()) : SizedBox(),
                      !ForRead
                          ? Text(
                              widget.tailor.name,
                              style: TextStyle(
                                  fontSize: 28,
                                  decoration: TextDecoration.underline),
                            )
                          : Container(
                              padding: EdgeInsets.all(4),
                              alignment: Alignment.center,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xFF84643D),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Icon(
                                      Icons.favorite_outline_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Text(
                                      "follow",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ForRead
                          ? Text("")
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
                      color: Color(0xFFFCF9F6),
                      border: Border.all(color: Color(0xFF715B49)),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
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
                                              children: [
                                                Text(
                                                  widget.tailor.name,
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                                Text(
                                                  "Female",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(widget.tailor.rating),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            RatingBar.builder(
                                              initialRating: double.parse(
                                                  widget.tailor.rating),
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
                                            ),
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
                                        Icon(Icons.local_movies),
                                        Text("8430 Preston Rd. Medea,Medea"),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 2),
                                    child: Row(
                                      children: [
                                        Icon(Icons.approval_outlined),
                                        Text("Available for the moment."),
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
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: InOrder
                                          ? Color(0xFF9E7B61)
                                          : Colors.transparent,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "images/1193609 1.png")),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                              Text("Order")
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
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: ForRead
                                          ? Colors.transparent
                                          : !InOrder
                                              ? Color(0xFF9E7B61)
                                              : Colors.transparent,
                                      border: Border.all(),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "images/Vector (9).png")),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                              Text("Direction")
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "images/Vector (10).png")),
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                              Text("Share")
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ForRead
                          ? TabBar(
                              dividerColor: Color(0xFF54361E),
                              labelColor: Color(0xFF54361E),
                              indicatorColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelPadding: EdgeInsets.all(6),
                              tabs: [
                                Text("Gallery"),
                                Text("Review"),
                                Text("About us")
                              ],
                            )
                          : InOrder
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 1),
                                            child: Text(
                                                "1/ Choose your tailoring timeframe"),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.settings))
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: DropdownMenu(
                                          trailingIcon: Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          hintText: "select",
                                          enableFilter: true,
                                          enableSearch: true,
                                          onSelected: (value) {
                                            print(value);
                                          },
                                          menuStyle: MenuStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xFFF8F2E9)),
                                              elevation:
                                                  MaterialStatePropertyAll(10)),
                                          dropdownMenuEntries: [
                                            DropdownMenuEntry(
                                                style: ButtonStyle(
                                                    overlayColor:
                                                        MaterialStatePropertyAll(
                                                            Color(0xFFF8F2E9)),
                                                    surfaceTintColor:
                                                        MaterialStatePropertyAll(
                                                            Color(0xFFF8F2E9)),
                                                    shadowColor:
                                                        MaterialStatePropertyAll(
                                                            Color(0xFFF8F2E9)),
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Color(0xFFF8F2E9)),
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            Color(0xFFF8F2E9))),
                                                value: "sss",
                                                label: "sss"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      child: Text(
                                          "2/ Select one or more models from the catalog for tailoring."),
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
                                                      builder:
                                                          (context, setState) {
                                                        return BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                                  sigmaX: 5,
                                                                  sigmaY: 5),
                                                          child: AlertDialog(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              title: ListTile(
                                                                title: Text(
                                                                    "Catalog"),
                                                                subtitle: Text(
                                                                    "Choose your desired style from our catalog of previously tailored models."),
                                                              ),
                                                              content: Wrap(
                                                                children: [
                                                                  Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.4,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.7,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          1.0),
                                                                      child: GridView
                                                                          .builder(
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            mainAxisSpacing:
                                                                                3,
                                                                            crossAxisSpacing:
                                                                                3,
                                                                            crossAxisCount:
                                                                                3,
                                                                            childAspectRatio:
                                                                                0.65),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          Model?
                                                                              model;
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
                                                                                  child: Image.memory(
                                                                                    base64Decode(Catalogue[index].image),
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Positioned(
                                                                                top: 0,
                                                                                right: 0,
                                                                                child: Checkbox(
                                                                                  shape: CircleBorder(),
                                                                                  checkColor: Colors.white,
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
                                                                        itemCount:
                                                                            Catalogue.length,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            20.0),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        margin:
                                                                            EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              MediaQuery.of(context).size.width * 0.09,
                                                                        ),
                                                                        height:
                                                                            50,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFF84643D),
                                                                          border:
                                                                              Border.all(),
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Next",
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Center(
                                                                      child:
                                                                          InkWell(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Back",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xFF84643D),
                                                                            decoration: TextDecoration.underline),
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
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.17,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.30,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFEDDBC1)
                                                        .withAlpha(30),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFF715B49)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Icon(Icons.add),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Row(
                                                children: ModelsSelected.map(
                                                    (model) => Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      4),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.17,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                      0xFFEDDBC1)
                                                                  .withAlpha(
                                                                      30),
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xFF715B49)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image.memory(
                                                              base64Decode(
                                                                  model.image),
                                                              fit: BoxFit.cover,
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
                                          horizontal: 10, vertical: 2),
                                      child: Text(
                                          "3/ Would you like to provide the fabric, or shall the tailor handle it?"),
                                    ),
                                    RadioListTile(
                                        activeColor: Colors.black,
                                        title: Text("I'll provide the fabric."),
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
                                            "Tailor to handle fabric purchase."),
                                        value:
                                            "Tailor to handle fabric purchase.",
                                        groupValue: _groupvalue,
                                        onChanged: (val) {
                                          setState(() {
                                            _groupvalue = val;
                                          });
                                        }),
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 5, sigmaY: 5),
                                                    child: AlertDialog(
                                                      alignment:
                                                          Alignment.center,
                                                      title: Center(
                                                        child: Text(
                                                          "Success! ",
                                                          style: TextStyle(
                                                              fontSize: 23),
                                                        ),
                                                      ),
                                                      content: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          " Your order has been placed. \n Your request is currently being processed. You'll receive a notification once the tailor accepts your order"),
                                                    )),
                                          );
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.16,
                                          ),
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF84643D),
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "Order now",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Center(
                                          child: InkWell(
                                        child: Text(
                                          "Back",
                                          style: TextStyle(
                                              color: Color(0xFF84643D),
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      )),
                                    )
                                  ],
                                )
                              : Text("Direction"),
                      ForRead
                          ? Expanded(
                              child: TabBarView(children: [
                                Image.asset("images/ImageForGallery.png"),
                                Text("rev"),
                                Text("us")
                              ]),
                            )
                          : SizedBox()
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
