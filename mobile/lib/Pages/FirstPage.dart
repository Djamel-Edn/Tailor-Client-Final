import 'package:flutter/material.dart';
import 'package:projetfinprepa/Pages/Command_Page.dart';
import 'package:projetfinprepa/Pages/Search_Page.dart';
import 'package:projetfinprepa/Pages/tstthreeD.dart';
import 'package:projetfinprepa/Providers/Models.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:projetfinprepa/tests/Home_Page.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List Pages = [HomePage(), SearchPage(), parx(), MyCommandPage()];
  int currentpage = 0;
  @override
  void initState() {
    Provider.of<ModelsProvider>(context, listen: false).GetAllModels();
    Provider.of<ClientProvider>(context, listen: false)
        .GetALlAboutCurrentUser();
    Provider.of<TailorsProvider>(context, listen: false).GetAllTailors();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: MediaQuery.of(context).size.height * 0.0899,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.black),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.black,
            currentIndex: currentpage,
            showUnselectedLabels: false,
            elevation: 14,
            unselectedItemColor: Colors.white,
            onTap: (value) {
              currentpage = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                        color: currentpage != 0
                            ? Colors.transparent
                            : Colors.white,
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        "images/Home (5).png",
                        color: currentpage != 0 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                      color:
                          currentpage != 1 ? Colors.transparent : Colors.white,
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset(
                      "images/Search1.png",
                      color: currentpage != 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                // images/Search1.png
                label: "Search",
              ),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 3),
                    decoration: BoxDecoration(
                        color: currentpage != 2
                            ? Colors.transparent
                            : Colors.white,
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.1),
                      child: Image.asset(
                        "images/image 5 (3).png",
                        color: currentpage != 2 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  // images/image 5 (3).png
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 3),
                    decoration: BoxDecoration(
                        color: currentpage != 3
                            ? Colors.transparent
                            : Colors.white,
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        "images/image 6 (1).png",
                        color: currentpage != 3 ? Colors.white : Colors.black,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // images/image 6 (1).png
                  label: "Command"),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 3),
                    decoration: BoxDecoration(
                        color: currentpage != 4
                            ? Colors.transparent
                            : Colors.white,
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        "images/Customer (1).png",
                        color: currentpage != 4 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  // images/Customer (1).png
                  label: "Profil")
            ],
          ),
        ),
        backgroundColor: Color(0xFFFCF9F6),
        body: AnimatedSwitcher(
          child: Pages[currentpage],
          transitionBuilder: (child, animation) {
            // var tween = Tween(begin: Offset(0.2, 0), end: Offset(0, 0));
            // var offsetAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          duration: Duration(milliseconds: 700),
        ),
      )),
    );
  }
}
