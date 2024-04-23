import 'package:http/http.dart';

class Review {
  Client client;
  String id, tailorId, text;
  double rating;
  Review(
      {required this.client,
      required this.rating,
      required this.id,
      required this.tailorId,
      required this.text});
}
