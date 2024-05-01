import 'package:projetfinprepa/Data/Order_class.dart';

class ClientClass {
  String id, name, email, profilePicture;
  String? password;
  String? resetPasswordToken;
  bool verified;
  List<Order>? orders;

  ClientClass(
      {required this.name,
      required this.email,
      required this.id,
      required this.password,
      required this.verified,
      required this.resetPasswordToken,
      required this.profilePicture,
      required this.orders});
}
