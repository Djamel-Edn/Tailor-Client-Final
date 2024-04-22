import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/category.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: ListView(
                  children: [
                    Message(
                      sender: "sido",
                      message: "salam alikoum",
                    ),
                    Message(
                      sender: "moha",
                      message: "wa alikoum el salam",
                    ),
                    Message(
                      sender: "sido",
                      message: "wach khou cv ?!",
                    ),
                    Message(
                      sender: "moha",
                      message: "cv bien alhamdolah w nat ?!",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Tapez ici",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class Message extends StatelessWidget {
  String sender;
  String message;
  Message({required this.sender, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sender == CategoryData.currentuser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: sender == CategoryData.currentuser
            ? EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.3, bottom: 10)
            : EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.3, bottom: 10),
        child: Material(
          color: sender == CategoryData.currentuser
              ? Colors.amber
              : Colors.black12,
          borderRadius: sender == CategoryData.currentuser
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("$message"),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    "${DateTime.now().toString().substring(10, 16)}",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}

MessageTile(context) {
  return const Column(
    children: [
      Material(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Text("Hello sido"),
      ),
      // Text(
      //   "${DateTime.now().toString().substring(10, 16)}",
      //   style: TextStyle(fontSize: 10),
      // ),
    ],
  );
}
