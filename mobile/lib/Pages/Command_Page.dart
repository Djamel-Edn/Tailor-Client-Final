import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';
import 'package:projetfinprepa/LogiquesFonctions/ReviweLogique.dart';
import 'package:projetfinprepa/Pages/SousPages/ChatPage.dart';
import 'package:projetfinprepa/Providers/Chat.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:projetfinprepa/Widgets/CommandItem.dart';
import 'package:provider/provider.dart';

class MyCommandPage extends StatefulWidget {
  const MyCommandPage({super.key});

  @override
  State<MyCommandPage> createState() => _MyCommandPageState();
}

class _MyCommandPageState extends State<MyCommandPage> {
  List<double> leftPositions = [];
  var cntxg, cntxcircl;
  var commentcntrl = TextEditingController();
  var rating = 0.0;
  var cntxdialog;
  @override
  Widget build(BuildContext context) {
    cntxg = context;
    return Scaffold(
        backgroundColor: Color(0xFFFFF4DE),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFF4DE),
          shadowColor: Colors.black,
          elevation: 01,
          title: Text(
            "My Command",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Nanum_Myeongjo",
              fontWeight: FontWeight.w600,
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ClientProvider>(
              builder: (context, value, child) {
                return value.client != null
                    ? Expanded(
                        child: ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: value.client!.orders!.length + 1,
                        itemBuilder: (context, index) {
                          if (value.client!.orders!.length == 0) {
                            return Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  child: Text(
                                    "No Commands ",
                                    style: TextStyle(
                                        fontFamily: "Nanum_Myeongjo",
                                        fontSize: 32),
                                  )),
                            );
                          }
                          return value.client!.orders!.length != index
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Slidable(
                                    closeOnScroll: true,
                                    endActionPane: ActionPane(
                                        motion: StretchMotion(),
                                        children: [
                                          value.client!.orders![index].status ==
                                                  "Completed"
                                              ? Expanded(
                                                  child: InkWell(
                                                    overlayColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.transparent),
                                                    child: CircleAvatar(
                                                      radius: 27,
                                                      backgroundColor:
                                                          Color(0xFFD9D9D9),
                                                      child: Image.asset(
                                                        "images/Reviews.png",
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      showDialog(
                                                          context: cntxg,
                                                          builder:
                                                              (contextc) =>
                                                                  AlertDialog(
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xFFFCF9F6),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    title: Text(
                                                                      "${value.client!.orders![index].tailor.name}",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFF84643D),
                                                                          fontSize:
                                                                              18,
                                                                          fontFamily:
                                                                              "Nanum_Myeongjo"),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    content:
                                                                        Wrap(
                                                                      alignment:
                                                                          WrapAlignment
                                                                              .center,
                                                                      children: [
                                                                        RatingBar
                                                                            .builder(
                                                                          initialRating:
                                                                              0,
                                                                          minRating:
                                                                              1,
                                                                          itemSize:
                                                                              35,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          glowColor:
                                                                              Colors.transparent,
                                                                          // unratedColor:
                                                                          //     Color(
                                                                          //         0xFF84643D),

                                                                          allowHalfRating:
                                                                              true,
                                                                          itemCount:
                                                                              5,

                                                                          itemBuilder: (context, _) =>
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                                            child:
                                                                                Image.asset(
                                                                              "images/starss.png",
                                                                              fit: BoxFit.cover,
                                                                              color: Color(0xFF84643D),
                                                                            ),
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            this.rating =
                                                                                rating;
                                                                          },
                                                                          ignoreGestures:
                                                                              false,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              top: 12),
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                commentcntrl,
                                                                            keyboardType:
                                                                                TextInputType.multiline,
                                                                            maxLines:
                                                                                4,
                                                                            minLines:
                                                                                1,
                                                                            maxLength:
                                                                                120,
                                                                            decoration: InputDecoration(
                                                                                hintText: "Write a review ...",
                                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: Colors.black)),
                                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: Colors.black)),
                                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide(color: Colors.black))),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: [
                                                                      InkWell(
                                                                        overlayColor:
                                                                            MaterialStatePropertyAll(Colors.transparent),
                                                                        onTap:
                                                                            () async {
                                                                          // ratingq
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (contextq) {
                                                                                cntxdialog = contextq;
                                                                                return Center(
                                                                                  child: CircularProgressIndicator(),
                                                                                );
                                                                              });
                                                                          print(
                                                                              "snulllllllllll ${Provider.of<LocalDbProvider>(context, listen: false).id}");
                                                                          await RevLogique.CreateRev(
                                                                              Provider.of<LocalDbProvider>(context, listen: false).id,
                                                                              value.client!.orders![index].tailor.id,
                                                                              commentcntrl.text.trim(),
                                                                              rating,
                                                                              context);
                                                                          Navigator.pop(
                                                                              cntxdialog);
                                                                          Navigator.pop(
                                                                              contextc);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFF84643D),
                                                                            borderRadius:
                                                                                BorderRadius.circular(12),
                                                                          ),
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 5),
                                                                          child:
                                                                              Text(
                                                                            "Send",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 17,
                                                                                fontFamily: "Nanum_Myeongjo"),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        overlayColor:
                                                                            MaterialStatePropertyAll(Colors.transparent),
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              contextc);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          // decoration:
                                                                          //     BoxDecoration(
                                                                          //   color: Color(
                                                                          //       0xFF84643D),
                                                                          //   borderRadius:
                                                                          //       BorderRadius.circular(
                                                                          //           12),
                                                                          // ),
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 5),
                                                                          child:
                                                                              Text(
                                                                            "cancel",
                                                                            style: TextStyle(
                                                                                color: Color(0xFF84643D),
                                                                                fontSize: 17,
                                                                                fontFamily: "Nanum_Myeongjo"),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ));
                                                    },
                                                    // backgroundColor: Colors.transparent,
                                                    // icon: Icons.chat,
                                                    // foregroundColor: Colors.black,
                                                  ),
                                                )
                                              : SizedBox(),
                                          value.client!.orders![index].status ==
                                                      "Pending" ||
                                                  value.client!.orders![index]
                                                          .status ==
                                                      "Rejected"
                                              ? Expanded(
                                                  child: InkWell(
                                                    overlayColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.transparent),
                                                    onTap: () async {
                                                      showDialog(
                                                          context: cntxg,
                                                          builder: (contextc) {
                                                            cntxcircl =
                                                                contextc;
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Color(
                                                                    0xFF84643D),
                                                              ),
                                                            );
                                                          });
                                                      await OrderLogique
                                                          .DeletOrder(
                                                              value
                                                                  .client!
                                                                  .orders![
                                                                      index]
                                                                  .id,
                                                              context);
                                                      Navigator.pop(cntxcircl);
                                                      // await Provider.of<
                                                      //             OrderProvider>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .DeletOrder(
                                                      //         value.client!
                                                      //             .orders![index].id,
                                                      //         context);
                                                      // Navigator.pop(cntxcircl);
                                                      // await Provider.of<ChatProvider>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .GetChat(
                                                      //         Provider.of<LocalDbProvider>(
                                                      //                 context,
                                                      //                 listen: false)
                                                      //             .id,
                                                      //         value
                                                      //             .client!
                                                      //             .orders![index]
                                                      //             .tailor
                                                      //             .id!);
                                                      // if (cntxg.mounted) {
                                                      //   Navigator.pop(cntxcircl);
                                                      //   await Navigator.push(
                                                      //       cntxg,
                                                      //       MaterialPageRoute(
                                                      //         builder: (context) => ChatPAge(
                                                      //             chat: Provider.of<
                                                      //                         ChatProvider>(
                                                      //                     context,
                                                      //                     listen:
                                                      //                         false)
                                                      //                 .chat,
                                                      //             IdTailor: value
                                                      //                 .client!
                                                      //                 .orders![index]
                                                      //                 .tailor
                                                      //                 .id!),
                                                      //       ));
                                                      // }
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 27,
                                                      backgroundColor:
                                                          Color(0xFFD9D9D9),
                                                      child: Image.asset(
                                                        "images/Delete.png",
                                                      ),
                                                    ),

                                                    // backgroundColor: Colors.transparent,
                                                    // icon: Icons.chat,
                                                    // foregroundColor: Colors.black,
                                                  ),
                                                )
                                              : SizedBox(),
                                          value.client!.orders![index].status !=
                                                  "Rejected"
                                              ? Expanded(
                                                  child: InkWell(
                                                    overlayColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.transparent),
                                                    onTap: () async {
                                                      showDialog(
                                                          context: cntxg,
                                                          builder: (contextc) {
                                                            cntxcircl =
                                                                contextc;
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Color(
                                                                    0xFFFFF4DE),
                                                              ),
                                                            );
                                                          });
                                                      await Provider.of<
                                                                  ChatProvider>(
                                                              context,
                                                              listen: false)
                                                          .GetChat(
                                                              Provider.of<LocalDbProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .id,
                                                              value
                                                                  .client!
                                                                  .orders![
                                                                      index]
                                                                  .tailor
                                                                  .id!);
                                                      if (cntxg.mounted) {
                                                        Navigator.pop(
                                                            cntxcircl);
                                                        await Navigator.push(
                                                            cntxg,
                                                            MaterialPageRoute(
                                                              builder: (context) => ChatPAge(
                                                                  chat: Provider.of<
                                                                              ChatProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .chat,
                                                                  IdTailor: value
                                                                      .client!
                                                                      .orders![
                                                                          index]
                                                                      .tailor
                                                                      .id!),
                                                            ));
                                                      }
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 27,
                                                      backgroundColor:
                                                          Color(0xFFD9D9D9),
                                                      child: Image.asset(
                                                        "images/Comments.png",
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          // SlidableAction(
                                          //   onPressed: (context) async {},
                                          //   backgroundColor: Colors.transparent,
                                          //   icon: Icons.chat,
                                          //   foregroundColor: Colors.red,
                                          // )
                                        ]),
                                    // child: Text(element),

                                    child: value.client!.orders!.length != index
                                        ? Container(
                                            child: CommandItem(
                                              order:
                                                  value.client!.orders![index],
                                            ),
                                          )
                                        : SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                          ),
                                  ),
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                );
                        },
                      ))
                    : Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF84643D),
                        ),
                      );
              },
            ),
          ],
        ));
  }
}
