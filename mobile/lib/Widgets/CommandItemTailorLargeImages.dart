import 'dart:convert';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';

class CommandItemTailorLargeImages extends StatefulWidget {
  var order;
  CommandItemTailorLargeImages({required this.order});

  @override
  State<CommandItemTailorLargeImages> createState() => _CommandItemState();
}

class _CommandItemState extends State<CommandItemTailorLargeImages> {
  late AppinioSwiperController controller;
  // List<String> AllSpeciallite = [];

  @override
  void initState() {
    controller = AppinioSwiperController();
    controller.addListener(() {});
    // for (var spe in widget.order.models!) {
    //   AllSpeciallite.add(spe.speciality);

    // }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color(0xFF3C2F1F))),
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          widget.order["posts"]!.length != 0
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1 / 3,
                  decoration: BoxDecoration(),
                  child: AppinioSwiper(
                    controller: controller,
                    cardCount: widget.order["posts"]!.length,
                    duration: Duration(milliseconds: 120),
                    loop: true,
                    backgroundCardOffset: Offset(0, 0),
                    cardBuilder: (context, index) {
                      return ClipRRect(
                          child: Image.memory(
                        base64Decode(widget.order["posts"]![index]["image"]),
                        fit: BoxFit.cover,
                      ));
                    },
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1 / 3,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        widget.order["postStyle"]!,
                        fit: BoxFit.cover,
                      )),
                ),
          SizedBox(
            width: 10,
          ),
          Positioned(
            right: 10,
            child: widget.order["posts"]!.length > 1
                ? InkWell(
                    onTap: () {
                      controller.swipeLeft();
                    },
                    child: Container(
                      height: 40,
                      child: Image.asset(
                        "images/swipe.png",
                        color: Colors.black,
                      ),
                    ))
                : SizedBox(),
          )
        ],
      ),
    );
  }
}






  //  cardCount:
  //               widget.order.models == null ? 0 : widget.order.models!.length