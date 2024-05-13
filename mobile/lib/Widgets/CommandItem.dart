import 'dart:convert';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Order_class.dart';

class CommandItem extends StatefulWidget {
  Order order;
  CommandItem({required this.order});

  @override
  State<CommandItem> createState() => _CommandItemState();
}

class _CommandItemState extends State<CommandItem> {
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
    print("objectaaaaaa ${widget.order.questionnaire}");

    return Container(
        height: 200,
        width: 400,
        child: Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 236, 218, 196),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF3C2F1F))),
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              widget.order.models!.length != 0
                  ? Container(
                      width: 120,
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: AppinioSwiper(
                        controller: controller,
                        cardCount: widget.order.models!.length,
                        duration: Duration(milliseconds: 120),
                        loop: true,
                        backgroundCardOffset: Offset(0, 0),
                        cardBuilder: (context, index) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                base64Decode(widget.order.models![index].image
                                    .substring(23)),
                                fit: BoxFit.cover,
                              ));
                        },
                      ),
                    )
                  : Container(
                      width: 120,
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            widget.order.postStyle!,
                            fit: BoxFit.cover,
                          )),
                    ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      "${widget.order.tailor.name}",
                      style: TextStyle(
                        fontFamily: "Nanum_Myeongjo",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Text(
                    //   "${AllSpeciallite}",
                    //   style: TextStyle(
                    //     fontFamily: "Nanum_Myeongjo",
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 21,
                          child: Image.asset("images/calendrier.png"),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${widget.order.orderDate.substring(0, 10)}",
                          style: TextStyle(
                            fontFamily: "Nanum_Myeongjo",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 21,
                          child: Image.asset("images/pending.png"),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${widget.order.status}",
                          style: TextStyle(
                            fontFamily: "Nanum_Myeongjo",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              widget.order.models!.length > 1
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
                  : SizedBox()
            ],
          ),
        ));
  }
}






  //  cardCount:
  //               widget.order.models == null ? 0 : widget.order.models!.length