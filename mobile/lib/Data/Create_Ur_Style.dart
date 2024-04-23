class Jeans {
  static List<JeanObj> jeans = [
    JeanObj(name: "Mini", path: "images/photo1709600798.jpeg"),
    JeanObj(name: "Mini", path: "images/photo1709600798.jpeg"),
    JeanObj(name: "Mini", path: "images/photo1709600798.jpeg"),
    JeanObj(name: "Mini", path: "images/photo1709600798.jpeg")
  ];
}

class JeanObj {
  String name, path;
  JeanObj({required this.name, required this.path});
}

class SweaterObj {
  String name, path;
  SweaterObj({required this.name, required this.path});
}

class Sweater {
  static List<SweaterObj> jeans = [
    SweaterObj(name: "Mini", path: "images/photo1709600798.jpeg"),
    SweaterObj(name: "Mini", path: "images/photo1709600798.jpeg"),
    SweaterObj(name: "Mini", path: "images/photo1709600798.jpeg"),
    SweaterObj(name: "Mini", path: "images/photo1709600798.jpeg")
  ];
}
