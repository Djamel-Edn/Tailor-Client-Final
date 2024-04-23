import 'package:flutter/material.dart';

class GridWidgetProduct {
  List<String> images;
  List<Color> colors;
  GridWidgetProduct({required this.images, required this.colors});

  Widget getGrid() {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 0.2,
                          spreadRadius: 0.3,
                          color: Color(0xF084643D),
                          offset: Offset(0, 1),
                          blurStyle: BlurStyle.inner)
                    ],
                    border: Border.all(
                      color: Color(0xF084643D),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        colors[index],
                        Color(0xFFE6D3CD),
                      ],
                      stops: [
                        0.01,
                        0.4,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    image: DecorationImage(image: AssetImage(images[index]))),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFFCF9F6),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          color: Colors.transparent,
                          offset: Offset(0, 1),
                          blurStyle: BlurStyle.solid)
                    ],
                    border: Border.all(color: Color(0xF084643D)),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: ListTile(
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFD9D9D9),
                        radius: 15,
                        child: Icon(
                          Icons.person,
                          color: Color(0xFF54361E),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFD9D9D9)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "MARIA Tayl",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "JejuGothic",
                                  color: Color(0xFF54361E)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "White suit ",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontFamily: "JejuGothic"),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 22,
                            color: Colors.yellow,
                          ),
                          Text(
                            "4,7",
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF54361E)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
