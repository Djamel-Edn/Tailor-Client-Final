import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:projetfinprepa/Data/Message_Class.dart';
import 'package:projetfinprepa/IpConfig/Ipconfig.dart';
import 'package:projetfinprepa/Providers/Chat.dart';
import 'package:provider/provider.dart';

class ChatPAge extends StatefulWidget {
  const ChatPAge({super.key});

  @override
  State<ChatPAge> createState() => _ChatPAgeState();
}

class _ChatPAgeState extends State<ChatPAge> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false).GetChat();
    print(
        "aaaaaaaaaaaaaaaaaaaqqqqqqqqqqqqqqqq ${Provider.of<ChatProvider>(context, listen: false).chat}");
    super.initState();
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
          title: Text("sss"),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.phone)),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.linear_scale_sharp)),
          ],
          leading: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              CircleAvatar(
                radius: 25,
              )
              // : CircleAvatar(
              //     radius: 25,
              //     backgroundImage: MemoryImage(base64Decode(
              //         Provider.of<ChatProvider>(context, listen: false)
              //             .chat!
              //             .tailor
              //             .profilePicture
              //             .substring(23))),
              //   ),
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
                                child: Text(DateFormat.yMMMd().format(DateTime(
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.image,
                            size: 40,
                          )),
                      Expanded(
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
                      IconButton(
                          onPressed: () {
                            if (_controller.text.trim() != "") {
                              value.PostMessageInChat(
                                      IPCONFIG.ClientId,
                                      "662eae3634b1ca8d98f2368d",
                                      _controller.text.trim())
                                  .then((value) => _controller.text = "");
                            }
                          },
                          icon: Icon(
                            Icons.telegram,
                            size: 40,
                          ))
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
  MessageUi({super.key, required this.message});
  String MYID = IPCONFIG.ClientId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
      alignment: message.senderId == MYID
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
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
              Text(
                "${message.date.hour}:${message.date.minute}",
                overflow: TextOverflow.clip,
                style: TextStyle(color: Color(0xFF9E7B61), fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// groupedlistbiew pour grouper widget by enithing likedate or solething else 