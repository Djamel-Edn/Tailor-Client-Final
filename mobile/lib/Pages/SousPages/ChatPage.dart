import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:projetfinprepa/Data/Chat_Class.dart';
import 'package:projetfinprepa/Data/Message_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Providers/Chat.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart';

class ChatPAge extends StatefulWidget {
  String IdTailor;
  Chat? chat;

  ChatPAge({super.key, required this.IdTailor, required this.chat});

  @override
  State<ChatPAge> createState() => _ChatPAgeState();
}

class _ChatPAgeState extends State<ChatPAge> {
  TextEditingController _controller = TextEditingController();
  File? image;
  Uint8List? bytes;
  late IO.Socket socket;
  Tailor? tailor;
  @override
  void connect() {
    socket = IO.io("https://tailor-client-5cqi.onrender.com", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    print("connected jjjjjjjjjjjj");

    socket.emit(
        "addNewUser", Provider.of<LocalDbProvider>(context, listen: false).id);
    socket.onConnect((data) {
      socket.on("message", (data) {
        // pushmessage(data);
        print("qqqqqqqqqqqqqqqqqqqqqqqqqq in client account");
        Future.delayed(Duration(seconds: 3), () {
          print("after 3 s");
          if (mounted)
            setState(() {
              Provider.of<ChatProvider>(context, listen: false).SetMessage(
                  Message(
                      ChatId: data["message"]["ChatId"],
                      senderId: data["message"]["senderId"],
                      text: data["message"]["text"],
                      images: data["message"]["images"],
                      date: DateTime.now()));
            });
        });
      });
    });
  }

  void pushmessage(data) {
    Message msg = Message(
        ChatId: data["message"]["ChatId"],
        senderId: data["message"]["SenderId"],
        text: data["message"]["text"],
        images: data["message"]["images"],
        date: DateTime.now());
    setState(() {
      widget.chat!.messages.add(msg);
    });
  }

  void sendmessage(Message msg, IdReciever) {
    print(
        "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq socjet  ${msg.senderId} $IdReciever");
    Map<String, dynamic> msgobj = {
      "ChatId": msg.ChatId,
      "senderId": msg.senderId,
      "text": msg.text,
      "images": msg.images,
      "date": msg.date.toString()
    };
    socket.emit("message", {
      "message": msgobj,
      "RecieverId": IdReciever,
    });
    print("id send message");
  }

  void initState() {
    Provider.of<TailorsProvider>(context, listen: false)
        .GetTailor(widget.IdTailor);
    connect();

    // Provider.of<ChatProvider>(context, listen: false)
    //     .GetChat(Provider.of<LocalDbProvider>(context, listen: false).id,
    //         widget.IdTailor)
    //     .whenComplete(() => setState(() {
    //           print("cmppppppppppppppppppppp");
    //           _chat = Provider.of<ChatProvider>(context, listen: false).chat;
    //         }));
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          surfaceTintColor: Color(0xFFFCF9F6),
          shadowColor: Colors.black,
          backgroundColor: Color(0xFFFCF9F6),
          leadingWidth: 120,
          title: widget.chat != null
              ? Text("${widget.chat!.tailor.name}")
              : Text("Tailor name"),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () async {
                  final Uri url = Uri(
                      scheme: 'tel',
                      path:
                          '${Provider.of<TailorsProvider>(context, listen: false).tailor!.phone!.toString()}');
                  await launchUrl(url);
                },
                icon: Icon(Icons.phone)),
            IconButton(
                onPressed: () {
                  print("object");
                },
                icon: Icon(Icons.linear_scale_sharp)),
          ],
          leading: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              widget.chat != null
                  ? widget.chat!.tailor.profilePicture != "/../utils/pp.png"
                      ? CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("images/profileimage.png"))
                      : CircleAvatar(
                          radius: 25,
                          backgroundImage: MemoryImage(base64Decode(
                              widget.chat!.tailor.profilePicture!)),
                        )
                  : CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("images/profileimage.png"))
            ],
          ),
          toolbarHeight: 70,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Consumer<ChatProvider>(
            builder: (context, value, child) {
              return Column(children: [
                Provider.of<ChatProvider>(context, listen: false).chat != null
                    ? Expanded(
                        child: GroupedListView(
                        reverse: true,
                        order: GroupedListOrder.DESC,
                        elements: value.chat!.messages,
                        groupBy: (element) => DateTime(
                          element.date.year,
                          element.date.month,
                          element.date.day,
                        ),
                        groupHeaderBuilder: (element) => SizedBox(
                          height: 40,
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    style: TextStyle(color: Colors.black),
                                    DateFormat.yMMMd().format(DateTime(
                                        element.date.year,
                                        element.date.month,
                                        element.date.day)))
                                // Text(),
                                ),
                          ),
                        ),
                        itemBuilder: (context, element) {
                          return MessageUi(message: element);
                        },
                      ))
                    : Expanded(
                        child: Center(child: CircularProgressIndicator())),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            final imagePicker = ImagePicker();
                            var pickedimage = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedimage != null) {
                              bytes = File(pickedimage.path).readAsBytesSync();
                              List images = [];
                              images.add(base64Encode(bytes!));
                              await value.PostMessageInChat(
                                      Provider.of<LocalDbProvider>(context,
                                              listen: false)
                                          .id,
                                      widget.chat!.id,
                                      _controller.text.trim(),
                                      images)
                                  .then((val) {
                                _controller.text = "";

                                print("sendnia message .....${val.images}");

                                sendmessage(val, widget.IdTailor);
                              });
                            }
                          },
                          icon: Icon(
                            Icons.image,
                            size: 40,
                          )),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                hintText: "write your message",
                                fillColor: Color(0XFFD9D9D9).withAlpha(90),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            print(
                                "zzzzzzzzzzzzzz ${Provider.of<LocalDbProvider>(context, listen: false).id}");
                            if (_controller.text.trim() != "") {
                              if (widget.chat != null) {
                                print("send image");

                                value.PostMessageInChat(
                                    Provider.of<LocalDbProvider>(context,
                                            listen: false)
                                        .id,
                                    widget.chat!.id,
                                    _controller.text.trim(),
                                    []).then((value) {
                                  _controller.text = "";
                                  sendmessage(value, widget.IdTailor);
                                });
                              }
                            }
                          },
                          icon: Image.asset("images/sendIcon.png"))
                    ],
                  ),
                )
              ]);
            },
          ),
        ),
      )),
    );
  }
}

class MessageUi extends StatelessWidget {
  Message message;
  MessageUi({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    var MYID = Provider.of<LocalDbProvider>(context, listen: false).id;
    if (MYID != null) {
      return message.images!.length == 0
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
              alignment: message.senderId == MYID
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: message.text != ""
                  ? Container(
                      decoration: BoxDecoration(
                        color: message.senderId == MYID
                            ? Color(0xFFA38E7E).withOpacity(0.9)
                            : Color(0xFFDDD0B9).withOpacity(0.8),
                        borderRadius: message.senderId == MYID
                            ? BorderRadius.only(
                                topRight: Radius.circular(14),
                                topLeft: Radius.circular(14),
                                bottomLeft: Radius.circular(14))
                            : BorderRadius.only(
                                topRight: Radius.circular(14),
                                topLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${message.text}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  "${message.date.hour}:${message.date.minute}",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Color(0xFF54361E), fontSize: 10),
                                ),
                                message.senderId == MYID
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3, top: 3),
                                        child: Image.asset(
                                          "images/seenIcon.png",
                                          height: 8,
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              alignment: message.senderId == MYID
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Wrap(children: [
                      Image.memory(
                        base64Decode(message.images![0]),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ]),
                  ),
                  Container(
                    // alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: message.senderId == MYID
                          ? Color(0xFFA38E7E).withOpacity(0.9)
                          : Color(0xFFDDD0B9).withOpacity(0.8),
                      borderRadius: message.senderId == MYID
                          ? BorderRadius.only(
                              topRight: Radius.circular(14),
                              topLeft: Radius.circular(14),
                              bottomLeft: Radius.circular(14))
                          : BorderRadius.only(
                              topRight: Radius.circular(14),
                              topLeft: Radius.circular(14),
                              bottomRight: Radius.circular(14)),
                    ),
                    child: message.text != ""
                        ? Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${message.text}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "${message.date.hour}:${message.date.minute}",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Color(0xFF9E7B61), fontSize: 10),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            );
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFFF4DE),
        ),
      );
    }
  }
}


// groupedlistbiew pour grouper widget by enithing likedate or solething else 