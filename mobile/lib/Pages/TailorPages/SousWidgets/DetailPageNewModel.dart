import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';
import 'package:projetfinprepa/Pages/TailorPages/ChatPageTailor.dart';
import 'package:projetfinprepa/Providers/Chat.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:provider/provider.dart';

class DetailPageNewModel extends StatelessWidget {
  var order;
  DetailPageNewModel({super.key, required this.order});
  var cntxcircl;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 80,
                title: Text("Detail Page"),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Client",
                            style: TextStyle(
                                fontSize: 22, fontFamily: "Nanum_Myeongjo"),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "${order["client"]["name"]}",
                            style: TextStyle(
                                fontSize: 22, fontFamily: "Nanum_Myeongjo"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 1 / 3,
                          width: MediaQuery.of(context).size.width,
                          child: order["postStyle"].toString().length < 100
                              ? Image.asset(
                                  order["postStyle"],
                                  fit: BoxFit.cover,
                                )
                              : Image.memory(
                                  base64Decode(order["postStyle"]),
                                  fit: BoxFit.cover,
                                )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1 / 3,
                        child: ListView.builder(
                          itemCount: order["questionnaire"].length + 1,
                          itemBuilder: (context, index) {
                            return order["questionnaire"].length != index
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            order["questionnaire"][index]
                                                ["qst"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Nanum_Myeongjo",
                                              fontSize: 23,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(0xFFC0AF9A)
                                                      .withAlpha(60)),
                                              padding: EdgeInsets.all(8),
                                              child: order["questionnaire"]
                                                          [index]["ansr"]
                                                      .toString()
                                                      .startsWith("Color")
                                                  ? CircleAvatar(
                                                      backgroundColor: Color(
                                                          int.parse(
                                                              order["questionnaire"]
                                                                          [
                                                                          index]
                                                                      ["ansr"]
                                                                  .toString()
                                                                  .substring(
                                                                      6, 16))),
                                                    )
                                                  : order["questionnaire"]
                                                              [index]["ansr"] !=
                                                          ""
                                                      ? Text(
                                                          order["questionnaire"]
                                                              [index]["ansr"],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "Nanum_Myeongjo",
                                                            fontSize: 18,
                                                          ),
                                                        )
                                                      : Text(
                                                          "No answer",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "Nanum_Myeongjo",
                                                            fontSize: 18,
                                                          ),
                                                        )),
                                        )
                                      ],
                                    ),
                                  )
                                : order["status"] == "Pending"
                                    ? Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  OrderLogique.AcceptOrder(
                                                      order["_id"],
                                                      "Accepted",
                                                      3131,
                                                      context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF84643D),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFF84643D)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Accept",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          "Nanum_Myeongjo",
                                                      fontSize: 23,
                                                    ),
                                                  ),
                                                  height: 55,
                                                  width: 130,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  OrderLogique.RejectedOrder(
                                                      order["_id"],
                                                      "Rejected",
                                                      context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFF84643D)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Rejected",
                                                    style: TextStyle(
                                                      color: Color(0xFF84643D),
                                                      fontFamily:
                                                          "Nanum_Myeongjo",
                                                      fontSize: 23,
                                                    ),
                                                  ),
                                                  height: 55,
                                                  width: 130,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : order["status"] == "Accepted"
                                        ? Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      OrderLogique.AcceptOrder(
                                                          order["_id"],
                                                          "Completed",
                                                          3131,
                                                          context);
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF84643D),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFF84643D)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Completed",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Nanum_Myeongjo",
                                                          fontSize: 23,
                                                        ),
                                                      ),
                                                      height: 55,
                                                      width: 130,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (contextc) {
                                                            cntxcircl =
                                                                contextc;
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                              color: Color(
                                                                  0xFFFFF4DE),
                                                            ));
                                                          });
                                                      await Provider.of<
                                                                  ChatProvider>(
                                                              context,
                                                              listen: false)
                                                          .GetChat(
                                                              order["client"]
                                                                  ["_id"],
                                                              Provider.of<LocalDbProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .id);
                                                      Navigator.pop(cntxcircl);

                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => ChatPAgeTailor(
                                                                chat: Provider.of<
                                                                            ChatProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .chat,
                                                                IDCLIENT: order[
                                                                        "client"]
                                                                    ["_id"]),
                                                          ));
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFF84643D)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Chat",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF84643D),
                                                          fontFamily:
                                                              "Nanum_Myeongjo",
                                                          fontSize: 23,
                                                        ),
                                                      ),
                                                      height: 55,
                                                      width: 130,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (contextc) {
                                                            cntxcircl =
                                                                contextc;
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                              color: Color(
                                                                  0xFFFFF4DE),
                                                            ));
                                                          });
                                                      await Provider.of<
                                                                  ChatProvider>(
                                                              context,
                                                              listen: false)
                                                          .GetChat(
                                                              order["client"]
                                                                  ["_id"],
                                                              Provider.of<LocalDbProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .id);
                                                      Navigator.pop(cntxcircl);

                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => ChatPAgeTailor(
                                                                chat: Provider.of<
                                                                            ChatProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .chat,
                                                                IDCLIENT: order[
                                                                        "client"]
                                                                    ["_id"]),
                                                          ));
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF84643D),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFF84643D)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Chat",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Nanum_Myeongjo",
                                                          fontSize: 23,
                                                        ),
                                                      ),
                                                      height: 55,
                                                      width: 130,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                          },
                        ),
                      ),

                      // la meme choose pour les autres operations......
                    ],
                  ),
                ),
              )),
        ));
  }
}
