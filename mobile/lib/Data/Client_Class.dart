import 'package:projetfinprepa/Data/Order_class.dart';

class Client {
  String id, name, email, password, resetPasswordToken, profilePicture;
  bool verified;
  List<Order> orders;

  Client(
      {required this.name,
      required this.email,
      required this.id,
      required this.password,
      required this.verified,
      required this.resetPasswordToken,
      required this.profilePicture,
      required this.orders});
}
