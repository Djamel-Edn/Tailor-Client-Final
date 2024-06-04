import 'package:flutter/material.dart';
import 'package:projetfinprepa/Pages/TailorPages/Command_PageTailor.dart';
import 'package:projetfinprepa/Pages/TailorPages/Home_PageTailor.dart';
import 'package:projetfinprepa/Pages/TailorPages/PostModel.dart';
import 'package:projetfinprepa/Pages/Tailorprofile/profile.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

class FirstPageTailor extends StatefulWidget {
  const FirstPageTailor({super.key});

  @override
  State<FirstPageTailor> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPageTailor> {
  List Pages = [
    HomePageTailor(),
    PostModelPage(),
    MyCommandPageTailor(),
    TailorProfilePage(),
  ];
  int currentpage = 0;
  @override
  void initState() {
    // Provider.of<ModelsProvider>(context, listen: false).GetAllModels();

    // Provider.of<ClientProvider>(context, listen: false)
    //     .GetALlAboutCurrentUser();
    Provider.of<TailorsProvider>(context, listen: false)
        .GetTailor(Provider.of<LocalDbProvider>(context, listen: false).id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: MediaQuery.of(context).size.height * 0.0899,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF84643D)),
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
                            : Colors.transparent,
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
                        color: currentpage != 1
                            ? Colors.transparent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.1),
                      child: Icon(
                        Icons.add,
                        color: currentpage != 1 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  // images/image 5 (3).png
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 3),
                    decoration: BoxDecoration(
                        color: currentpage != 2
                            ? Colors.transparent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        "images/image 6 (1).png",
                        color: currentpage != 2 ? Colors.white : Colors.black,
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
                        color: currentpage != 3
                            ? Colors.transparent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        "images/Customer (1).png",
                        color: currentpage != 3 ? Colors.white : Colors.black,
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
