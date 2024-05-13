import 'package:flutter/material.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';

class DetailPageNewModel extends StatelessWidget {
  var order;
  DetailPageNewModel({super.key, required this.order});

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
                  icon: Icon(Icons.close),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Client"),
                          SizedBox(
                            width: 15,
                          ),
                          Text("${order["client"]["name"]}"),
                        ],
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 1 / 3,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            order["postStyle"],
                            fit: BoxFit.cover,
                          )),
                      Container(
                        height: 390,
                        child: ListView.builder(
                          itemCount: order["questionnaire"].length,
                          itemBuilder: (context, index) {
                            return Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  order["questionnaire"][index]["qst"],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Nanum_Myeongjo",
                                    fontSize: 23,
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFC0AF9A).withAlpha(60)),
                                    padding: EdgeInsets.all(8),
                                    child: order["questionnaire"][index]["ansr"]
                                            .toString()
                                            .startsWith("Color")
                                        ? CircleAvatar(
                                            backgroundColor: Color(int.parse(
                                                order["questionnaire"][index]
                                                        ["ansr"]
                                                    .toString()
                                                    .substring(6, 16))),
                                          )
                                        : Text(
                                            order["questionnaire"][index]
                                                ["ansr"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Nanum_Myeongjo",
                                              fontSize: 18,
                                            ),
                                          ))
                              ],
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("accept ${order["_id"]}");
                          // Provider.of<OrderProvider>(context, listen: false)
                          //     .UpdateOrder(order["_id"], "Accepted", 3131);
                          OrderLogique.AcceptOrder(
                              order["_id"], "Accepted", 3131, context);
                        },
                        child: Container(
                          child: Text("Accept"),
                          height: 60,
                          width: 130,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("accept ${order["_id"]}");
                          // Provider.of<OrderProvider>(context, listen: false)
                          //     .UpdateOrder(order["_id"], "Accepted", 3131);
                          OrderLogique.RejectedOrder(
                              order["_id"], "Rejected", context);
                        },
                        child: Container(
                          child: Text("Rejected"),
                          height: 60,
                          width: 130,
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
