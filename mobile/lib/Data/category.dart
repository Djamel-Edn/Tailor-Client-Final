import 'package:flutter/material.dart';

class Categoey_Id {
  String category;
  int id;
  Categoey_Id(this.id, this.category);
}

class CategoeyInSearch_Id {
  String category;
  int id;
  CategoeyInSearch_Id(this.id, this.category);
}

class CategoryDataInSearch {
  static List<CategoeyInSearch_Id> category = [
    CategoeyInSearch_Id(0, "Models"),
    CategoeyInSearch_Id(1, "Tailors"),
  ];
}

class CategoryData {
  static String currentuser = "sido";

  static List<Categoey_Id> category = [
    Categoey_Id(0, "Newest"),
    Categoey_Id(1, "Top"),
    Categoey_Id(2, "Man"),
    Categoey_Id(3, "Woman"),
    Categoey_Id(4, "Man")
  ];

  static TextStyle styleCategoryselected =
      TextStyle(fontSize: 15, fontFamily: "JejuGothic", color: Colors.white);
  static TextStyle styleCategoryunselected = TextStyle(
      fontSize: 15, fontFamily: "JejuGothic", color: Color(0xFF84643D));
}
