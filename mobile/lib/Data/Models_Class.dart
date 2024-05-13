import 'package:projetfinprepa/Data/Tailor_Class.dart';

class Model {
  String id, titel, image, description, category, speciality;
  Tailor? tailor;
  // String? postStyle;
  int price;
  // List<Map<String, dynamic>>? questionnaire;
  String CreatedAt;
  Model(
      {required this.category,
      required this.titel,
      required this.description,
      required this.id,
      required this.speciality,
      required this.tailor,
      required this.CreatedAt,
      required this.price,
      required this.image});
}
