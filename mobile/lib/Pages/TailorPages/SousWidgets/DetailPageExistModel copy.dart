import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';
import 'package:projetfinprepa/Pages/TailorPages/ChatPageTailor.dart';
import 'package:projetfinprepa/Providers/Chat.dart';
import 'package:projetfinprepa/Widgets/CommandItemTailorLargeImages.dart';
import 'package:provider/provider.dart';

class DetailPageExistModel extends StatelessWidget {
  var order;
  DetailPageExistModel({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 70,
                title: Text("Order Detail"),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              order["client"]["profilePicture"] ==
                                      "/../utils/pp.png"
                                  ? CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage(
                                        "images/profileimage.png",
                                      ))
                                  : CircleAvatar(
                                      radius: 40,
                                      backgroundImage: MemoryImage(base64Decode(
                                          order["client"]["profilePicture"])),
                                    ),
                              Text(order["client"]["name"]),
                            ],
                          ),
                          CommandItemTailorLargeImages(order: order),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text("Date"),
                              SizedBox(
                                width: 40,
                              ),
                              Text(order["orderDate"]
                                  .toString()
                                  .substring(0, 10))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text("Fabric"),
                              SizedBox(
                                width: 40,
                              ),
                              Text("Provided by client")
                            ],
                          ),
                        ],
                      ),
                    ),
                    order["status"] == "Accepted"
                        ? Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    OrderLogique.AcceptOrder(order["_id"],
                                            "Completed", 3131, context)
                                        .then((value) => showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: Wrap(
                                                  children: [
                                                    Text(
                                                      "PROFILE order has been Completed \n check other orders !",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ));
                                    // Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF84643D),
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Completed",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nanum_Myeongjo",
                                          fontSize: 18),
                                    ),
                                    height: 50,
                                    width: 130,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  // showDialog(
                                  //     barrierDismissible: false,
                                  //     context: context,
                                  //     builder: (context) => Center(
                                  //         child: CircularProgressIndicator()));
                                  await Provider.of<ChatProvider>(context,
                                          listen: false)
                                      .GetChat(order["client"]["_id"],
                                          "6626eb65ed54ccf5c1e7e8ed");
                                  // Navigator.pop(context);

                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPAgeTailor(
                                            chat: Provider.of<ChatProvider>(
                                                    context,
                                                    listen: false)
                                                .chat,
                                            IDCLIENT: order["client"]["_id"]),
                                      ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Chat",
                                    style: TextStyle(
                                        color: Color(0xFF84643D),
                                        fontFamily: "Nanum_Myeongjo",
                                        fontSize: 18),
                                  ),
                                  height: 50,
                                  width: 130,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        : order["status"] != "Completed"
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        OrderLogique.AcceptOrder(order["_id"],
                                                "Accepted", 3131, context)
                                            .then((value) => showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    content: Wrap(
                                                      children: [
                                                        Text(
                                                          "PROFILE order has been Acccepted \n check other orders !",
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF84643D),
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Nanum_Myeongjo",
                                              fontSize: 18),
                                        ),
                                        height: 50,
                                        width: 130,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      OrderLogique.RejectedOrder(
                                              order["_id"], "Rejected", context)
                                          .then((value) => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  content: Wrap(
                                                    children: [
                                                      Text(
                                                        "PROFILE order has been rejected \n check other orders !",
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Rejected",
                                        style: TextStyle(
                                            color: Color(0xFF84643D),
                                            fontFamily: "Nanum_Myeongjo",
                                            fontSize: 18),
                                      ),
                                      height: 50,
                                      width: 130,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) => Center(
                                        //         child:
                                        //             CircularProgressIndicator()));
                                        await Provider.of<ChatProvider>(context,
                                                listen: false)
                                            .GetChat(order["client"]["_id"],
                                                "6626eb65ed54ccf5c1e7e8ed");
                                        // Navigator.pop(context);
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatPAgeTailor(
                                                      chat: Provider.of<
                                                                  ChatProvider>(
                                                              context,
                                                              listen: false)
                                                          .chat,
                                                      IDCLIENT: order["client"]
                                                          ["_id"]),
                                            ));
                                        // .then((value) {
                                        // setState(() {
                                        //   print("cpppppppppppppppppppppp");
                                        //   _chat = Provider.of<ChatProvider>(context, listen: false).chat!;
                                        // });
                                        // });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF84643D),
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Chat",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Nanum_Myeongjo",
                                              fontSize: 18),
                                        ),
                                        height: 50,
                                        width: 130,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )
                  ],
                ),
              ))),
    );
  }
}
