import 'package:flutter/material.dart';
import 'package:projetfinprepa/Providers/Page_current.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PageCurrent>(
      builder: (context, pageCurrent, child) {
        return Container(
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 60,
          decoration: BoxDecoration(
              color: Color(0xFF84643D),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: pageCurrent.pagecurrent == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "images/HomeIcon.png",
                          color: Colors.white,
                        ),
                      )
                    : Text("data"),
                onTap: () {
                  pageCurrent.pagecurrent = 0;
                  print("uuuuuu");
                },
              ),
              InkWell(
                child: Image.asset("images/SearchIcon.png"),
                onTap: () {
                  pageCurrent.pagecurrent = 1;
                },
              ),
              InkWell(
                child: Image.asset("images/Creationstylcon.png"),
                onTap: () {
                  pageCurrent.pagecurrent = 1;
                },
              ),
              InkWell(child: Image.asset("images/CarreIcon.png")),
              InkWell(child: Image.asset("images/ProfilIcon.png"))
            ],
          ),
        );
      },
    );
  }
}
