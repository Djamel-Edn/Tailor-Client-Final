import 'package:flutter/material.dart';

class CommandItem extends StatelessWidget {
  const CommandItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0xFFF3F1EF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF3C2F1F))),
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("images/bomberJaket.jpeg")),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Text("Nour"),
                Text("Dress"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(
                      width: 3,
                    ),
                    Text("10/03/2004"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.pending),
                    SizedBox(
                      width: 3,
                    ),
                    Text("Pending"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
