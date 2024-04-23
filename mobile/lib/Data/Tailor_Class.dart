class Tailor {
  // String name,
  //     email,
  //     password,
  //     address,
  //     city,
  //     gender,
  //     Speciality,
  //     description,
  //     verified,
  //     resetPasswordToken,
  //     profilePicture;
  // int phone;
  // List<Order> orders;
  // List<String> reviews;

  // Tailor(
  //     {required this.name,
  //     required this.email,
  //     required this.password,
  //     required this.phone,
  //     required this.city,
  //     required this.gender,
  //     required this.Speciality,
  //     required this.description,
  //     required this.reviews,
  //     required this.verified,
  //     required this.address,
  //     required this.resetPasswordToken,
  //     required this.profilePicture,
  //     required this.orders});

  String name, id, email, password, city, gender, profilePicture;
  bool verified;
  int phone;
  List<dynamic> orders;
  List<dynamic> reviews;

  Tailor(
      {required this.name,
      required this.email,
      required this.id,
      required this.password,
      required this.phone,
      required this.city,
      required this.gender,
      required this.reviews,
      required this.verified,
      required this.profilePicture,
      required this.orders});
}
