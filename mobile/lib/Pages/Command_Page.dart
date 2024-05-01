import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:projetfinprepa/Pages/SousPages/ChatPage.dart';
import 'package:projetfinprepa/Widgets/CommandItem.dart';

class MyCommandPage extends StatefulWidget {
  const MyCommandPage({super.key});

  @override
  State<MyCommandPage> createState() => _MyCommandPageState();
}

class _MyCommandPageState extends State<MyCommandPage> {
  List<double> leftPositions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCF9F6),
        appBar: AppBar(
          backgroundColor: Color(0xFFFCF9F6),
          shadowColor: Colors.black,
          elevation: 01,
          title: Text("My Command"),
          toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: GroupedListView(
            groupBy: (element) => DateTime(2024),
            elements: ["zzzzzzzz", "zzzzzzzzzzzz"],
            groupHeaderBuilder: (element) {
              return Text("data");
            },
            itemBuilder: (context, element) {
              return Slidable(
                closeOnScroll: true,
                endActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPAge(),
                          ));
                    },
                    backgroundColor: Color(0xFFFCF9F6),
                    icon: Icons.arrow_forward_ios_rounded,
                  )
                ]),
                // child: Text(element),

                child: CommandItem(),
              );
            },
          ),
        ));
  }
}
