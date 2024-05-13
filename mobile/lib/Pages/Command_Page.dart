import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projetfinprepa/Pages/SousPages/ChatPage.dart';
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
  @override
  Widget build(BuildContext context) {
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
          children: [
            Consumer<ClientProvider>(
              builder: (context, value, child) {
                print("qqqqqqqqqqqqqqq ${value.client}");
                return Expanded(
                    child: ListView.builder(
                  itemCount: 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slidable(
                        closeOnScroll: true,
                        endActionPane:
                            ActionPane(motion: StretchMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPAge(
                                        IdTailor: value
                                            .client!.orders![index].tailor.id!),
                                  ));
                            },
                            backgroundColor: Color(0xFFFCF9F6),
                            icon: Icons.arrow_forward_ios_rounded,
                          )
                        ]),
                        // child: Text(element),

                        child: CommandItem(
                          order: value.client!.orders![index],
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ],
        ));
  }
}
