class Tailor {
  String? resetPasswordToken;
  String? address;
  String? Speciality;
  String? description;

  String? id, name, email, password, city, gender, profilePicture;
  int? phone;
  var rating;
  List<dynamic>? orders;
  List<dynamic>? reviews;
  List<dynamic>? models;
  bool? verified;

  Tailor(
      {required this.name,
      required this.id,
      required this.models,
      required this.rating,
      required this.email,
      required this.password,
      required this.phone,
      required this.city,
      required this.gender,
      required this.Speciality,
      required this.description,
      required this.reviews,
      required this.verified,
      required this.address,
      required this.resetPasswordToken,
      required this.profilePicture,
      required this.orders});
}
