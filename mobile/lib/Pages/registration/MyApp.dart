import 'package:flutter/material.dart';
import 'package:projetfinprepa/Pages/FirstPage.dart';
import 'package:projetfinprepa/Pages/TailorPages/FirstPageTailor.dart';
import 'package:projetfinprepa/Pages/registration/sign.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyAppHia extends StatefulWidget {
  @override
  State<MyAppHia> createState() => _MyAppHiaState();
}

class _MyAppHiaState extends State<MyAppHia> {
  String? id;
  late IO.Socket socket;

  void ConnectOrderRealTime() {
    socket = IO.io("https://tailor-client-5cqi.onrender.com", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    print(
        "connected on order real time aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa a ${Provider.of<LocalDbProvider>(context, listen: false).id}");
    socket.emit(
        "addNewUser", Provider.of<LocalDbProvider>(context, listen: false).id);
    socket.onConnect((data) {
      print("connected on order real time");
      socket.on("newOrder", (data) {
        print(
            'rrrrrrpppppppppppppppppppppppppppppppppppppppppppppppppppppp weeeeeeeeeyyyyyyyyyyyyyyyyyyyyyyy');
        print("on emit order..........................$data");
        print(mounted);
        // if (mounted)
        //   setState(() {
        //     Provider.of<ChatProvider>(context, listen: false).SetMessage(
        //         Message(
        //             ChatId: data["message"]["ChatId"],
        //             senderId: data["message"]["senderId"],
        //             text: data["message"]["text"],
        //             images: data["message"]["images"],
        //             date: DateTime.now()));
        //   });
        // print(mounted);
        // if (mounted) {
      });
    });
  }

  @override
  void initState() {
    Provider.of<LocalDbProvider>(context, listen: false)
        .GetTYPELocal()
        .whenComplete(() {
      Provider.of<LocalDbProvider>(context, listen: false)
          .GetIDLocal()
          .whenComplete(() async {
        setState(() {
          ConnectOrderRealTime();
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<LocalDbProvider>(context, listen: false).id == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GetStarted(),
      );
    } else {
      if (Provider.of<LocalDbProvider>(context, listen: false).type ==
          "CLIENT") {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirstPage(),
        );
      } else {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirstPageTailor(),
        );
      }
    }
    // print("ssssssssssssss");
    // Register.GetLocalDBId();
    // return const MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: GetStarted(),
    // );
  }
}

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F6),
      body: Stack(children: [
        Expanded(
          child: PageView(controller: _controller, children: [
            SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0, left: 90),
                        child: Image.asset('images/shad.png'),
                      ),
                      Center(
                        child: Stack(children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 177,
                              left: 50,
                              right: 40,
                              bottom: 340.17,
                            ),
                            width: 294,
                            height: 294,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 177,
                              left: 50,
                              right: 40,
                              bottom: 340.17,
                            ),
                            width: 294,
                            height: 294,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Start ',
                                      style: TextStyle(
                                        color: Color(0xFF84643D),
                                        fontFamily: 'LavishlyYours',
                                        fontSize: 64,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 30,
                                  right: 0,
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'finding your',
                                      style: TextStyle(
                                        color: Color(0xFF84643D),
                                        fontFamily: 'LavishlyYours',
                                        fontSize: 38,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  left: 30,
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Version the',
                                      style: TextStyle(
                                        color: Color(0xFF84643D),
                                        fontFamily: 'LavishlyYours',
                                        fontSize: 64,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 160,
                                  left: 25,
                                  child: Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                        color: Color(0xFF84643D),
                                        fontFamily: 'LavishlyYours',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'best fashion ',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Style ',
                                          style: TextStyle(
                                            fontSize: 64,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 50, left: 35, bottom: 472.54),
                        child: Image.asset('images/bra.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 276, bottom: 224, left: 80, right: 0),
                        child: Image.asset('images/khit.png'),
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 0, left: 0, right: 62, top: 410),
                            child: Image.asset('images/mimi.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 62, top: 538),
                            child: Image.asset('images/lbsa.png'),
                          ),
                          Positioned(
                            bottom: 60,
                            right: 0,
                            left: 160,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => sign()),
                                );
                              },
                              child: Image.asset('images/Group.png'),
                            ),
                          ),
                        ],
                      ),
                    ])
                  ]),
            ),
            page3(),
            page4()
          ]),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 370,
            ),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                dotColor: Color.fromARGB(255, 194, 150, 95),
                activeDotColor: Color(0xFF84643D),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class ggetStarted extends StatelessWidget {
  const ggetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F6),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 90),
          child: Image.asset('images/shad.png'),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 0, left: 0, right: 62, top: 410),
          child: Image.asset('images/mimi.png'),
        ),
      ]),
    );
  }
}

class page3 extends StatelessWidget {
  const page3({super.key});

  @override
  Widget build(BuildContext context) {
    return ggetStarted();
  }
}

class page4 extends StatelessWidget {
  const page4({super.key});

  @override
  Widget build(BuildContext context) {
    return ggetStarted();
  }
}
